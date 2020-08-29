// for server

var host;
var port;
var socket;

// for stream
let localStream;
let remoteStream;

// for video
let localVideo = document.getElementById('localVideo');
let remoteVideo = document.querySelector('#remoteVideo');

console.log(localVideo);

const mediaStreamConstraints = {
	video : true
}

function getLocalMediaStream() {

	localVideo = document.getElementById('localVideo');
	console.log(localVideo);
	const stream = navigator.mediaDevices.getUserMedia({
		video : true
	})
	localVideo.srcObject = stream;

	/*
	 * navigator.mediaDevices.getUserMedia(mediaStreamConstraints)
	 * .then(gotStream) .catch(function(e) { alert('getUserMedia() error: ' +
	 * e.name); });
	 */
}

function gotStream(stream) {
	localVideo.srcObject = stream;
	console.log('Adding local stream.');
	localStream = stream;
	/*
	 * 아직 구현 안된 부분. sendMessage('got user media'); if(isInitiator) {
	 * maybeStart(); }
	 */
}

function println(data) {
	console.log(data);
	$('#result').append('<p>' + data + '</p>')
}

// 서버에 연결하는 함수 정의
function connectToServer() {

	var options = {
		'forceNew' : true
	};
	var url = "http://" + host + ":" + port;
	println(url);
	socket = io.connect(url, options);

	socket.on('connect', function() {
		println("웹 소켓 서버에 연결되었습니다. : " + url);
	});

	socket.on('disconnect', function() {
		println('웹 소켓 연결이 종료되었습니다.');
	});
}

// 문서정렬 후 로딩.
$(function() {
	$("#connectButton").bind('click', function(event) {
		println('connectButton이 클릭되었습니다.');
		host = $('#hostInput').val();
		port = $('#portInput').val();

		// jinwoo
		getLocalMediaStream();

		// connectToServer();
	})
})