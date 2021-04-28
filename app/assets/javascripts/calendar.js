$(document).on('turbolinks:load', function () {
  if($('#calendar').length == 0){
    return;
  }

  $('#calendar').empty();

  $('#calendar').fullCalendar({

    googleCalendarApiKey: 'AIzaSyAwUYezhMS-s1MSN2fVyuA8_I-OufFUT5E',

    eventSources: [
      {
        googleCalendarId: 'ja.japanese#holiday@group.v.calendar.google.com',
        className: 'event_holiday',
        rendering: 'background',
      },
    ],

    lang: 'ja',

    selectable: true,

    events: {
      url: '/reservations.json',
      data:{
        instructor_id: getInstructorId()
      }
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
      setPulldownDay(pulldown_option_year, day.format('YYYY'));

      pulldown_option_month = document.getElementById("reservation_start_time_2i").getElementsByTagName('option');
      setPulldownDay(pulldown_option_month, day.format('M'));

      pulldown_option_day = document.getElementById("reservation_start_time_3i").getElementsByTagName('option');
      setPulldownDay(pulldown_option_day, day.format('D'));

      setPulldownTime(day);
    },
  });
});

// ユーザーのマイページの予約変更モーダルの時間表示
$(document).on('turbolinks:load', function () {
  $('#userReservationModalButton').on('click', function () {
    $('#userReservationModal').modal('show');

    // 何も選択してない状態の日時取得
    var year = $('#reservation_start_time_1i option:selected').text();
    var month = $('#reservation_start_time_2i option:selected').text();
    var day = $('#reservation_start_time_3i option:selected').text();
    var defaultDate = moment(year + month + day);

    setPulldownTime(defaultDate);

    // 選択された状態の日時取得
    $('#reservation_start_time_1i, #reservation_start_time_2i, #reservation_start_time_3i').change(function () {
      var selectedYear = $('#reservation_start_time_1i').val();

      if ($('#reservation_start_time_2i').val() < 10) {
        var selectedMonth = 0 + $('#reservation_start_time_2i').val();
      } else {
        var selectedMonth = $('#reservation_start_time_2i').val();
      };

      var selectedDay = $('#reservation_start_time_3i').val();
      var selectedDate = moment(selectedYear + selectedMonth + selectedDay);

      setPulldownTime(selectedDate);
    });
  });
});

// クエリパラメータからインストラクターIDを取得する
function getInstructorId() {
  var url = window.location.href;
  var name = "instructor_id";
  var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
  results = regex.exec(url);
  return results[2];
};

// プルダウンの年月日をクリックされた日にちに設定する
function setPulldownDay(pulldownOption, dayFormat) {
  for ( i = 0; i < pulldownOption.length; i++ ) {
    if (pulldownOption[i].value == dayFormat) {
      pulldownOption[i].selected = true;
      break;
    }
  }
}


// プルダウンの時間選択を曜日で分ける
function setPulldownTime(day) {
  pulldown_option_hour = document.getElementById("reservation_start_time_4i").getElementsByTagName('option');

  var reset = "";
  var none = "display:none;"

  // 土日の場合
  if (day.format('d')=="0" || day.format('d') == "6"){
    setPulldownTimeStyle(reset, none, 9);

  // 平日の場合
  }else{
    setPulldownTimeStyle(none, reset, 17);
  }
}

function setPulldownTimeStyle(before17Style, after18Style, selectedNumber) {
  for ( i = 0; i < pulldown_option_hour.length; i++ ) {
    if (parseInt(pulldown_option_hour[i].value) < 17) {
      pulldown_option_hour[i].style = before17Style;
    }
    if(parseInt(pulldown_option_hour[i].value) > 18) {
      pulldown_option_hour[i].style = after18Style;
    }
    if (parseInt(pulldown_option_hour[i].value) == selectedNumber) {
      pulldown_option_hour[i].selected = true;
    }
  }
}
