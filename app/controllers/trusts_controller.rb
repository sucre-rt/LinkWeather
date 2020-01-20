class TrustsController < ApplicationController
  before_action :move_to_login, :set_variables

  def create
    trust = Trust.new(
      valuer_id:     current_user.id,
      good_user_id:  @tweet_user.id
    )
    if trust.save
    else
      flash[:alert] = "TrustStarの登録に失敗しました"
    end
  end

  def delete
    @trust = current_user.valuers.find_by(good_user_id: @tweet_user.id)
    if @trust.destroy
    else
      flash[:alert] = "TrustStarの削除に失敗しました"
    end
  end

  private

  def set_variables
      @tweet_user = User.find(params[:tweet_user])
      @trust_id = ".trust-link-#{ @tweet_user.id }"
  end

  def move_to_login
    redirect_to new_user_session_path unless user_signed_in?
  end

end
