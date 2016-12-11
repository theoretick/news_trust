// popup.js

document.addEventListener('DOMContentLoaded', () => {
  let reportPageButton = document.getElementById('report_page');

  reportPageButton.addEventListener('click', () => {
    chrome.tabs.getSelected(null, (tab) => {
      chrome.tabs.query(
        { active: true, currentWindow: true },
        (tabs) => {
          let current_tab = tabs[0]

          chrome.runtime.sendMessage({
            "record_page_flag": {
              "url": tab.url,
              "tab_id": current_tab.id
            }
          }, () => {
            // Close popup on message send
            window.close();
          });
        })
    });
  }, false);
}, false);

