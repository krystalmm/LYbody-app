$(document).on('turbolinks:load', function(){
  $("#login-form").validationEngine('attach', {
    promptPosition: "topLeft", scrollOffset: 140
  });
});

$(document).on('turbolinks:load', function(){
  $('#user-form').validationEngine('attach', {
    promptPosition: "topLeft", scrollOffset: 140
  });
});

$(document).on('turbolinks:load', function(){
  $('#contact-form').validationEngine('attach', {
    promptPosition: "topLeft", scrollOffset: 140
  });
});