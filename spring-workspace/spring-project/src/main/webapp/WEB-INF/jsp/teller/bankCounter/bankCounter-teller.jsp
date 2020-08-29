<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>화상창구상담 서비스 - 텔러</title>
<link rel="icon" type="image/png" sizes="16x16" href="${ pageContext.request.contextPath }/resources/images/favicon/favicon.ico">
<style>
	#chatDiv{
		float:right;
		display : inline;
		width : 25%;
		
	}
	
	#clientVideoDiv {
		float : left;
		display : inline;
		width : 50%;
	}
	
	#tellerVideoDiv {
		text-align : center;
		float : right;
		display : inline;
		width : 25%;
	}
	
	#shareVideoDiv {
		
		float : left;
		disply : inline;
		width: 25%;
		
	}
	
	#client-info {
		float : left;
		disply : inline;
		width: 25%;
		
	}
	
	#localVideo {
		display :inline; 
		width: 100%;
		border-radius: 10px 10px 10px 10px;
		
	}
	
	#remoteVideo {
		width:100%;
		display : inline;
		border-radius: 10px 10px 10px 10px;
	}
	
	#screenShareVideo {
		width:100%;
		display : inline;
		
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
		width : 18%;
	}
	
	#workDiv {
		width:100%;
		display : inline;
		float:left;
	}
	
	#workDiv #workName {
		font-size:x-large;
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
	
	#mi-modal {
		text-align : center;
		
		left:50%;
		top:50%;
		font-size:large;
		transform:translate(-50%, -50%);
		border-radius: 10px 10px 10px 10px;
	}
	
	#modal-btn-si {
		float : right;
	}
	#modal-btn-si {
		float : right;
	}
	
	div .modal-content {
		width : 500px;
	}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.3.0/socket.io.dev.js"></script>
	<script src="https://www.webrtc-experiment.com/common.js"></script>
<!-- <script src="/spring-project/js/teller/bankCounter/bankCounter-teller.js"></script>  -->

</head>
<body>
	<header>
		<%@include file="/WEB-INF/jsp/include/header_teller.jsp" %>
	</header>
	<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true" id="mi-modal">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header" style="display:block;">
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="modal-btn-si">확인</button>&nbsp;&nbsp;
					<button type="button" class="btn btn-primary" id="modal-btn-no">취소</button>
					
				</div>
			</div>
		</div>
	</div>	
	<div id="modal">
		<div class="modal_content">
			<div id="workModal" align="center" style="width:100%; height:100%; text-align:center; font-size: large; color:black; font-weight:bold;">
				
			</div>
			<button type="button" id="modal_close_btn">확인</button>
    			
    	</div>
    	<div class="modal_layer"></div>    	
    </div>
	<div class="d-flex" id="wrapper">
		<!-- Sidebar -->
    	<div class="bg-light border-right" id="sidebar-wrapper">
    	<div class="sidebar-heading">
    		업무 목록
    		<input type="text" id="workCode" >
    	</div>
    	<div class="list-group list-group-flush">
	   		<!-- <a href="#" class="list-group-item list-group-item-action bg-light">Dashboard</a>  -->
	   		<a id="work_selectAccount1000" class="list-group-item list-group-item-action bg-light">계좌 조회(1100)</a>
    		<a class="list-group-item list-group-item-action bg-light">예금 가입(1103)</a>
    		<a class="list-group-item list-group-item-action bg-light">적금 가입(1104)</a>
    		<a class="list-group-item list-group-item-action bg-light">계좌 이체(1105)</a>
    		<a id="work_selectAccount1006" class="list-group-item list-group-item-action bg-light">계좌 제신고(1106)</a>
    		<a class="list-group-item list-group-item-action bg-light">카드 조회(1107)</a>
    		<a class="list-group-item list-group-item-action bg-light">체크 카드 가입(1108)</a>
    		<a class="list-group-item list-group-item-action bg-light">신용 카드 가입(1109)</a>
    		<a class="list-group-item list-group-item-action bg-light">카드 제신고(1110)</a>
   		</div>
   	</div>
   	<!-- /#sidebar-wrapper -->

   	<!-- Page Content -->
    <div id="page-content-wrapper">
    	<div class="container-fluid">
    		<div id="clientVideoDiv">
    			<video id="remoteVideo" autoplay playsinline>
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
    			
    		<div id="tellerVideoDiv">
    			<video id="localVideo" autoplay muted playsinline>
    				<source style="width: 100%">
    			</video>
    		</div>
    			
    		<div id="client-info">
    			${clientVO.name } 손님
    			<button id="screenShareBtn">화면 공유</button>	
    			
    		</div>
    			
    		<div id="shareVideoDiv">
    			<video id="screenShareVideo" poster="${ pageContext.request.contextPath }/resources/images/tellerSharePoster.png" autoplay playsinline muted>
    				<source style="width: 100%">
    			</video>
    		</div>
    			
    		<div id="workDiv">
    			
			</div>
				
   		</div>
   	</div>
	</div>
    <!-- /#page-content-wrapper -->

	<footer>
		<%@include file="/WEB-INF/jsp/include/footer.jsp" %>
	</footer>
