$(document).on('turbolinks:load', function () {
  var i = 2;
  chatwindow = document.getElementById('chat-window');
  $('#chat-window').scrollTop(1);
  if (chatwindow == null) {
    return;
  }
  chatwindow.onscroll = function () {
    // 一番上にスクロールされた時の処理
    if (($('#chat-window').scrollTop() == 0) && (i <= parseInt($("#chat-window").find("ul.pagination a.last").prop("search").match(/[0-9]/), 10))) {
      $.ajax({
        // roomコントローラのpaginationアクション
        url: location.href + '/' + i
      }).done(function () {
        i++;
      })
    }
  };
});
