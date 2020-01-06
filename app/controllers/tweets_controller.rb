class TweetsController < ApplicationController
  # アプリ内投稿機能
  include WeathersHelper
  before_action :set_tweet, only: [:destroy, :edit, :update]

  def index
    @tweets = Tweet.all.order("created_at DESC").page(params[:page]).per(10)
    @tweet = Tweet.new
    @image = @tweet.images.build
  end

  def create
    @tweet = current_user.tweets.build(text: tweet_params[:text])
    if @tweet.save
      unless params[:images].blank?
        params[:images][:image].each do |image|
          if image != nil
            @tweet.images.create!(image: image[1], tweet_id: @tweet_id)
          end
        end
      end
      flash[:notice] = "投稿しました"
      redirect_to tweets_path
    else
      flash[:alert] = "本文は必ず入力してください"
      redirect_to tweets_path
    end
  end

  def destroy
    if @tweet.user_id == current_user.id
      if @tweet.destroy
        flash[:notice] = "削除しました"
        redirect_to tweets_path
      else
        flash[:alert] = "削除に失敗しました"
        redirect_to tweets_path
      end
    end
  end

  def edit
  end

  def update
    if @tweet.update(text: update_tweet_params[:text])
      # 画像の更新・追加
      unless params[:images].blank?
        unless params[:images][:image].blank?
          params[:images][:image].each do |img|
            if img[0].to_i < 0 
              @tweet.images.create!(image: img[1], tweet_id: @tweet.id)
            else
              image = Image.find(img[0])
              image.update(image: img[1])
            end
          end
        end
      end
      # 既存画像の削除
      unless params[:delete].blank?
        delete_ids = params[:delete].split(",")
        delete_ids.each do |id|
          image = Image.find(id)
          image.destroy
        end
      end
      flash[:notice] = "変更しました"
      redirect_to tweets_path
    else
      flash[:alert] = "変更に失敗しました"
      redirect_to edit_tweet_path(@tweet.id)
    end
  end

  # weatherページのもっと見るを押した先
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

  def update_tweet_params
    params.require(:tweet).permit(:text, images_attributes: [:image])
  end

  def search_params
    params.permit(:area)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

end
