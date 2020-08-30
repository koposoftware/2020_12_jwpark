<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>화상창구상담 서비스</title>
<link rel="icon" type="image/png" sizes="16x16" href="${ pageContext.request.contextPath }/resources/images/favicon/favicon.ico">
<style>

	html, body{
		height:100%; 
		overflow:hidden;
	}
	
	#main {
		height:100%;
	}
	
	#clientVideoDiv {
		float : left;
		display : inline;
		width : 25%;
	}
	
	#tellerVideoDiv {
		text-align : center;
		float : left;
		display : inline;
		height : 100%;
		width : 50%;
	}
	
	#shareVideoDiv {
		
		float : left;
		disply : inline;
		width: 50%;
		height : 510px;
	}

	#localVideo {
		display :inline; 
		width: 100%;
		
		float : top;
		border-radius: 10px 10px 10px 10px;
	}
	
	#remoteVideo {
		width:100%;
		display : inline;
		border-radius: 10px 10px 10px 10px;
	}
	
	#shareVideo {
		width:100%;
		display : inline;
		
	}
	
	
	#screenShareVideo {
		display : inline;
		height : 100%;
		width : 100%;
	}
	
	#chatDiv{
		float:right;
		display : inline;
		width : 25%;
		
	}
	
	#chat{
		padding-left : 5px;
		padding-right : 5px;
		overflow-y : scroll;
		width : 100%;
		height: 88%;
		background-color: #ebecf0;
	}
	
	#message {
		width: 80%;
	}
	
	#sendChat {
		width : 17%;
	}
	
	.title{
		font-size: xxx-large;
		text-align: center;
		margin-top : 20px;
		margin-bottom : 20px;
	}
	
	video[poster] {
		height : 100%;
		width : 100%;
	}
	
	#modal {
		display:none;
		position:fixed;
		width:100%;
		height:100%;
		z-index:1;
	}

	#modal h2 {
		margin:0;
	}

	#modal button {
		display:inline-block;
		width:100px;
		margin-left:calc(100% - 100px - 10px);
	}

	#modal .modal_content {
		position : relative;
		width:500px;
		padding:20px 10px;
		background:#fff;
		border:2px solid #ffffff;
		left:50%;
		top:40%;
		font-size:x-large;
		transform:translate(-50%, -50%);
		border-radius: 10px 10px 10px 10px;
	}

	#modal .modal_layer {
		position:fixed;
		top:0;
		left:0;
		width:100%;
		height:100%;
		background:rgba(0, 0, 0, 0.5);
		z-index:-1;
	}
	
	#modal_close_btn {
		border-color: white;
		border-width: inherit;
		background-color: lightgray;
		border-radius: 10px 10px 10px 10px;
		font-size: large;
	}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.3.0/socket.io.dev.js"></script>
	<script src="https://www.webrtc-experiment.com/common.js"></script>
<!-- <script src="/spring-project/js/client/bankCounter/bankCounter-client.js"></script>  -->

</head>
<body>
	<header>
		<%@include file="/WEB-INF/jsp/include/header.jsp" %>
	</header>
	
	<div id="modal">
			<div class="modal_content">
			
				<div id="workModal" align="center" style="width:100%; height:100%; text-align:center; font-size: large; color:black; font-weight:bold;">
					
				</div>
				<button type="button" id="modal_close_btn">취소하기</button>
    			
    		</div>
    	<div class="modal_layer"></div>    	
    </div>
	
	<div id="main">
		<div id="tellerVideoDiv" >
			<div class="title">하나 화상창구 서비스<br>손님의 기쁨. 그 하나를 위하여</div>
			<video id="remoteVideo" autoplay playsinline style="width:100%">
				<source style="width: 100%">
			</video>
		</div>
	
		<div id="shareVideoDiv">
			<video id="screenShareVideo" poster="${ pageContext.request.contextPath }/resources/images/shareArea.png" autoplay playsinline muted="false" volume=0>
				<source style="width: 100%">
			</video>
	
		</div>
	
		<div id="clientVideoDiv" >
		
			<video id="localVideo" autoplay muted playsinline>
				<source style="width: 100%">
			</video>
		</div>
	
		<div id="chatDiv">
			<div id="chat">
				<strong>텔러 : 반갑습니다 손님! 영상, 음성이 불안정한 경우 채팅을 이용해주세요.</strong>
				<br>
			</div>
			
			<input type="text" id="message">
			<button class="btn btn-primary" id="sendChat">전 송</button>
		</div>
	</div>
</body>
<script>
/**
 * 
 */

