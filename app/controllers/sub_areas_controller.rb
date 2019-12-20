class SubAreasController < ApplicationController
  before_action :set_variables

  def create
    if current_user != nil
      sub_area = current_user.sub_areas.build(area: params[:area])
      sub_area.save
    end
  end

  def delete
    if @area != nil && current_user != nil
      @sub_area = current_user.sub_areas.find_by(area: @area)
      @sub_area.destroy
    end
  end

  private

  def set_variables
    @area = params[:area]
    @area_id = "#sub-area-link-#{ @area }"
  end

end
