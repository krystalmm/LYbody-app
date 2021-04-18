$(document).on('turbolinks:load', function () {
  $('.loading').on('click', function () {
    $(function () {
      var height = $(window).height();
      $('#wrap').css('display', 'none');
      $('#loader-bg, #loader').height(height).css('display', 'block');
    });

    // ロードが完了したら要素表示する
    $(window).on('load', function () {
      $('#loader-bg').delay(900).fadeOut(800);
      $('#loader').delay(600).fadeOut(300);
      $('#wrap').css('display', 'block');
    });

    // 10秒たったら強制的にローディングを非表示にする
    $(function () {
      setTimeout('stopLoad()', 10000);
    });
  });
});

function stopLoad() {
  $('#wrap').css('display', 'block');
  $('#loader-bg').delay(900).fadeOut(800);
  $('#loader').delay(600).fadeOut(300);
}
