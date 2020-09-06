<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
console.log('${userVO.id}')
workType = '';

//var url = 'https://192.168.217.52:1337';
//var url = 'https://localhost:1337';
var url = 'https://192.168.0.7:1337';

var socket;

var room = '${userVO.id}';

// 내가 만든 사람임을 나타내는 비트. 오퍼와 앤서를 구분하기 위해서 필요한 것 같음.
var isInitiator = false;
// 두명의 클라이언트가 모두 채널에 접속완료하여 채널이 서비스 준비가 되었을 때.
var isChannelReady = false;
var isStarted = false;

var pcConfig = {
		'iceServers' : [
			{
				'urls' : 'stun:stun.l.google.com:19302'
			},
			{
				'urls' : 'stun:stun1.l.google.com:19302'
			},
			{
			    'urls' : 'turn:turn.anyfirewall.com:443?transport=tcp',
			    'credential' : 'webrtc',
			    'username' : 'webrtc'
			}
		]
}

requestTurn();

// for stream
let localStream;
//let remoteStream;
//let remoteStream;
	let remoteStream = new MediaStream();

// shareVideo
let shareStream;
//////////////

function requestTurn(/*turnURL*/) {
	var turnExists = false;
	for(var i in pcConfig.iceServers) {
		if(pcConfig.iceServers[i].urls.substr(0, 5) === 'turn:'){
			turnExists = true;
			turnReady = true;
			break;
		}
	}
}

var pc = new RTCPeerConnection(pcConfig);

// shareVideo
var sharePc = new RTCPeerConnection(pcConfig);
/////////////

// for video
let localVideo = document.getElementById('localVideo');
let remoteVideo = document.querySelector('#remoteVideo');

// shareVideo
let screenShareVideo = document.getElementById('screenShareVideo');
/////////////


getLocalMediaStream();

//const mediaStreamConstraints = {
//	video : true
//}

function getLocalMediaStream() {
	
	
	navigator.mediaDevices.getUserMedia({video : true, audio : true})
	//navigator.mediaDevices.getUserMedia({video: {width: {exact: 640}, height: {exact: 480}}, audio : true})
	.then(gotStream)
	.then(connectToServer)
	//.catch((err) => console.log(err.name, err.message));
}

function gotStream(stream) {

	localVideo.srcObject = stream;
	console.log('Adding local stream.');
	localStream = stream;
	
	console.log('locatStream : ' + localStream.getAudioTracks());
	console.log('locatStream label: ' + localStream.getAudioTracks()[0].label);
}


