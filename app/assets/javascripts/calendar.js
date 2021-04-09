$(document).on('turbolinks:load', function () {
  $('#calendar').fullCalendar({
    lang: 'ja',

    selectable: true,

    events: '/events.json',

    header: {
      left: "prev",
      center: "title",
      right: "today next"
    },

    titleFormat: "YYYY年　M月",

    timeFormat: "HH:mm",

    select: function(startTime, endTime) {
      $('#new_reservation').modal('show');
    }
  });

  $('#new_reservation').on('show.bs.modal', function(event) {
    var modal = $(this);
    modal.find('.modal-body').text('');
  });
});