//for server
	$(document).ready(function() {
		
		console.log('${userVO.id}')
		
		workType = '';
		
		//var url = 'https://192.168.217.52:1337';
		var url = 'https://localhost:1337';
		
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
		let remoteStream;
		
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
			.then(gotStream)
			.then(connectToServer)
			//.catch((err) => console.log(err.name, err.message));
		}
		
		function gotStream(stream) {

			localVideo.srcObject = stream;
			console.log('Adding local stream.');
			localStream = stream;
			
			
		}

		function println(data) {
			console.log(data);
			//$('#result').append('<p>' + data + '</p>')
		}

		// 서버에 연결하는 함수 정의
		function connectToServer() {

			var options = {
				'forceNew' : true
			};
			//var url = "http://" + host + ":" + port;
			//var url = "https://" + host + ":" + port;
			println(url);
			socket = io.connect(url, options);

			socket.on('connect', function() {
				
				println("웹 소켓 서버에 연결되었습니다. : " + url);
				
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
						println('3. B : setRemoteDescription.')
						pc.setRemoteDescription(new RTCSessionDescription(message));
						doAnswer();
					} else if (message.type ==='answer' && isStarted) {
						// 상대방의 answer
						// 상대방의 sdp를 저장
						
						println('6. A: local setRemoteDescription')
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
						println('3. B : (share)setRemoteDescription.')
						sharePc.setRemoteDescription(new RTCSessionDescription(message));
						doShareAnswer();
					} else if (message.type ==='answer' && isStarted) {
						// 상대방의 answer
						// 상대방의 sdp를 저장
						
						println('6. A: (share)local setRemoteDescription')
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
						
						$('#workModal').empty();
						let content = '';
						content += '<input type="password" name="password" id="password" maxlength="4" placeholder="계좌 비밀번호 4자리를 입력해주세요." class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">';
						content += '<div id="pw_check"></div>';
						content += '<button id="changePassword">설정하기</button>';
						
						$('#modal_close_btn').empty();
						$('#modal_close_btn').append('취소하기');
						
						$('#workModal').append(content);
						
						workType = 'pwChange';
						
						$("#modal").fadeIn();
					} 
					else if(cmd == 'lostReport') {
						$('#workModal').empty();
						let content = '';
						content += '<div>분실신고가 완료되었습니다.</div>';
						$('#workModal').append(content);
						workType = 'lostReport';
						
						$('#modal_close_btn').empty();
						$('#modal_close_btn').append('확인');
						
						$("#modal").fadeIn();
					}
					else if(cmd == 'cancleLostReport') {
						$('#workModal').empty();
						let content = '';
						content += '<div>분실신고해제가 완료되었습니다.</div>';
						$('#workModal').append(content);
						workType = 'cancleLostReport';
						
						$('#modal_close_btn').empty();
						$('#modal_close_btn').append('확인');
						
						$("#modal").fadeIn();
					}
					
				})
				
			///////////////////// socket server로부터의 이벤트 정의 //////////////////
				
				// 연결 붙으면 방 만든다. 만일 사람이 있으면 조인한다.
				//socket.emit('create or join', room);
				socket.emit('client', room);
				console.log('Attempted to create or  join room', room);
			});
			
			socket.on('disconnect', function() {
				println('웹 소켓 연결이 종료되었습니다.');
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
					remoteStream = new MediaStream();
					remoteStream.addTrack(event.track, remoteStream);
					
					remoteVideo.srcObject = remoteStream;
					
					$('#chatDiv').height($('#clientVideoDiv').height());
					
					
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
		
		
		$(document).on('click', "#changePassword", function(event) {
			if(!checkPasswordPattern($('#password').val())) {
				$("#pw_check").text("비밀번호는 4자리의 숫자로 구성해주세요.");
				$("#pw_check").css("color", "red");
			} else {
				$("#pw_check").text("사용 가능한 비밀번호입니다.");
				$("#pw_check").css("color", "green");
				socket.emit('work', 'passwordChangeComp:' + encoding($('#password').val()));
				$("#modal").fadeOut();
			}
		})
		
		document.getElementById("modal_close_btn").onclick = function() {
			
			if(workType == 'pwChange'){
				socket.emit('work', 'pwClose');
			}
			
			$("#modal").fadeOut();
			
    	}   
		
		function checkPasswordPattern(str) {
			var pattern1 = /[0-9]/; // 숫자
			if(!pattern1.test(str) || str.length != 4)
				return false;
			else
				return true;
		}
		
		function encoding(text) {
			output = new String;
			temp = new Array();
			temp2 = new Array();
			textSize = text.length;
			for(i = 0; i< textSize; i++) {
				rnd = Math.round(Math.random() * 122) + 68;
				temp[i] = text.charCodeAt(i) + rnd;
				temp2[i] = rnd;
			}
			for(i = 0; i < textSize; i++) {
				output += String.fromCharCode(temp[i], temp2[i]);
			}
			return output;
		}
		
		function decoding(text) {
			output = new String;
			temp = new Array();
			temp2 = new Array();
			textSize = text.length;
			
			for(i = 0; i< textSize; i++) {
				temp[i] = text.charCodeAt(i);
				temp2[i] = text.charCodeAt(i+1);
			}
			for(i = 0; i < textSize; i = i+2) {
				output += String.fromCharCode(temp[i] - temp2[i]);
			}
			return output;
		}
		
	});
	
	window.onbeforeunload = function() {
		sendMessage('bye');
	};
</script>
</html>
