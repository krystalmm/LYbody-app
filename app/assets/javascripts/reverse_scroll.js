$(document).on('turbolinks:load', function () {
  var i = 2;
  $('.chat').scrollTop(1);
  $('.chat').scroll(function () {
    if (($('.chat').scrollTop() == 0) && (i <= parseInt($('.chat').find('ul.pagination last a').prop("search").match(/[0-9]/), 10))) {
      $.ajax({
        url: $(".chat").find("ul.pagination a[rel=next]").prop("search").replace(/[0-9]/, i)
      }).done(function(data) {
        $(".chat").prepend($(data).find(".chat").html());
        $(".chat").scrollTop($(".chat").first().height());
        i++;
      })
    }
  });
});