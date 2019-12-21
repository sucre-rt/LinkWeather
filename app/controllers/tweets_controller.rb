class TweetsController < ApplicationController
  # アプリ内投稿機能

  def index
    @tweets = Tweet.all.order("created_at DESC").page(params[:page]).per(10)
    @tweet = Tweet.new
    @image = @tweet.images.build
    icons = ["fa fa-umbrella", "fa fa-cloud", "fa fa-sun-o", "fa fa-moon-o", "fa fa-tint", "fa fa-bolt", "fa fa-snowflake-o", "fa fa-star"]
    @icon = icons.sample
  end

  def create
    @tweet = current_user.tweets.build(text: tweet_params[:text])
    if @tweet.save
      unless params[:images].blank?
        params[:images][":image"].each do |image|
          @tweet.images.create!(image: image, tweet_id: @tweet_id)
        end
      end
      redirect_to tweets_path
    else
      redirect_to root_path
    end
  end

  def result
    @area = search_params[:area]
    @tweets = Tweet.tweet_like(@area).page(params[:page]).per(10)
    @tweet = Tweet.new
    @image = @tweet.images.build
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text, 
    images_attributes: [:id, :image, :tweet_id]
    )
  end

  def search_params
    params.permit(:area)
  end

end
