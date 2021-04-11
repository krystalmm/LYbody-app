$(document).on('turbolinks:load', function () {
  $(window).keydown(function (e) {
    // mac => cmd & enter, windows => ctrl & enter
    if (!((e.metaKey && e.keyCode == 13) || (e.ctrlKey && e.keyCode == 13))) return;

    var target = $(e.target);
    if (target.is('textarea')) {
      target.closest('form').submit();
    }
  });

  var textarea = document.getElementById('chat-textarea');
  var defaultHeight = textarea.clientHeight;

  textarea.addEventListener('input', function () {
    // １行に戻った時に元に戻す処理
    textarea.style.height = defaultHeight + 'px';

    var scrollHeight = textarea.scrollHeight;
    textarea.style.height = scrollHeight + 'px';
  });
});