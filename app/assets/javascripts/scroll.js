$(document).on('turbolinks:load', function () {
  if ($('#chat-window').length == 0 ) {
    return;
  }

  var scrollHeight = document.getElementById("chat-window").scrollHeight;
  document.getElementById("chat-window").scrollTop = scrollHeight;
});

