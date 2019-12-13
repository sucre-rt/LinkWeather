class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all.order("created_at DESC")
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
    if tweet.save
      redirect_to tweets_path
    else
      redirect_to tweets_path
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text).merge(user_id: current_user.id)
  end

end
