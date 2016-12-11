// background.js

function updateIcon(path, tab_id) {
  chrome.browserAction.setIcon({
    path: path,
    tabId: tab_id
  });
}

function apiPost(path, url, tab_id) {
  let xhr = new XMLHttpRequest();
  xhr.open('POST', `http://192.168.99.100:9292/${path}`);
  xhr.setRequestHeader('Content-Type', 'application/json');
  xhr.onload = function() {
    if (xhr.status === 201) {
      let response = JSON.parse(xhr.response);
      let icon_path = `images/icons/${response.rating}.png`;
      updateIcon(icon_path, tab_id);
    } else {
      console.log(`Failure on api request_path: ${path}`);
    }
  };
  xhr.send(JSON.stringify({
    url: url,
    uuid: newsTrustUuid
  }));
}

function recordPageView(url, tab_id) {
  apiPost('page_views', url, tab_id)
}

function recordPageFlag(url, tab_id) {
  apiPost('flags', url, tab_id)
}

chrome.runtime.onMessage.addListener(
  (request, sender, sendResponse) => {
    if (request.record_page_view) {
      recordPageView(request.record_page_view.url, sender.tab.id)
    } else if (request.record_page_flag) {
      let { url, tab_id } = request.record_page_flag

      recordPageFlag(url, tab_id)
      sendResponse()
    }
  }
)

function getRandomToken() {
  // E.g. 8 * 32 = 256 bits token
  let randomPool = new Uint8Array(32);
  crypto.getRandomValues(randomPool);
  let hex = '';

  for (let i = 0; i < randomPool.length; ++i) {
      hex += randomPool[i].toString(16);
  }

  return hex;
}

function setTokenGlobal(userid) {
  newsTrustUuid = userid
}

chrome.storage.sync.get('userid', (items) => {
  let userid = items.userid;

  if (userid) {
    setTokenGlobal(userid);
  } else {
    userid = getRandomToken();
    chrome.storage.sync.set({ userid: userid }, () => {
      setTokenGlobal(userid);
    });
  }
})

