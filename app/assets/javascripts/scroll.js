$(document).on('turbolinks:load', function () {
  if ($('ul.pagination a[rel=next]').length) {
    $('#chat-wrap').infiniteScroll({
      path: 'ul.pagination a[rel=next]',
      append: '.chats',
      history: true,
      hideNav: '.pagination',
    });
  }
});