// 서버에 연결하는 함수 정의
function connectToServer() {

	var options = {
		'forceNew' : true
	};
	//var url = "http://" + host + ":" + port;
	//var url = "https://" + host + ":" + port;
	
	socket = io.connect(url, options);

	socket.on('connect', function() {
		
		
	///////////////////// socket server로부터의 이벤트 정의 //////////////////
	
		// 내가 방을 만든 상황일 때에 날아오는 이벤트
		socket.on('created', function(room) {
			console.log('Created room ' + room);
			isInitiator = true;
		})
		
		// 방이 꽉차서 들어가지 못했을 때 날아오는 이벤트
		socket.on('full', function(room) {
			console.log('Room' + room + 'is full');
		})
		
		// 1명이 있던 방에 누군가가 join되었음을 알리는 이벤트. 양 측 모두게 날아옴. // ChannelReady상태 set
		socket.on('join', function(room) {
			console.log('Another peer made a request to join room ' + room);
			console.log('This peer is the initiator of room ' + room + '!');
			isChannelReady = true;
			console.log('방 생성 완료!');
		})
		
		// 들어가려는 방이 이미 만들어져 있고 내가 그 방에 들어갔을 때에 나에게만 날아오는 이벤트. // ChannelReady상태 set
		socket.on('joined', function(room) {
			console.log('joined: ' + room);
			isChannelReady = true;
		})
		
		socket.on('roomReady', function(room) {
			
		})
		
		socket.on('chat', function(msg){
			let str = '';
			str += '<strong> 텔러 : ' + msg + '</strong>';
			str += '<br>'
			$('#chat').append(str);
		}) 
		
		// 'message' event 날아왔을 때 행동 정의
		socket.on('message', function(message) {
			
			console.log('Client received message:', message);
			if(message ==='got user media') {
				maybeStart();
			} else if(message.type ==='offer') {
				// 상대방의 offer
				if(!isInitiator && isStarted) {
					// 내가 방 연사람 아니고 서비스 아직 시작 안됬으면.
					// 먼저 오퍼가 왔으니 이런일은 없지 않을까?
					maybeStart();
				}
				// 상대의 sdp를 저장 후 answer
				console.log('3. B : setRemoteDescription.')
				pc.setRemoteDescription(new RTCSessionDescription(message));
				doAnswer();
			} else if (message.type ==='answer' && isStarted) {
				// 상대방의 answer
				// 상대방의 sdp를 저장
				
				console.log('6. A: local setRemoteDescription')
				pc.setRemoteDescription(new RTCSessionDescription(message));
			} else if(message.type === 'candidate' && isStarted) {
				
				// offer, anwer 성립 후 상대방의 candidate message
				// 언제 일어나는지 확인.
				var candidate = new RTCIceCandidate({
					sdpMLineIndex : message.label,
					candidate : message.candidate
				});
				pc.addIceCandidate(candidate);
			} else if(message === 'bye' && isStarted) {
				// 상대방 떠남.
				console.log('Session terminated.');
				isStarted = false;
				pc.close();
				pc = null;
				isInitiator = false;
			}
		});
		
		
		// shareVideo
		// 'message' event 날아왔을 때 행동 정의
		socket.on('shareVideoMsg', function(message) {
			
			if(message ==='startShare') {
				shareStart();
			} else if(message.type ==='offer') {
				// 상대방의 offer
				if(!isInitiator && isStarted) {
					// 내가 방 연사람 아니고 서비스 아직 시작 안됬으면.
					// 먼저 오퍼가 왔으니 이런일은 없지 않을까?
					shareStart();
				}
				// 상대의 sdp를 저장 후 answer
				console.log('3. B : (share)setRemoteDescription.')
				sharePc.setRemoteDescription(new RTCSessionDescription(message));
				doShareAnswer();
			} else if (message.type ==='answer' && isStarted) {
				// 상대방의 answer
				// 상대방의 sdp를 저장
				
				console.log('6. A: (share)local setRemoteDescription')
				sharePc.setRemoteDescription(new RTCSessionDescription(message));
			} else if(message.type === 'candidate' && isStarted) {
				
				// offer, anwer 성립 후 상대방의 candidate message
				// 언제 일어나는지 확인.
				var candidate = new RTCIceCandidate({
					sdpMLineIndex : message.label,
					candidate : message.candidate
				});
				sharePc.addIceCandidate(candidate);
			} else if(message === 'bye' && isStarted) {
				// 상대방 떠남.
				console.log('Session terminated.');
				isStarted = false;
				sharePc.close();
				sharePc = null;
				isInitiator = false;
			}
		});
		
		socket.on('work', function(msg){
			
			var cmd = msg.split(':')[0];
			
			if(cmd == 'accountPwChange') {
				workType = 'pwChange';
				accoountPwChange();
				
				
			} 
			else if(cmd == 'lostReport') {
				workType = 'lostReport';
				lostReport();
			}
			else if(cmd == 'cancleLostReport') {
				
				workType = 'cancleLostReport';
				
				cancleLostReport();
				
			}
			else if(cmd == 'askPassword') {
				
				workType = 'inputPassword';
				
				var accountNo = msg.split(':')[1];
				
				askPassword(accountNo);
				
			}
			else if(cmd == 'depositAgree') {
				
				workType = 'depositAgree';
				
				depositAgree();
			}
			else if(cmd == 'depositInputComp') {
				workType = 'depositInputComp';
				var productName = msg.split(':')[1];
				var accountNo = msg.split(':')[2];
				var ammount = msg.split(':')[3];
				var period = msg.split(':')[4];
				
				depositInputComp(productName, accountNo, ammount, period);
			}
			else if(cmd == 'savingAgree') {
				
				workType = 'savingAgree';
				
				savingAgree();
			}
			else if(cmd == 'savingInputComp') {
				workType = 'savingInputComp';
				var productName = msg.split(':')[1];
				var accountNo = msg.split(':')[2];
				var entryAmmount = msg.split(':')[3];
				var savingAmmount = msg.split(':')[4];
				var period = msg.split(':')[5];
				
				savingInputComp(productName, accountNo, entryAmmount, savingAmmount, period);
			}
			else if(cmd == 'smsAuth') {
				
				workType = 'smsAuth';
				
				smsAuth();
			}
			
		})
		
		
		socket.on('tellerDisconnect', function(room) {
			
			$('.modal-header').empty();
			let content = '';
			content += '상담이 종료되었습니다. 상담을 마치시겠습니까?';
			
			$('.modal-header').append(content);
			
			$("#mi-modal").modal('show');
			
			$("#modal-btn-si").on("click", function(){
				
				$("#mi-modal").modal('hide');
				location.href="${pageContext.request.contextPath}/waitRoom";
			});
			
			$("#modal-btn-no").on("click", function(){
				$("#mi-modal").modal('hide');
			});
		})
		
		socket.on('tellerForcedOut', function(room) {
			
			alert('텔러가 브라우저를 나갔어요');
		})
		
	///////////////////// socket server로부터의 이벤트 정의 //////////////////
		
		// 연결 붙으면 방 만든다. 만일 사람이 있으면 조인한다.
		//socket.emit('create or join', room);
		socket.emit('bankClient', room);
		console.log('Attempted to create or  join room', room);
	});
	
	socket.on('disconnect', function() {
		console.log('웹 소켓 연결이 종료되었습니다.');
	});
}

