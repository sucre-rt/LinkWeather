class WeathersController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  require 'date'

  def index
    # yahoodev
    client_id = Rails.application.credentials.yahoo[:client_id]
    city = search_params[:city]
    uri = URI.parse("https://map.yahooapis.jp/geocode/V1/geoCoder?appid=#{client_id}&query=#{URI.encode(city)}&output=json")
    json = Net::HTTP.get(uri)
    area_result = JSON.parse!(json)
    unless area_result["ResultInfo"]["Count"] == 0
      lon, lat = area_result['Feature'][0]['Geometry']['Coordinates'].split(',')
      # openweather
      api_key = Rails.application.credentials.open_wether[:api_key]
      uri = URI.parse("http://api.openweathermap.org/data/2.5/forecast?lat=#{lat}&lon=#{lon}&units=metric&APPID=#{api_key}&lang=ja&units=metric")
      json = Net::HTTP.get(uri)
      @result = JSON.parse(json)
      @result_li = @result["list"]
      @area = search_params[:city]
      @today = Date.today
      @now = DateTime.now
    else
      @result = ""
    end
  end

  private

  def search_params
    params.permit(:city)
  end
end
