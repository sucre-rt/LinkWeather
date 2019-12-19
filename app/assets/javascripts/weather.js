$(function(){

  // 現在の天気情報の表示
  let date = $('.information-date:first').text();
  let time = $('.information-time:first').text();
  let icon_url = $('.weather-icon:first').attr('src');
  let weather = $('.main-weather:first').text();
  let temp_max = $('.max-temp:first').text();
  let temp_min = $('.min-temp:first').text();
  let humidity = $('.humidity:first').text();
  let wind = $('.wind:first').text();

  $('.now-date').append(date);
  $('.on-time').append(time);
  $('.now-icon').attr("src",icon_url);
  $('.now-weather').append(weather);
  $('.now-temp-max').append(temp_max);
  $('.now-temp-min').append(temp_min);
  $('.now-humidity').append(humidity);
  $('.now-wind').append(wind);

  // 不快指数の計算・表示
  let num_temp = temp_max.replace(/[^-^0-9^\.]/g,"");
  let num_humidity = humidity.replace(/[^-^0-9^\.]/g,"");
  let discomfort = 0.81 * num_temp + 0.01 * num_humidity * (0.99 * num_temp - 14.3) + 46.3;
  discomfort = Math.round(discomfort);
  $('.discomfort').append(discomfort);

  // 不快指数の説明
  let discomfort_info = ""

  if (discomfort < 55) {
    discomfort_info = "寒い"
  } else if (discomfort >= 55 && discomfort < 60) {
    discomfort_info = "肌寒い"
  } else if (discomfort >= 60 && discomfort < 65 ) {
    discomfort_info = "何も感じない"
  } else if (discomfort >= 65 && discomfort < 70 ) {
    discomfort_info = "快い"
  } else if (discomfort >= 70 && discomfort < 75 ) {
    discomfort_info = "暑くない"
  } else if (discomfort >= 75 && discomfort < 80 ) {
    discomfort_info = "やや暑くない"
  } else if (discomfort >= 80 && discomfort < 85 ) {
    discomfort_info = "暑くて汗が止まらない"
  } else {
    discomfort_info = "暑くてたまらない"
  };

  $('.description').append(discomfort_info);

});

$(function() {
  let sub_area = $('div').hasClass('user-area');
  if (sub_area) {
    $('.city-weather').css('width', '50%');
    $('.right-top').css('width', '25%');
  };
})