function createPeerConnection() {
	try {
		// 위에서 생성하기로 함.
		//pc = new RTCPeerConnection(null);
		// handleIceCandidate 메소드 그냥 여기다 바로 정의
		pc.onicecandidate = function(event){
			console.log('onicecandidate Event.')
			console.log('icecandidate event: ', event);
			if(event.candidate) {
				sendMessage({
					type : 'candidate',
					label : event.candidate.sdpMLineIndex,
					id : event.candidate.sdpMid,
					candidate : event.candidate.candidate
				});
			} else {
				console.log('End of candidates.');
			}
		};
		// addTrack으로 바꾸어야한다.
		//pc.onaddstream = handleRemoteStreadAdded;
		// ontrack 이벤트 바로 정의 해버림
		pc.ontrack = function(event) {
			console.log('onTrack Event.')
			console.log('remote Stream add.')
			
			println('ontrack event')
			//remoteStream = new MediaStream();
			remoteStream.addTrack(event.track, remoteStream);
			
			remoteVideo.srcObject = remoteStream;
			
			$('#chatDiv').height($('#clientVideoDiv').height());
			//$('#chatDiv').height($('#clientVideoDiv').height());
			
			//console.log('remoteStream audio: ' + remoteStream.getAudioTracks())
			//console.log('remoteStream video: ' + remoteStream.getVideoTracks())
			
			document.getElementById("localVideo").muted = true;
			
			console.log('remoteStream audio: ')
			console.log(remoteStream.getAudioTracks())
			console.log('remoteStream video: ')
			console.log(remoteStream.getVideoTracks())
				
			/* 요게 원래거.
			remoteVideo.srcObject = event.streams[0];
			*/
		};
		
		// remove 이벤트는 아직 정의하지 말자.
		//pc.onremovestream = handleRemoteStreamRemoved;
		console.log('Created RTCPeerConnection');
	} catch(e) {
		console.log('Failed to create PeerConnection, exception: ' + e.message);
		alert('Cannot create RTCPeerConnection object');
		return;
	}
}

//shareVideo
function createSharePeerConnection() {
	try {
		// 위에서 생성하기로 함.
		//pc = new RTCPeerConnection(null);
		// handleIceCandidate 메소드 그냥 여기다 바로 정의
		sharePc.onicecandidate = function(event){
			console.log('(share) onicecandidate Event.')
			console.log('(share) icecandidate event: ', event);
			if(event.candidate) {
				sendShareMessage({
					type : 'candidate',
					label : event.candidate.sdpMLineIndex,
					id : event.candidate.sdpMid,
					candidate : event.candidate.candidate
				});
			} else {
				console.log('End of candidates.');
			}
		};
		// addTrack으로 바꾸어야한다.
		//pc.onaddstream = handleRemoteStreadAdded;
		// ontrack 이벤트 바로 정의 해버림
		sharePc.ontrack = function(event) {
			console.log('(share)onTrack Event.')
			console.log('(share)remote Stream add.')

			println('공유 성공!');
			
			println('(share)ontrack event')
			shareStream = new MediaStream();
			shareStream.addTrack(event.track, shareStream);
			
			println('(share) videoSrc : ' + shareStream)
			
			screenShareVideo.srcObject = shareStream;
			
		};
		
		sharePc.onnegotiationneeded = function(event) {
			
			println('(share)onnegotiationneeded')
		};
		
		// remove 이벤트는 아직 정의하지 말자.
		//pc.onremovestream = handleRemoteStreamRemoved;
		console.log('(share)Created RTCPeerConnection');
	} catch(e) {
		console.log('Failed to create PeerConnection, exception: ' + e.message);
		alert('Cannot create RTCPeerConnection object');
		return;
	}
}
/////////////////////////

