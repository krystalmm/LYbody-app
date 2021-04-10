$(document).on('turbolinks:load', function () {
  $('#calendar').fullCalendar({

    googleCalendarApiKey: 'AIzaSyAwUYezhMS-s1MSN2fVyuA8_I-OufFUT5E',

    eventSources: [
      {
        googleCalendarId: 'ja.japanese#holiday@group.v.calendar.google.com',
        className: 'event_holiday',
        rendering: 'background',
      },
      {
        googleCalendarId: 'n96qd41t70nuol4kpc2c3uahi0@group.calendar.google.com',
      },
    ],

    lang: 'ja',

    selectable: true,

    events: {
      url: '/reservations.json',
    },

    header: {
      left: "prev",
      center: "title",
      right: "today next"
    },

    titleFormat: "YYYY年　M月",

    timeFormat: "HH:mm",

    dayClick: function(day) {
      $('#new_reservation').modal('show');
      pulldown_option_year = document.getElementById("reservation_start_time_1i").getElementsByTagName('option');
      for ( i = 0; i < pulldown_option_year.length; i++ ) {
        if (pulldown_option_year[i].value == day.format('YYYY')) {
          pulldown_option_year[i].selected = true;
          break;
        }
      }

      pulldown_option_month = document.getElementById("reservation_start_time_2i").getElementsByTagName('option');
      for ( i = 0; i < pulldown_option_month.length; i++) {
        if (pulldown_option_month[i].value == day.format('M')) {
          pulldown_option_month[i].selected = true;
          break;
        }
      }

      pulldown_option_day = document.getElementById("reservation_start_time_3i").getElementsByTagName('option');
      for ( i = 0; i < pulldown_option_day.length; i++ ) {
        if (pulldown_option_day[i].value == day.format('D')) {
          pulldown_option_day[i].selected = true;
          break;
        }
      }


      // var selectedDay = document.getElementById("selected-day");
      // selectedDay.value = day.format();
    },
  });
});

