class SubAreasController < ApplicationController

  def create
    if current_user != nil
      sub_area = current_user.sub_areas.build(area: params[:area])
      if sub_area.save
        redirect_to mypage_path(current_user.id)
      else
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def delete
    @area = params[:area]
    if @area != nil && current_user != nil
      @sub_area = current_user.sub_areas.find_by(area: @area)
      if @sub_area.destroy
        redirect_to mypage_path(current_user.id)
      else
        redirect_back(fallback_location: root_path)
      end
    end
  end

end
