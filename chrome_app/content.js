// content.js

// registers a visit to the given URL
function recordPageView() {
  chrome.runtime.sendMessage({
    "record_page_view": {
      "url": window.location.href
    }
  });
}

// onLoad
recordPageView();

