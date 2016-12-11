// background.js

function updateIcon(path, tab_id) {
  chrome.browserAction.setIcon({
    path: path,
    tabId: tab_id
  });
}

chrome.runtime.onMessage.addListener(
  function(request, sender, sendResponse) {
    if (request.record_page_view) {
      var xhr = new XMLHttpRequest();
      xhr.open('POST', 'http://192.168.99.100:9292/page_views');
      xhr.setRequestHeader('Content-Type', 'application/json');
      xhr.onload = function() {
        if (xhr.status === 201) {
          var response = JSON.parse(xhr.response);
          var path = `images/icons/${response.rating}.png`;
          updateIcon(
            path,
            sender.tab.id
          )
        } else if (xhr.status !== 201) {
          console.log("Failed to record News Trust pageview!");
        }
      };
      xhr.send(JSON.stringify({
        url: request.record_page_view.url,
        uuid: newsTrustUuid
      }));
    }
  }
)

function getRandomToken() {
    // E.g. 8 * 32 = 256 bits token
    var randomPool = new Uint8Array(32);
    crypto.getRandomValues(randomPool);
    var hex = '';
    for (var i = 0; i < randomPool.length; ++i) {
        hex += randomPool[i].toString(16);
    }
    // E.g. db18458e2782b2b77e36769c569e263a53885a9944dd0a861e5064eac16f1a
    return hex;
}

function setTokenGlobal(userid) {
  // TODO: Use user id for authentication or whatever you want.
 newsTrustUuid = userid
}

chrome.storage.sync.get('userid', function(items) {
  var userid = items.userid;
  if (userid) {
    setTokenGlobal(userid);
  } else {
    userid = getRandomToken();
    chrome.storage.sync.set({userid: userid}, function() {
      setTokenGlobal(userid);
    });
  }
})

