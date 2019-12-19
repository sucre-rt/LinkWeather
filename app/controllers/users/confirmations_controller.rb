# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # マイページ
  def show
    if current_user.my_area.blank?
      @area = "東京都"
      area_result = set_area(@area)
      lon, lat = area_result['Feature'][0]['Geometry']['Coordinates'].split(',')
      @result = get_weather(lat, lon)
      @result_li = @result["list"]
      @today = Date.today
      @now = DateTime.now
      @tweets = Tweet.tweet_like(@area).page(params[:page]).per(10)
      unless current_user.sub_areas.blank?
        @sub_areas = current_user.sub_areas
      end
    else
      @area = current_user.my_area
      @tweets = Tweet.tweet_like(@area).page(params[:page]).per(10)
      area_result = set_area(@area)
      # マイエリアの読みこみ
      unless area_result["ResultInfo"]["Count"] == 0
        lon, lat = area_result['Feature'][0]['Geometry']['Coordinates'].split(',')
        @result = get_weather(lat, lon)
        @result_li = @result["list"]
        @today = Date.today
        @now = DateTime.now
      else
        @result = ""
      end
      unless current_user.sub_areas.blank?
        @sub_areas = current_user.sub_areas
      end
    end
  end

  protected

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

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