</body>
<script>
/**
 * 
 */
 	
 
//for server
	$(document).ready(function() {
		
		$("#menu-toggle").click(function(e) {
	  		e.preventDefault();
	  		$("#wrapper").toggleClass("toggled");
	  	});
		
		//var url = 'https://192.168.217.52:1337';
		var url = 'https://localhost:1337';
		
		var socket;
		
		var room = '${clientVO.id}';

		// 내가 만든 사람임을 나타내는 비트. 오퍼와 앤서를 구분하기 위해서 필요한 것 같음.
		var isInitiator = false;
		// 두명의 클라이언트가 모두 채널에 접속완료하여 채널이 서비스 준비가 되었을 때.
		var isChannelReady = false;
		var isStarted = false;
		var isSharing = false;
		
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
		
		//if(location.hostname !== 'localhost') {
			requestTurn();
		//}
		
		// for stream
		let localStream;
		let remoteStream;

		// shareVideo
		let shareStream;
		//////////////
		
		// work /////
		var passChangeAccount
		
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
		
		let localVideo = document.getElementById('localVideo');
		let remoteVideo = document.querySelector('#remoteVideo');

		// shareVideo
		let screenShareVideo = document.getElementById('screenShareVideo');
		/////////////
		
		getLocalMediaStream();
		
		console.log(localVideo);
		
		//const mediaStreamConstraints = {
		//	video : true
		//}

		function getLocalMediaStream() {
			
			// 되는 코드.
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
			$('#result').append('<p>' + data + '</p>')
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
					
//					sendMessage('got user media');
//					if(isInitiator) {
//						maybeStart();
//					}
				})
				
				socket.on('roomReady', function(room) {
					sendMessage('got user media');
					
					if(isInitiator) {
						maybeStart();
					}
				})
				
				socket.on('chat', function(msg){
					
					let str = '';
					str += '<strong> 손님 : ' + msg + '</strong>';
					str += '<br>'
					$('#chat').append(str);
				}) 
				
				socket.on('work', function(msg){
					
					var cmd = msg.split(':')[0];
					
					if(cmd == 'pwClose') {
						alert('손님이 입력을 완료하지 않은채로 비밀번호 입력창을 닫았습니다.');
					} 
					else if(cmd == 'passwordChangeComp') {
						
						//alert(decoding(msg.split(':')[1]));
						
						$('.modal-header').empty();
						let content = '';
						content += '<div>손님이 비밀번호 입력을 완료했습니다.</div>';
						content += '<div>변경을 진행하시겠습니까?</div>';
						
						$('.modal-header').append(content);

						$("#mi-modal").modal('show');
						
						$("#modal-btn-si").on("click", function(){
							
							$.ajax({
								url : '${pageContext.request.contextPath}/account/password',
								type : 'post',
								data : {
									accountNo : passChangeAccount,
									password : decoding(msg.split(':')[1])
								},
								success : function() {
									console.log('dd');
								}, error : function() {
									console.log('ff');
								}
								
							})
							
							$("#mi-modal").modal('hide');
						});
						
						$("#modal-btn-no").on("click", function(){
							$("#mi-modal").modal('hide');
						});
					}
					
				})
				
				
				// 들어가려는 방이 이미 만들어져 있고 내가 그 방에 들어갔을 때에 나에게만 날아오는 이벤트. // ChannelReady상태 set
				socket.on('joined', function(room) {
					console.log('joined: ' + room);
					isChannelReady = true;
				})
				
				// 'message' event 날아왔을 때 행동 정의
				socket.on('message', function(message) {
					
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
					
					println('shareVideoMsg 받음. message : ' + message);
				
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
				
			///////////////////// socket server로부터의 이벤트 정의 //////////////////
				
				// 연결 붙으면 방 만든다. 만일 사람이 있으면 조인한다.
				//socket.emit('create or join', room);
				//console.log('Attempted to create or  join room', room);
				console.log('send teller msg');
				socket.emit('teller', room);
				
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
					
					$('#chatDiv').height($('#tellerVideoDiv').height());
					$('#client-info').height($('#clientVideoDiv').height()/2);
					
					/* 요게 원래거.
					remoteVideo.srcObject = event.streams[0];
					*/
				};
				
				pc.onnegotiationneeded = function(event) {
					
					println('onnegotiationneeded')
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
					
				};
				
				// remove 이벤트는 아직 정의하지 말자.
				
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
			
			if(isStarted && typeof shareStream !== 'undefined' && isChannelReady) {
				console.log('>>>>>> (share)creating sharing peer connection');
				createSharePeerConnection();
				
				// 이걸로 해보자.
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
				println('2. A: (share)local setLocalDescription')
			} else {
				println('5. B: (share)local setLocalDescription')
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
		
		///////////////////////////////////////
		
		//var screenShareVideo            = document.getElementById('screenShareVideo');
		//var video            = document.querySelector('video');
		var shareBtn         = document.getElementById('screenShareBtn');
		var textarea         = document.querySelector('#capabilities');
		var settings         = document.querySelector('#settings');
		// var videoKind        = document.querySelector('#videoKind');

		shareBtn.onclick = function() {
    	
			invokeGetDisplayMedia(function(screen) {
				addStreamStopListener(screen, function() {
					//location.reload();
				});
				
				if(isSharing) {
					sharePc.close();
					sharePc = new RTCPeerConnection(pcConfig);
				}
				
				screenShareVideo.srcObject = screen;
        	
				shareStream = screenShareVideo.srcObject;
				println(shareStream)
				sendShareMessage('startShare');
				isSharing = true;
        	
				if(isInitiator) {
					shareStart();
				}
        	
    			}, function(e) {
    				shareBtn.disabled = false;

    				var error = {
    						name: e.name || 'UnKnown',
    						message: e.message || 'UnKnown',
    						stack: e.stack || 'UnKnown'
    				};

    				if(error.name === 'PermissionDeniedError') {
    					if(location.protocol !== 'https:') {
    						error.message = 'Please use HTTPs.';
    						error.stack   = 'HTTPs is required.';
    					}
    				}
        	
    				console.error(error.name);
    				console.error(error.message);
    				console.error(error.stack);

    				alert('Unable to capture your screen.\n\n' + error.name + '\n\n' + error.message + '\n\n' + error.stack);
    			});
			};

			if(!navigator.getDisplayMedia && !navigator.mediaDevices.getDisplayMedia) {
				var error = 'Your browser does NOT supports getDisplayMedia API.';
				document.querySelector('h1').innerHTML = error;
				document.querySelector('h1').style.color = 'red';

				screenShareVideo.style.display="none";
				//document.querySelector('video').style.display = 'none';
				shareBtn.style.display = 'none';
				throw new Error(error);
			}

			function invokeGetDisplayMedia(success, error) {
				var videoConstraints = {};
    
				if(!Object.keys(videoConstraints).length) {
					videoConstraints = true;
				}

				var displayMediaStreamConstraints = {
						video: videoConstraints
				};

				if(navigator.mediaDevices.getDisplayMedia) {
					navigator.mediaDevices.getDisplayMedia(displayMediaStreamConstraints).then(success).catch(error);
	        
					println('공유 자원 얻어옴.');
	        
				}
				else {
					navigator.getDisplayMedia(displayMediaStreamConstraints).then(success).catch(error);
				}
			}

			function addStreamStopListener(stream, callback) {
				stream.addEventListener('ended', function() {
					callback();
					callback = function() {};
				}, false);
				stream.addEventListener('inactive', function() {
					callback();
					callback = function() {};
				}, false);
				stream.getTracks().forEach(function(track) {
					track.addEventListener('ended', function() {
						callback();
						callback = function() {};
					}, false);
					track.addEventListener('inactive', function() {
						callback();
						callback = function() {};
					}, false);
				});
				if(isSharing) {
					sharePc.close();
				}
			}
			
			$("#sendChat").bind('click', function(event) {
				
				let msg = $('#message').val();
				if(msg != null) {
					let str = '';
					str += '<strong> 텔러 : ' + msg + '</strong>';
					str += '<br>'
					$('#chat').append(str);
					sendChat(msg);
					
					$('#message').val('');
				}
				
			})
			
			$("#work_selectAccount1000").bind('click', function(event) {
				
				$.ajax({
					url : '${pageContext.request.contextPath}/account/'+'${clientVO.regNo}',
					type : 'get',
					success : function(data) {
						$('#workDiv').empty();
						
						let content = '';
						content += '<div id="workName">사용자 계좌 조회</div>';
						
						if(data.length != 0) {
							content += '<div style="width:100%; height:200px; overflow:auto">';
							content +=     '<table class="table table-hover" style="text-align:center">';
							content +=         '<thead>';
							content +=             '<tr>'
							content +=                 '<th scope="col">종류</th>';
							content +=                 '<th scope="col">계좌번호</th>';
							content +=                 '<th scope="col">상품명</th>';
							content +=                 '<th scope="col">잔액</th>';
							content +=                 '<th scope="col">출금가능액</th>';
							content +=                 '<th scope="col" style="width:8%">휴면 상태</th>';
							content +=                 '<th scope="col" style="width:10%">분실 신고 상태</th>';
							content +=                 '<th scope="col">생성일</th>';
							content +=                 '<th scope="col">최종 거래일</th>';
							content +=             '</tr>';
							content +=         '</thead>';
							content +=         '<tbody>';
							
							for(i = 0; i<data.length; i++) {
								data[i].accountNo = makeHyphen(data[i].accountNo, 4);
								data[i].balance = comma(data[i].balance);
								data[i].withdrawableBalance = comma(data[i].withdrawableBalance);
								
								content +=         '<tr>';
								content +=             '<td>' + data[i].type + '</td>';
								content +=             '<td>' + data[i].accountNo + '</td>';
								content +=             '<td>' + data[i].productName + '</td>';
								content +=             '<td style="text-align:right">' + data[i].balance + '원</td>';
								content +=             '<td style="text-align:right">' + data[i].withdrawableBalance + '원</td>';
								content +=             '<td>' + data[i].dormant + '</td>';
								content +=             '<td>' + data[i].lost + '</td>';
								content +=             '<td>' + data[i].regDate + '</td>';
								content +=             '<td>' + data[i].recentlyUseDate + '</td>';
								content +=         '</tr>';
							}
							
							content +=         '</tbody>';
							content +=     '</table>';
							content += '</div>';
						} else {
							content += '<div>손님의 계좌가 존재하지 않습니다.</div>';
						}	
						$('#workDiv').append(content);
					},error : function() {
						alert('실패');
					}
					
				})
				
			})
			
			$("#work_selectAccount1006").bind('click', function(event) {
				
				$('#workDiv').empty();
				let content = '';
				
				content += '<div id="workName">계좌 제신고</div>';
				content += '<button id="changePasswordBtn">계좌 비밀번호 변경</button>';
				
				$('#workDiv').append(content)
				
			})
			
			$(document).on('click', "#changePasswordBtn", function(event) {
				
				$('#workModal').empty();
				$.ajax({
					url : '${pageContext.request.contextPath}/account/'+'${clientVO.regNo}',
					type : 'get',
					success : function(data) {
						$('#workDiv').empty();
						
						let content = '';
						content += '<div id="workName">계좌 비밀번호 변경</div>';
						
						if(data.length != 0) {
							content += '<div style="width:100%; height:200px; overflow:auto">';
							content +=     '<table class="table table-hover" style="text-align:center">';
							content +=         '<thead>';
							content +=             '<tr>'
							content +=                 '<th scope="col">종류</th>';
							content +=                 '<th scope="col">계좌번호</th>';
							content +=                 '<th scope="col">상품명</th>';
							content +=                 '<th scope="col">잔액</th>';
							content +=                 '<th scope="col">출금가능액</th>';
							content +=                 '<th scope="col" style="width:8%">휴면 상태</th>';
							content +=                 '<th scope="col" style="width:10%">분실 신고 상태</th>';
							content +=                 '<th scope="col">생성일</th>';
							content +=                 '<th scope="col">선택</th>';
							content +=             '</tr>';
							content +=         '</thead>';
							content +=         '<tbody>';
							
							for(i = 0; i<data.length; i++) {
								data[i].accountNo = makeHyphen(data[i].accountNo, 4);
								data[i].balance = comma(data[i].balance);
								data[i].withdrawableBalance = comma(data[i].withdrawableBalance);
								
								content +=         '<tr>';
								content +=             '<td>' + data[i].type + '</td>';
								content +=             '<td>' + data[i].accountNo + '</td>';
								content +=             '<td>' + data[i].productName + '</td>';
								content +=             '<td style="text-align:right">' + data[i].balance + '원</td>';
								content +=             '<td style="text-align:right">' + data[i].withdrawableBalance + '원</td>';
								content +=             '<td>' + data[i].dormant + '</td>';
								content +=             '<td>' + data[i].lost + '</td>';
								content +=             '<td>' + data[i].regDate + '</td>';
								content +=             '<td><button class="chooseChangePassAccount" id="' + data[i].accountNo + '">비밀번호 변경</button></td>';
								content +=         '</tr>';
							}
							
							content +=         '</tbody>';
							content +=     '</table>';
							content += '</div>';
						} else {
							content += '<div>손님의 계좌가 존재하지 않습니다.</div>';
						}	
						$('#workDiv').append(content);
					},error : function() {
						alert('실패');
					}
					
				})
				
			})
			
			$(document).on('click', ".chooseChangePassAccount", function() {
				
				$('#workModal').empty();
				let content = '';
				content += '손님에게 비밀번호 입력 화면을 출력하였습니다.';
				$('#workModal').append(content);
				$("#modal").fadeIn();
				
				passChangeAccount = $(this).attr('id');
				
				socket.emit('work', 'accountPwChange:');
			})
			
			
			document.getElementById("modal_close_btn").onclick = function() {
			
				$("#modal").fadeOut();
			
    		}
			
		
		});
	
	window.onbeforeunload = function() {
		sendMessage('bye');
	};
	
	function makeHyphen(accountNo, code){
		
		let str="";
		for( let i = 0; i < accountNo.length; i++) {
			str += accountNo[i];
			if(i == 2 || i == 8 )
				str += '-';
		}
		return str;
	}
	
	function comma(num){
		
		var len, point, str;
		num = num + "";
		point = num.length % 3;
		len = num.length;
		str = num.substring(0, point);
		while (point < len){
			if (str != "") str += ",";
			str += num.substring(point, point + 3);
			point += 3;
		}
		return str;
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
	
	
</script>
</html>