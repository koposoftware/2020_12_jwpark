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
<!-- <script src="/spring-project/js/client/bankCounter/bankCounter-client.js"></script>  -->

</head>
<body>
	<header>
		<%@include file="/WEB-INF/jsp/include/header.jsp" %>
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
			<!--<video id="localVideo" autoplay playsinline>-->
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
		
		<div>
			<button id="exit">상담 종료</button>
		</div>
	</div>
	
</body>
<%@include file="/js/client/bankCounter/js-signalServerEvent-client.jsp" %>
<%@include file="/js/client/bankCounter/js-bankCounter-client.jsp" %>
<%@include file="/js/client/bankCounter/js-depositEvent-client.jsp" %>
<%@include file="/js/client/bankCounter/js-elecFinanceEvent-client.jsp" %>
<%@include file="/js/client/bankCounter/js-reportEvent-client.jsp" %>
<%@include file="/js/client/bankCounter/js-savingEvent-client.jsp" %>
<%@include file="/js/client/bankCounter/js-smsAuthEvent-client.jsp" %>
<%@include file="/js/client/bankCounter/js-captureIdEvent-client.jsp" %>
</html>