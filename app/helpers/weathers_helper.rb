module WeathersHelper

  def weather_icon
    icons = ["fa fa-umbrella", "fa fa-cloud", "fa fa-sun-o", "fa fa-moon-o", "fa fa-tint", "fa fa-bolt", "fa fa-snowflake-o", "fa fa-star"]
    @icon = icons.sample
  end
  
end
