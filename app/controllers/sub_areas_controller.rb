class SubAreasController < ApplicationController
  before_action :move_to_login, :set_variables

  def create
    sub_area = current_user.sub_areas.build(area: params[:area])
    if sub_area.save
    else
      flash[:alert] = "サブエリアの登録に失敗しました"
    end
  end

  def delete
    if @area != ""
      @sub_area = current_user.sub_areas.find_by(area: @area)
      if @sub_area.destroy
      else
        flash[:alert] = "サブエリアの削除に失敗しました"
      end
    else
      flash[:alert] = "サブエリアの削除に失敗しました"
    end
  end

  private

  def set_variables
    @area = params[:area]
    @area_id = "#sub-area-link-#{ @area }"
  end

  def move_to_login
    redirect_to new_user_session_path unless user_signed_in?
  end

end
