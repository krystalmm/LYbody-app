$(document).on('turbolinks:load', function(){
  $("#login-form").validationEngine('attach', {
    promptPosition: "topLeft", scrollOffset: 140
  });
});
