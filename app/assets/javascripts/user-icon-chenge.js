$(document).on('turbolinks:load', function () {

  // DOMの生成やページの読み込みがすでに終わっていたらイベントハンドラを直接呼び出す
  if (document.readyState == "interactive" || document.readyState == "complete") {
    handler();
  } else {
    document.addEventListener("load", handler);
  }
});

function handler () {
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
}