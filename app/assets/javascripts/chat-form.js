$(document).on('turbolinks:load', function () {
  if($('#chat-textarea').length == 0){
    return;
  }

  // 特定のキーでsubmitする
  $(window).keydown(function (e) {
    // mac => cmd & enter, windows => ctrl & enter
    if (!((e.metaKey && e.keyCode == 13) || (e.ctrlKey && e.keyCode == 13))) return;

    var target = $(e.target);
    if (target.is('textarea')) {
      Rails.fire(target.closest('form')[0],'submit');
    }
  });

  // 自動で改行させる
  var textarea = document.getElementById('chat-textarea');
  var defaultHeight = textarea.clientHeight;

  textarea.addEventListener('input', function () {
    // textareaのデフォルトの高さ（これがないと行を減らしていく時に自動で高さが減らない）
    textarea.style.height = defaultHeight + 'px';

    var scrollHeight = textarea.scrollHeight;
    textarea.style.height = scrollHeight + 'px';
  });
});
