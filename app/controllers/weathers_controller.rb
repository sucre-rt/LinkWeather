class WeathersController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  require 'date'
  
  def index
    # gon.api_key = Rails.application.credentials.open_wether[:api_key]
    api_key = Rails.application.credentials.open_wether[:api_key]
    # city = set_city(current_user.my_area)
    city = 'Tokyo'
    uri = URI.parse("http://api.openweathermap.org/data/2.5/forecast?q=#{city},jp&units=metric&APPID=#{api_key}")
    json = Net::HTTP.get(uri)
    @result = JSON.parse(json)
    @today = Date.today
    @now = DateTime.now
  end

end
