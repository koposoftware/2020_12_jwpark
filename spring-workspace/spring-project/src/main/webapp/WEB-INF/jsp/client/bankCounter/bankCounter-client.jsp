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
	
	.detailContent {
		height : 200px;
		overflow :auto;
		text-align:left;
	}
	
	summary {
		text-align : left;
	}	
	
	.form-check{
		text-align : right;
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
					else if(cmd == 'askPassword') {
						
						$('#workModal').empty();
						let content = '';
						workType = 'inputPassword';
						
						var accountNo = msg.split(':')[1];
						
						content += '<input type="password" name="password" id="password" maxlength="4" placeholder="계좌 비밀번호 4자리를 입력해주세요." class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">';
						content += '<div id="pw_check"></div>';
						content += '<button class="checkUserPassword" id="' + accountNo  + '">입력하기</button>';
						
						$('#modal_close_btn').empty();
						$('#modal_close_btn').append('취소하기');
						
						$('#workModal').append(content);
						
						workType = 'inputPassword';
						
						$("#modal").fadeIn();
					}
					else if(cmd == 'depositAgree') {
						workType = 'depositAgree';
						$('#workModal').empty();
						let content = '';
						content += '<div>상품가입 약관 <button id="allAgree">전체동의</button></div>';
						content += '<div class="depositAgree">'
						content += 		'<details>';
						content += 			'<summary>예금거래기본약관</summary>';
						content += 			'<div class="detailContent">';
						content += 				'<p>';
						content += 					'<span class="area-left">2019. 8. 26 개정</span>';
						content += 					'<span class="area-right">준법감시인 심사필번호 제2019-약관-122호(2019.07.18)</span>';
						content += 				'</p>';
						content += 				'<h5>예금거래 기본약관</h5>';
						content += 				'<p>이 예금거래기본약관(이하 “약관”이라 한다)은 (주)하나은행(이하 “은행”이라 한다)과 거래처(또는 예금주)가 서로 믿음을 바탕으로 예금거래를 빠르고 틀림 없이 처리하는 한편, 서로의 이해관계를 합리적으로 조정하기 위하여 기본적이고 일반적인 사항을 정한 것이다. 은행은 이 약관을 영업점에 놓아두고, 거래처는 영업시간 중 언제든지 이 약관을 볼 수 있고 또한 그 교부를 청구할 수 있다.</p>';
						content +=				'<strong>제1조 적용범위</strong>';
						content +=				'<p>이 약관은 입출금이 자유로운 예금, 거치식예금 및 적립식예금 거래에 적용한다.</p>';
						content +=				'<strong>제2조 실명거래 </strong>';
						content +=				'<ol>';
						content +=					'<li>① 거래처는 실명으로 거래하여야 한다. </li>';
						content +=					'<li>② 은행은 거래처의 실명확인을 위하여 주민등록증ㆍ사업자등록증 등 실명확인증표 또는 그밖에 필요한 서류의 제시나 제출을 요구할 수 있고, 거래처는 이에 따라야 한다. </li>';
						content +=				'</ol>';	
						content +=				'<strong>제3조 거래장소</strong>';	 
						content +=				'<p>거래처는 예금계좌를 개설한 영업점(이하 “개설점”이라 한다)에서 모든 예금거래를 한다. 다만, 은행이 정하는 바에 따라 다른 영업점이나 다른 금융기관, 또는 현금자동지급기ㆍ현금자동입출금기ㆍ컴퓨터ㆍ전화기 등(이하 “전산통신기기”)을 통하여 거래할 수 있다. </p>';
						content +=				'<strong>제4조 거래방법</strong>';
						content +=				'<p>거래처는 은행에서 내준 통장(증서ㆍ전자통장을 포함한다) 또는 수표ㆍ어음용지로 거래하여야 한다. 그러나 입금할 때와, 자동이체약정ㆍ전산통신기기, 바이오인증 이용약정 등에 따라 거래할 때는 통장 없이도 할 수 있다. </p>';
						content += 			'</div>';
						content += 		'</details>';
						content += 		'<div class="form-check">';
						content += 			'<input class="form-check-input" type="checkbox" value="" id="depositCheck1">';
						content += 			'<label class="form-check-label" for="defaultCheck1">동의하기</label>';  
						content += 		'</div>';
						content += 		'<details>';
						content += 			'<summary>거치식예금약관</summary>';
						content += 			'<div class="detailContent">';
						content += 				'<p>';
						content += 					'<span class="area-left">2016. 6. 7 개정</span>';
						content += 					'<span class="area-right">준법감시인 심사필번호 제2016-약관-93호</span>';
						content += 				'</p>';
						content += 				'<h5>거치식예금약관</h5>';
						content += 				'<strong>제1조 (적용범위)</strong>';
						content +=				'<ol>';
						content +=					'<li>① 거치식예금(이하 ‘이 예금’이라 한다)이란 예치기간을 정하고 거래를 시작할 때 맡긴 돈을 만기에 찾는 예금을 말한다.</li>';
						content +=					'<li>② 이 약관에서 정하지 아니한 사항은 예금거래기본약관의 규정을 적용한다.</li>';
						content +=					'<li>③ 복리자유적립식정기예금과 양도성예금증서 및 표지어음의 거래에는 이 약관을 적용한다.</li>';
						content +=				'</ol>';
						content +=				'<strong>제2조 (지급시기)</strong>';
						content +=				'<p>이 예금은 약정한 만기일 이후 거래처가 청구할 때 지급한다. 다만, 거래처가 부득이한 사정으로 청구할 때에는 만기전이라도 지급할 수 있다. </p>';
						content +=				'<strong>제3조 (이자)</strong>';
						content +=				'<ol>';
						content +=					'<li>① 이 예금의 이자는 약정한 예치기간에 따라 예금일 당시 영업점에 게시한 예치기간별 이율로 셈하여  만기일 이후 원금과 함께 지급한다. 그러나, 거래처의 요청이 있으면 월별로 이자를 지급할 수 있다.</li>';
						content +=					'<li>② 만기일 후 지급청구할 때는 만기일부터 지급일 전날까지의 기간에 대해 예금일 당시 영업점에 게시한  만기후 이율로 셈한 이자를 더하여 지급한다.</li>';
						content +=					'<li>③ 만기일 전에 지급청구할 때는 예금일부터 지급일 전날까지의 기간에 대하여 예금일 당시 영업점에 게시한 중도해지이율로 셈하여 지급하며 이미 지급한 이자는 지급할 금액에서 뺀다.</li>';
						content +=					'<li>④ 이 예금중 변동금리를 적용하는 예금은 이율을 바꾼 때 바꾼 날부터 바꾼 이율로 셈하여 이자를 지급한다.</li>';
						content +=				'</ol>';
						content +=				'<strong>제4조 (장기예금으로의 계약변경과 이자)</strong>';
						content +=				'<ol>';
						content +=					'<li>① 기명식 정기예금을 만기일 전에, 처음 약정한 예치기간보다 긴 예치기간의 예금으로 계약을 변경할 때는 제3조 제3항에 상관없이 예금일부터 계약변경일 전날까지 기간에 대해 제3조 제1항의 이율로 셈한 이자를 지급하고, 계약변경일 이후 이율은 변경일 당시의 영업점에 게시한 예치기간별 이율로 셈한 이자를 지급한다. 다만, 이미 지급한 이자는 지급할 금액에서 뺀다.</li>';
						content +=					'<li>② 계약변경한 예금을 변경된 만기일 전에 청구했을 때 그 이자는 변경전 예금일부터 지급일 전날까지 기간에 대해 제3조 제3항에 따라 처리한다.</li>';
						content +=				'</ol>';
						content += 			'</div>';
						content += 		'</details>';
						content += 		'<div class="form-check">';
						content += 			'<input class="form-check-input" type="checkbox" value="" id="depositCheck2">';
						content += 			'<label class="form-check-label" for="defaultCheck1">동의하기</label>';  
						content += 		'</div>';
						content += 		'<details>';
						content += 			'<summary>비과세종합저축 특약</summary>';
						content += 			'<div class="detailContent">';
						content += 				'<p>';
						content += 				'<span class="area-left">2020. 1. 1 개정</span>';
						content += 				'<span class="area-right">준법감시인 심의필 번호 : 제2019-약관-179호</span>';
						content += 				'</p>';
						content += 				'<h5>비과세종합저축특약</h5>';
						content += 				'<strong>제1조(약관의 적용)</strong>';
						content += 				'<p>비과세종합저축(이하 “저축”이라 한다)의 거래시 이 특약에서 정하지 않은 사항은 예금거래기본약관, 금전신탁거래기본약관, 은행이 취급하는 각종 예금 · 신탁 · 채권 등(이하 “예금 등”이라 한다)의 약관(특약포함)과 조세특례제한법 등 법령에서 정하는 바에 따릅니다.</p>';
						content += 				'<strong>제2조(가입대상자)</strong>';
						content += 				'<p>이 저축에 가입할 수 있는 자는 소득세법 제1조의2 제1항 제1호의 규정에 의한 거주자(직전 3개 과세기간 동안 소득세법 제14조 제3항 제6호에 따른 소득의 연간 합계액이 1회이상 2천만원을 초과한자를 제외한다)로서 다음 각호의 1에 해당하는 요건을 갖추어야 합니다.</p>';
						content += 				'<ol>';
						content += 					'<li>1. 2015년 1월 1일부터 2015년 12월 31일까지 가입하는 경우 : 만 61세 이상인 거주자, 2016년 1월 1일부터 2016년 12월 31일까지 가입하는 경우 : 만 62세 이상인 거주자, 2017년 1월 1일부터 2017년 12월 31일까지 가입하는 경우 : 만 63세 이상인 거주자, 2018년 1월 1일부터 2018년 12월 31일까지 가입하는 경우 : 만 64세 이상인 거주자, 2019년 1월 1일부터 가입하는 경우 : 만 65세 이상인 거주자</li>';
						content += 					'<li>2. 장애인복지법 제32조의 규정에 의하여 등록한 장애인</li>';
						content += 					'<li>3. 독립유공자예우에관한법률 제6조의 규정에 의하여 등록한 독립유공자와 그 유족 또는 가족, 국가유공자등 예우 및 지원에 관한법률 제6조의 규정에 의하여 등록한 상이자</li>';
						content += 					'<li>4. 국민기초생활보장법 제2조 제2호의 규정에 의한 수급자</li>';
						content += 					'<li>5. 고엽제후유의증환자지원등에 관한 법률 제2조 제3호의 규정에 의한 고엽제후유의증 환자</li>';
						content += 					'<li>6. 5 · 18민주유공자예우에 관한 법률 제4조 제2호의 규정에 의한 5 · 18민주화운동부상자</li>';
						content += 					'</ol>';
						content += 					'<strong>제3조(대상 예금 등)</strong>';
						content += 					'<p>은행이 취급하는 모든 예금 등을 원칙으로 한다. 다만, 다음 각 호의 예금 등과 각 취급은행이 별도로 정하는 예금 등은 제외합니다.</p>';
						content += 					'<ol>';
						content += 						'<li>1. 증서로 발행되고 유통이 가능한 예금 : CD, 표지어음, 무기명정기예금 등</li>';
						content += 						'<li>2. 어음 · 수표 등에 의해 지급이 가능한 예금 : 당좌예금, 가계당좌예금 등</li>';
						content += 						'<li>3. 조세특례제한법 등에 따라 기 취급중인 비과세 예금 등</li>';
						content += 						'<li>4. 외화예금</li>';
						content += 					'</ol>';
						content += 					'<strong>제4조(예치한도)</strong>';
						content += 					'<ol>';
						content += 						'<li>① 이 저축으로 거래하는 모든 예금 등 계좌의 예치한도는 원금을 합하여 5천만원(다만, 세금우대 종합저축에  가입한 경우에는  5천만원에서  세금우대종합저축의 계약금액 총액을 차감한 금액)을 초과할 수 없습니다.</li>';
						content += 						'<li>② 이 저축에서 발생하여 원금에 전입되는 이자 등은 1인당 한도계산에 있어서 이를 산입하지 않습니다. 다만, 입출금이 자유로운 예금은 최종 이자원가로 인하여 한도가 초과되는 경우를 제외하고는 저축한도에 포함합니다.</li>';
						content += 						'<li>③ 동일한 계좌에서 일부 금액만을 이 저축의 한도로 정할 수 없습니다.</li>';
						content += 					'</ol>';
						content += 					'<strong>제5조(예치한도 산정) </strong>';
						content += 					'<ol>';
						content += 						'<li>① 거치식 예금 등은 가입자가 가입한 예치원금으로 합니다.</li>';
						content += 						'<li>② 정액(정기)적립식예금 등은 월저축금에 계약기간을 곱한 금액으로 합니다.</li>';
						content += 						'<li>③ 입출금이 자유로운예금, 자유적립식 및 추가불입이 가능한 거치식예금 등은 저축가입자가 사전에 약정한 금액으로 합니다.</li>';
						content += 					'</ol>';
						content += 			'</div>';
						content += 		'</details>';
						content += 		'<div class="form-check">';
						content += 			'<input class="form-check-input" type="checkbox" value="" id="depositCheck3">';
						content += 			'<label class="form-check-label" for="defaultCheck1">동의하기</label>';  
						content += 		'</div>';
						content += 		'<details>';
						content += 			'<summary>계좌간 자동이체 약관</summary>';
						content += 			'<div class="detailContent">';
						content += 				'<p>';
						content += 				'<span class="area-left">2017. 3. 15 개정</span>';
						content += 				'<span class="area-right">준법감시인 심의필 번호 : 제2017-약관-0048호</span>';
						content += 				'</p>';
						content += 				'<h5>계좌간 자동이체 약관</h5>';
						content += 				'<strong>제1조 약관의 적용</strong>';
						content += 				'<p>예금주가 하나은행계좌간 이체를 희망하는 경우에는 별도 지급표를 징구하지 않고 정해진 기일에 계정간에 이체처리하는 업무를 말한다.</p>';
						content += 				'<strong>제2조 영업일</strong>';
						content += 				'<p>다음 각호의 휴일을 제외한 날을 영업일로 합니다.</p>';
						content += 				'<ol>';
						content += 					'<li>1.대통령령에 의한 관공서의 공휴일</li>';
						content += 					'<li>2.토요일</li>';
						content += 					'<li>3.근로자의 날</li>';
						content += 				'</ol>';
						content += 				'<strong>제3조 신청, 변경 및 해지</strong>';
						content += 				'<ol>';	
						content += 					'<li>① 이체지정일 2일전까지 자동이체 신청서에 의해 신규 및 변경, 해지 할 수 있습니다.</li>';
						content += 					'<li>② 입금계좌는 당좌, 가계당좌, 보통, 저축, 자유저축, 기업자유예금, MMDA, MMF, 수익증권, 적립식예금(신탁), 대출계좌 등입니다.</li>';
						content += 				'</ol>';
						content += 				'<strong>제4조 출금</strong>';
						content += 				'<ol>';
						content += 					'<li>① 은행의 예금약관이나 약정서의 규정에 불구하고 예금청구서 기타 관련증서 없이 자동이체 처리절차에 의하여 출금할수 있습니다.</li>';
						content += 					'<li>②  이체지정일에 출금계좌의 지급자금이 이체금액에 미달 하면 부족자금이 채워지는 날에 이체 처리 합니다.</li>';
						content += 					'<li>③ 대출금이자, 원(리)금은 부분 인출 가능합니다(상환 약정기일에 약정 금액이 납입되지 않은 경우 연체 상태가 완전히 해소 될 때까지는 23시 40분까지 입금할 경우에  당일 처리 가능합니다.</li>';
						content += 					'<li>④ 자동이체대금으로 입금된 어음, 수표등이 부도처리되는 경우에는 현금이체분을 포함한 전액이 출금취소 됩니다.</li>';
						content += 					'<li>⑤ 이체지정일이 (거래처가 지정한 날이 없는 월의 경우에는 해당 월의 말일 영업일) 이 휴일 등 영업일이 아닌 경우에는 익영업일에 이체 됩니다. 다만, 요구불계좌간자동이체는 전영업일과 익영업일중 중 이체일을 예금주가 선택할 수 있습니다.</li>';	
						content += 				'</ol>';	
						content += 				'<strong>제5조 최초 개시일</strong>';	
						content += 				'<p>자동이체 신규신청에 의한 이체개시일은 예금주가 최초 이체지정한 날을 기준으로 하며, 이체일 및 금액에 대한 지정없이 자동이체를 신청한 때는 은행은 그 대상거래가 발생했을 때 이체합니다. 다만, 천재지변 등 불가피한 사유가 발생하였을 때에는 지연 처리될 수 있습니다.</p>';
						content += 				'<strong>제6조 과실책임</strong>';
						content += 				'<p>자동이체 지정계좌 예금잔액(자동대출약정이 있는 경우 대출한도 포함)이 납기일 현재 청구금액보다 부족하거나, 예금의 지급 제한, 약정대출의 연체, 잔액증명서 발급, 연체, 법적제한 등 예금주의 과실에 의하여 이체가 불가능한 경우의 손해는 은행이 책임을 지지 아니합니다. </p>';
						content += 				'<strong>제7조 출금 우선순위</strong>';
						content += 				'<p>같은 날에 이체대상이 여러건 있는 때, 이체처리 순서는 은행이 정한 바에 따릅니다.</p>';
						content += 				'<strong>제8조 계좌이동서비스</strong>';
						content += 				'<ol>';
						content += 					'<li>① 계좌간자동이체는 계좌이동서비스 대상이며, 계좌이동서비스를 신청하는 경우 계좌이동서비스 이용약관을 따릅니다.</li>';
						content += 					'<li>② 은행은 자동이체 통합관리시스템(Payinfo.or.kr)에 자동이체 신청등록내역을 제공하여 신청인이 조회하고 해지 및 변경 신청이 가능하도록 합니다.</li>';
						content += 					'<li>③ 고객은 은행 영업점, 인터넷뱅킹(스마트폰뱅킹 포함), 자동이체 통합관리시스템(Payinfo.or.kr), 애플리케이션에서 계좌이동서비스를 신청할 수 있습니다.</li>';
						content += 					'<li>④ 고객이 은행 영업점 또는 인터넷뱅킹(스마트폰뱅킹 포함), 자동이체 통합관리시스템(Payinfo.or.kr), 애플리케이션에서 에서 자동이체 출금계좌를 당행 계좌로 변경 신청할 경우 타은행 출금계좌에 등록되어 있는 자동이체 해지 후, 당행 출금계좌로 신규 등록 됩니다.</li>';
						content += 				'</ol>';
						content += 				'<strong>제9조 다른 약관과의 관계</strong>';	
						content += 				'<p>계좌간 자동이체 거래에는 이 약관외에도 예금거래 기본약관, 입출금이 자유로운예금 약관, 전자금융거래 기본 약관관련 예금, 신탁약관 및 은행 내규를 준용합니다. 다만, 여신의 경우 여신거래기본약관이 우선합니다.</p>';	
						content += 			'</div>';
						content += 		'</details>';
						content += 		'<div class="form-check">';
						content += 			'<input class="form-check-input" type="checkbox" value="" id="depositCheck4">';
						content += 			'<label class="form-check-label" for="defaultCheck1">동의하기</label>';  
						content += 		'</div>';
						content += '</div>';
						content += '<button id="depositAgreeSend">전송하기</button>';
						
						$('#workModal').append(content);
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
		
		$(document).on('click', ".checkUserPassword", function(event) {
			$(this).attr('id')
			let accountNo = $(this).attr('id');
			console.log(accountNo)
			if(!checkPasswordPattern($('#password').val())) {
				$("#pw_check").text("비밀번호는 4자리의 숫자로 구성해주세요.");
				$("#pw_check").css("color", "red");
			} else {
				
				$.ajax({
					url : '${pageContext.request.contextPath}/account/password/'+accountNo,
					type : 'post',
					data : {
						password :  $('#password').val()
					},
					success : function(data) {
						if(data == true) {
							$("#pw_check").text("입력을 완료하였습니다.");
							$("#pw_check").css("color", "green");
							socket.emit('work', 'checkPasswordComp');
							$("#modal").fadeOut();			
						} else {
							$("#pw_check").text("입력하신 비밀번호가 계좌의 정보와 다릅니다.");
							$("#pw_check").css("color", "red");
						}
						
					},error : function() {
						alert('실패')	;					
					}
				})
				
			}
		})
		
		$(document).on('click', "#allAgree", function(event) {
			
			document.getElementById("depositCheck1").checked = true;
			document.getElementById("depositCheck2").checked = true;
			document.getElementById("depositCheck3").checked = true;
			document.getElementById("depositCheck4").checked = true;
			
		})
		
		$(document).on('click', "#depositAgreeSend", function(event) {
			
			if(document.getElementById("depositCheck1").checked && document.getElementById("depositCheck2").checked && document.getElementById("depositCheck3").checked && document.getElementById("depositCheck4").checked){
				socket.emit('work', 'depositAgreeComp');
				$("#modal").fadeOut();
				
			} else {
				alert('동의항목에 모두 동의하셔야 상품에 가입할 수 있습니다.');
			}
			
		})
		
		
		document.getElementById("modal_close_btn").onclick = function() {
			
			if(workType == 'pwChange'){
				socket.emit('work', 'pwClose');
			} else if(workType == 'inputPassword'){
				socket.emit('work', 'pwClose');
			} else if(workType == 'depositAgree'){
				socket.emit('work', 'depositAgreeClose');
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
