$(document).on('turbolinks:load', function () {
  if ($('ul.pagination a[rel=next]').length) {
    $('#chat-wrap').infiniteScroll({
      path: 'ul.pagination a[rel=next]',
      append: '.chats',
      history: true,
      hideNav: '.pagination',
    });
  }

  // var chat = document.getElementById("chat-wrap");
  // var bottom = chat.scrollHeight - chat.clientHeight;
  // chat.scroll(0, bottom);
});