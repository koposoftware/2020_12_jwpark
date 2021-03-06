/**
 * 
 */
function requestScreenStreamId(port, msg) {
  const sendMessage = {};
  const tab = port.sender.tab;
  tab.url = msg.url;

  chrome.desktopCapture.chooseDesktopMedia(
    ["screen", "window", "tab"],
    tab,
    streamId => {
      if (streamId) {
        sendMessage.streamId = streamId;
        //...
      } else {
        // Stream Id를 가져오는데 실패한 경우
        //...
      }
    }
  );

  port.postMessage(sendMessage);
}

// 메시지는 개발자 임의로 정의하여 사용한다.
chrome.runtime.onConnect.addListener(port => {
  port.onMessage.addListener(msg => {
    if (msg.type === "REQUEST_SCREEN_STREAM_ID") {
      requestScreenStreamId(port, msg);
    }
    // ...
  });
});

