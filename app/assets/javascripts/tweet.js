// ツイート画像投稿
$(function() {
  function prevHtml(file, num) {
            html = `<div class="image-prev-box image-prev" data-num="${num}">
                      <img src="${file}" class="image-show">
                      <button class="image-delete" type="button">削除</button>
                    </div>`
            return html
  }

  function imageFormHtml(num) {
          html = `<div class="image-upload" data-num="${num}">
                    <input multiple="multiple" name="images[image][-${num + 1}]" type="file" class="upload_tweet_image"  id="upload_img">
                    <input type="hidden" name="tweet[images_attributes][0][id]">
                  </div>`
          return html
  }

  let input_box = $('.image-form-box');
  let num = 0
  $(document).on('change', '#upload_img,#upload_img_last',function(e) {
    e.preventDefault(); 
    let file = $(this).prop('files')[0];
    let input = imageFormHtml(num + 1);
    let form_check = $(input_box).find('.upload_tweet_image').length
    let already_input = $('.already-image').length
    if (form_check + already_input < 6){
      input_box.prepend(input);
    };

    if (file != null) {
      $(this).hide();     // 選択済みのinputを隠す

      // プレビュー表示
      let reader = new FileReader();
      reader.onload = function (e) {
        let html = prevHtml(e.target.result, num - 1);
        $('.image-prev-all').append(html);
      }
      reader.readAsDataURL(file);
    };

    num += 1

  });

  // 画像の削除
  $(document).on('click', ".image-delete", function(e) {
    e.preventDefault(); 
    let img_box = $(this).parent();
    let img_num = $(img_box).data('num');
    let empty_form = 0;
    $(input_box).find('.upload_tweet_image').each(function (i, form) {
      if (form.value) {
        let file_src = $(form).parent().data('num');
        if (file_src == img_num) {
          $(form).parent().remove();
        };
      } else {
        empty_form += 1
      }
    });
    $(img_box).remove();

    // 画像が5つ以下で新規フォームがなければ追加する
    let input = imageFormHtml(num);
    if (empty_form == 0){
      input_box.append(input);
    };
  });

  // ツイート編集
  let edit_input_box = $('.edit-image-form');
  let already_input = $('.already-image').length

  if (already_input < 6) {    // フォームの追加
    edit_input_box.append(imageFormHtml(num))
  }

  $(document).on('click', '.already-image-delete', function(e){
    let img_id = $(this).data('delete');
    let delete_form = $('.edit-image-form').find("input:hidden[name=delete]");
    let get_id = $(delete_form).val();
    // 削除するidをinputのvalueに格納
    $(delete_form).val(img_id + "," + get_id);
    // 表示を隠す
    let delete_box = ".already-image-" + img_id
    $(delete_box).hide();
  });

})


// ツイート済み画像拡大
$(function() {
  $('#popup-background').hide();
  $('#popup-item').hide();

  function imgload(imgsource){
    $('#popup-background').fadeIn(function(){
        // 画像の左上が中心にきてしまうため、ネガティブマージンで調整
        let item_hieght_margin = (imgsource.height / 2) * -1;
        let item_width_margin = (imgsource.width / 2) * -1;
        let cssObj = {
            marginTop: item_hieght_margin,
            marginLeft: item_width_margin,
            width: imgsource.width,
            height: imgsource.height
        }
        $('#popup-item').css(cssObj).fadeIn(100);
    });
  };

  $(document).on('click', '.expansion-image', function(e){
    e.preventDefault(); 
    // クリックされた画像の情報を取得
    let img = new Image();
    let img_src = this.href;

    $(img).load(function() {
      $('#popup-item').attr('src', img_src);
      $('#popup-item').bind('load', function(){
        imgload(img);
      });
    });
    img.src = img_src;    // Image()に画像を読み込ませる

    $('#popup-background, #popup-item').bind('click', function(){
      $('#popup-background').fadeOut();
      $('#popup-item').fadeOut();
    });
  });
});

// スクロール読み込み
$(function() {
  $(window).on('scroll', function(e) {
    e.preventDefault(); 
    scrollHeight = $(document).height();
    scrollPosition = $(window).height() + $(window).scrollTop();
    if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.1) {
      $('.jscroll').jscroll({
        contentSelector: '.jscroll',
        nextSelector: 'span.next:last a'
      });
    };
  });
})