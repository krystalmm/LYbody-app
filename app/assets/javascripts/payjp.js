$(document).on('turbolinks:load', function () {
  $(function () {
    Payjp.setPublicKey(gon.payjpPublicKey);
    $('#token_submit').on('click', function(e) {
      e.preventDefault();
      let card = {
        number: $('#card_number').val(),
        cvc: $('#cvc').val(),
        exp_month: $('#exp_month').val(),
        exp_year: $('#exp_year').val(),
      };

      Payjp.createToken(card, function(status, response) {
        if (status === 200) {
          $('#card_number').removeAttr('name');
          $('#cvc').removeAttr('name');
          $('#exp_month').removeAttr('name');
          $('#exp_year').removeAttr('name');

          let token = response.id;
          $('#card-form').append(`<input type="hidden" name="payjp-token" value="${token}">`);
          $('#card-form').get(0).submit();
        } else {
          $('#token_submit').prop('disabled', false);
          alert('カード情報が正しくありません。');
        }
      })
    });
  });
});