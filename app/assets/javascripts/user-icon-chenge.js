$(document).on('turbolinks:load', function () {
  window.addEventListener('load', function () {
    const uploader = document.querySelector('.uploader');
    if(uploader == null){
      return;
    }
    uploader.addEventListener('change', function (e) {
      const file = uploader.files[0];
      const reader = new FileReader();
      reader.readAsDataURL(file);

      // 読み込みが完了したらformをsubmitする
      reader.onload = function () {
        const form = document.getElementById('icon-form');
        form.submit();
      }
    });
  });
});