function maybeStart() {
	console.log('>>>>>>>> maybeStart() ', isStarted, localStream, isChannelReady);
	
	if(!isStarted && typeof localStream !== 'undefined' && isChannelReady) {
		console.log('>>>>>> creating peer connection');
		createPeerConnection();
						
		// 이걸로 해보자.
		localStream.getTracks().forEach(track => {
			pc.addTrack(track, localStream);
		})
		console.log(localStream)
		
		isStarted = true;
		console.log('isInitiator', isInitiator);
		
		if(isInitiator) {
			doCall();
		}
	}
}

// shareVideo
function shareStart() {
	console.log('>>>>>>>> shareStart() ');
	
	if(isStarted && isChannelReady) {
		console.log('>>>>>> (share)creating sharing peer connection');
		createSharePeerConnection();
		
		shareStream = new MediaStream();
		
		shareStream.getTracks().forEach(track => {
			sharePc.addTrack(track, shareStream);
		})
		
		if(isInitiator) {
			doShareCall();
		}
	}
}
///////////////

function doCall() {
	console.log('doCall()');
	console.log('Sending offer to peer');
	println('1. A: local createOffer');
	
	pc.createOffer(setLocalAndSendMessage, handleCreateOfferError);
}

// shareVideo
function doShareCall() {
	
	println('1. A: (share)local createOffer');
	sharePc.createOffer(setShareLocalAndSendMessage, handleShareCreateOfferError);
}
//////////////

function doAnswer() {
	console.log('doAnswer()');
	console.log('Receiving offer to peer')
	
	println('4. B: local createAnswer')
	pc.createAnswer().then(
		setLocalAndSendMessage,
		onCreateSessionDescriptionError
	);
}

// shareVideo
function doShareAnswer() {
	console.log('doShareAnswer()');
	
	println('4. B: (share)local createAnswer')
	sharePc.createAnswer().then(
		setShareLocalAndSendMessage,
		onCreateSessionDescriptionError
	);
}
/////////////////

function setLocalAndSendMessage(sessionDescription) {
	
	if(isInitiator) {
		println('2. A: local setLocalDescription')
	} else {
		println('5. B: local setLocalDescription')
	}
		
	pc.setLocalDescription(sessionDescription);
	console.log('setLocalAndSendMessage sending message', sessionDescription);
	sendMessage(sessionDescription);
}

// shareVideo
function setShareLocalAndSendMessage(sessionDescription) {
	
	if(isInitiator) {
		println('(share)2. A: local setLocalDescription')
	} else {
		println('(share)5. B: local setLocalDescription')
	}
		
	sharePc.setLocalDescription(sessionDescription);
	
	sendShareMessage(sessionDescription);
}
//////////////////////

function handleCreateOfferError(event) {
	console.log('createOffer() error', event);
	println('local createOffer error')
}

// shareVideo
function handleShareCreateOfferError(event) {
	console.log('createOffer() error', event);
	println('(share)local createShareOffer error')
}
/////////////////

function onCreateSessionDescriptionError(error) {
	console.log('Failed to Create session description: ' + error.toString());
	println('local createAnswer error')
}

// shareVideo
function onCreateSessionDescriptionError(error) {
	console.log('Failed to Create session description: ' + error.toString());
	println('(share)local createShareAnswer error')
}
//////////////

function sendMessage(msg) {
	if(socket == undefined) {
		alert('You are not connected status. Connect Server.');
		return;
	}
	console.log('sendMessage(' + msg + ')');
	
	socket.emit('message', msg);
}

function sendShareMessage(msg) {
	if(socket == undefined) {
		alert('You are not connected status. Connect Server.');
		return;
	}
	console.log('sendShareMessage(' + msg + ')');
	
	socket.emit('shareVideoMsg', msg);
}

function sendChat(msg) {
	if(socket == undefined) {
		alert('You are not connected status. Connect Server.');
		return;
	}
	console.log('sendChat(' + msg + ')');
	
	socket.emit('chat', msg);
}

$("#sendChat").bind('click', function(event) {
	let msg = $('#message').val();
	if(msg != null) {
		let str = '';
		str += '<strong> 손님 : ' + msg + '</strong>';
		str += '<br>'
		$('#chat').append(str);
		sendChat(msg);
		
		$('#message').val('');
	}
	
})

document.getElementById("exit").onclick = function() {
	
	$('.modal-header').empty();
	let content = '';
	content += '<div>상담을 종료하시겠습니까?</div>';
	
	$('.modal-header').append(content);
	
	$("#mi-modal").modal('show');
	
	$("#modal-btn-si").on("click", function(){
		
		socket.emit('bankClientDisconnect');
		location.href="${pageContext.request.contextPath}/waitRoom";
		
	});
	
	$("#modal-btn-no").on("click", function(){
		$("#mi-modal").modal('hide');
	});
	
	//document.getElementById("modal").style.display="none";
	
}   
</script>