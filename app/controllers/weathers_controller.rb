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
      @tweets = Tweet.search(@area, @today).page(params[:page]).per(10)
      # twitter検索
      twitter_search(@area)
      # ユーザーエリアリスト
      if user_signed_in?
        unless current_user.sub_areas.blank?
          @sub_areas = current_user.sub_areas
        end
      end
      # 天気情報
      area_result = set_area(@area)
      unless area_result["ResultInfo"]["Count"] == 0
        lon, lat = area_result['Feature'][0]['Geometry']['Coordinates'].split(',')
        @result = get_weather(lat, lon)
        @result_li = @result["list"]
        @now = DateTime.now
      else
        @result = ""
      end
    end
  end


  private

  # yahooジオコーダで緯度経度取得
  def set_area(area)
    client_id = Rails.application.credentials.yahoo[:client_id]
    uri = URI.parse("https://map.yahooapis.jp/geocode/V1/geoCoder?appid=#{client_id}&query=#{URI.encode(area)}&output=json")
    json = Net::HTTP.get(uri)
    JSON.parse!(json)
  end

  # openweathermapから緯度・経度を用いて天気情報取得
  def get_weather(lat, lon)
    api_key = Rails.application.credentials.open_wether[:api_key]
    uri = URI.parse("http://api.openweathermap.org/data/2.5/forecast?lat=#{lat}&lon=#{lon}&units=metric&APPID=#{api_key}&lang=ja&units=metric")
    json = Net::HTTP.get(uri)
    JSON.parse(json)
  end

  # ツイッター検索
  def twitter_search(keyword)
    search_option = { count: 10, lang: 'ja', result_type: 'recent', exclude: 'retweets', tweet_mode: 'extended' }
    @twitter_tweets = twitter_client.search("##{keyword} OR #{keyword} AND #天気 OR 天気 ", search_option)
    begin
      @twitter_tweets.take(10).each do |tw|
        { tweet_link: "https://twitter.com/#{tw.user.screen_name}/status/#{tw.id}" }
      end
    rescue
      @twitter_tweets = []
    end
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key         = Rails.application.credentials.twitter[:api_key]
      config.consumer_secret      = Rails.application.credentials.twitter[:secret_api_key]
    end
  end

  def search_params
    params.permit(:city)
  end

end
