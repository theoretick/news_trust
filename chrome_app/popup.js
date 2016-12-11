document.addEventListener('DOMContentLoaded', function() {
  var reportPageButton = document.getElementById('report_page');
  reportPageButton.addEventListener('click', function() {

    chrome.tabs.getSelected(null, function(tab) {
      var form = document.createElement('form');
      form.action = 'http://192.168.99.100:9292/flags';
      form.method = 'post';
      var input = document.createElement('input');
      input.type = 'hidden';
      input.name = 'url';
      input.value = tab.url;
      form.appendChild(input);
      document.body.appendChild(form);
      form.submit();
    });
  }, false);
}, false);

