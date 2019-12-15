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
                    <input multiple="multiple" name="images[:image][]" type="file" class="upload_tweet_image"  id="upload_img">
                    <input type="hidden" name="tweet[images_attributes][0][id]">
                  </div>`
          return html
  }

  let input_box = $('.image-form-box');
  let num = 0
  $(document).on('change', '#upload_img,#upload_img_last',function(e) {
    let file = $(this).prop('files')[0];
    let input = imageFormHtml(num + 1);
    let form_check = $(input_box).find('.upload_tweet_image').length
    if (form_check < 6){
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
})