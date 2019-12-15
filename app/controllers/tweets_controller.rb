class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all.order("created_at DESC")
    @tweet = Tweet.new
    @image = @tweet.images.build
  end

  def create
    @tweet = current_user.tweets.build(text: tweet_params[:text])
    if @tweet.save
      params[:images][":image"].each do |image|
        @tweet.images.create!(image: image, tweet_id: @tweet_id)
      end
      redirect_to tweets_path
    else
      redirect_to root_path
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text, 
    images_attributes: [:id, :image, :tweet_id]
    )
  end

end
