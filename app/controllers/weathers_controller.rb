class WeathersController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  require 'date'

  def index
    if search_params[:city].blank?
      @area = ""
    else
      @area = search_params[:city]
      # 投稿検索
      @today = Date.today
      @tweets = Tweet.search(@area, @today)

      # 天気情報
      area_result = set_area(@area)
      unless area_result["ResultInfo"]["Count"] == 0
        lon, lat = area_result['Feature'][0]['Geometry']['Coordinates'].split(',')
        @result = get_weather(lat, lon)
        @result_li = @result["list"]
        @area = search_params[:city]
        @now = DateTime.now
      else
        @result = ""
      end
    end
  end

  private

  def set_area(area)
    client_id = Rails.application.credentials.yahoo[:client_id]
    uri = URI.parse("https://map.yahooapis.jp/geocode/V1/geoCoder?appid=#{client_id}&query=#{URI.encode(area)}&output=json")
    json = Net::HTTP.get(uri)
    JSON.parse!(json)
  end

  def get_weather(lat, lon)
    api_key = Rails.application.credentials.open_wether[:api_key]
    uri = URI.parse("http://api.openweathermap.org/data/2.5/forecast?lat=#{lat}&lon=#{lon}&units=metric&APPID=#{api_key}&lang=ja&units=metric")
    json = Net::HTTP.get(uri)
    JSON.parse(json)
  end

  def search_params
    params.permit(:city)
  end
end
