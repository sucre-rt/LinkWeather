// カレントページ
$(function() {
  let page = $('.forecast-title').text().slice(0, -3);
  let cssObj = {
    'background-color': '#fdd35c',
    'pointer-events': 'none'
}
  $('.set-area').each(function(i, area) {
    let area_name = $(area).text().trim();
    if (area_name == page) {
      $(area).css(cssObj);
    };
  });
})