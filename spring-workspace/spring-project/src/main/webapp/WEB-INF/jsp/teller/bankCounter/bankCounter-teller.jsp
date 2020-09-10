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
		
		/*
		border-style: solid;
		border-width: 1px;
		border-color: red;
		*/
	}
	
	#clientVideoDiv {
		float : left;
		display : inline;
		width : 50%;
		
		/*
		border-style: solid;
		border-width: 1px;
		border-color: green;
		*/
	}
	
	#tellerVideoDiv {
		text-align : center;
		float : right;
		display : inline;
		width : 25%;
		
		/*
		border-style: solid;
		border-width: 1px;
		border-color: blue;
		*/
	}
	
	#shareVideoDiv {
		
		float : left;
		disply : inline-block;
		width: 25%;
		
		/*
		border-style: solid;
		border-width: 1px;
		border-color: gray;
		*/
	}
	
	#client-info {
		float : left;
		disply : inline;
		width: 25%;
		padding-left : 10px;
		padding-right : 10px;
		
		/*
		border-style: solid;
		border-width: 1px;
		border-color: aqua;
		*/
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
	
	#workArea {
		/*
		border-style: solid;
		border-width: 1px;
		border-color: maroon;
		background-color: red;
		*/
	}
	
	#workDiv {
		width:100%;
		display : inline;
		float:left;
	}
	
	#workTitle{
	
		font-size:x-large;	
		display : inline-block;
		float : left;
	}
	
	#workBtns {
		display : inline-block;
		float : right;
	}
	/*
	#workDiv #workName {
		font-size:x-large;
	}
	*/
	
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
	
	div .modal-content {
		width : 500px;
	}
	
	#workSpace {
		text-align : center;
	}
	
	.btn-info {
		width : 200px;
		height : 50px;
	}
	
	.depositSignUpBtn {
		border-color : white;
		border-radius:10px 10px 10px 10px;
	}
	
	#camAndchat {
		
	}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.3.0/socket.io.dev.js"></script>
	<script src="https://www.webrtc-experiment.com/common.js"></script>
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
    			<div>
    				<input type="text" id="workCode" style="width : 70%;">
    				<button id="searchWork">검색</button>
    			</div>
    		</div>
    		<div class="list-group list-group-flush">
	   		<!-- <a href="#" class="list-group-item list-group-item-action bg-light">Dashboard</a>  -->
	   		<a id="work_selectMenu1000" class="list-group-item list-group-item-action bg-light">계좌 조회(1000)</a>
	   		<a id="work_selectMenu1001" class="list-group-item list-group-item-action bg-light">자유입출금 예금 업무(1001)</a>
    		<a id="work_selectMenu1003" class="list-group-item list-group-item-action bg-light">예금 업무(1003)</a>
    		<a id="work_selectMenu1004" class="list-group-item list-group-item-action bg-light">적금 업무(1004)</a>
    		<a class="list-group-item list-group-item-action bg-light">계좌 이체(1005)</a>
    		<a id="work_selectMenu1006" class="list-group-item list-group-item-action bg-light">계좌 제신고(1006)</a>
    		<a id="work_selectMenu1007" class="list-group-item list-group-item-action bg-light">전자금융(1007)</a>
    		<a class="list-group-item list-group-item-action bg-light">카드 조회(1008)</a>
    		<a class="list-group-item list-group-item-action bg-light">체크 카드 업무(1009)</a>
    		<a class="list-group-item list-group-item-action bg-light">신용 카드 업무(1010)</a>
    		<a class="list-group-item list-group-item-action bg-light">카드 제신고(1011)</a>
    		
   			</div>
   		</div>
   		<!-- /#sidebar-wrapper -->

   		<!-- Page Content -->
    	<div id="page-content-wrapper">
    		<div class="container-fluid">
    			<div id="camAndchat">
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
    				<!--<video id="localVideo" autoplay playsinline> -->
    					<source style="width: 100%">
    				</video>
	    		</div>
    			
    			<div id="client-info">
    				<div style="font-size:x-large;">
    					${clientVO.name } 손님
    				</div>
    				<br>
	    			<div>
    					휴대폰번호 : 
    					<div id="phone" style="display:inline-block;">${clientVO.tel}</div>
    					<div style="text-align:right;">
    						<div id="authStatus" style="color: red; display: inline-block;">휴대폰 본인인증 미완료</div>
	    					<button id="sendSMSAuth">문자 인증</button>
    					</div>
    				</div>
					<div>
						주민등록번호 : <div id="regNo" style="display:inline-block;">${clientVO.regNo}</div>
					</div>
					<br>
					<div id="elecFinanceStatus">
					전자금융 가입여부 :
						<c:choose>
							<c:when test="${ clientVO.elecFinanceStatus == 'T' }">
								O
							</c:when>
							<c:otherwise>
								X
							</c:otherwise>
						</c:choose>
					</div>
					<div style="text-align: right;">
						<button id="screenShareBtn">화면 공유</button>
						<!-- 
						<button id="reverseClientScreen">화면 반전</button>
						 -->
						<button id="captureID">신분증 캡쳐</button>
						<button id="exit">상담 종료</button>
					</div>
    			</div>
    			
    			<div id="shareVideoDiv">
    				<video id="screenShareVideo" poster="${ pageContext.request.contextPath }/resources/images/tellerSharePoster.png" autoplay playsinline muted>
	    				<source style="width: 100%">
    				</video>
    			</div>
    		</div>
    	
    		<div id="workArea">
				<div id="workTitle"></div>
    			<div id="workBtns"></div>
    			<div id="workDiv"></div>    		
    		</div>
    	
    		
			</div>
				
   		</div>
   	</div>
	</div>
    <!-- /#page-content-wrapper -->	
	<footer>
		<%@include file="/WEB-INF/jsp/include/footer.jsp" %>
	</footer>
</body>
<%@include file="/js/teller/bankCounter/js-signalServerEvent-teller.jsp" %>
<%@include file="/js/teller/bankCounter/js-bankCounter-teller.jsp" %>
<%@include file="/js/teller/bankCounter/js-smsAuthEvent-teller.jsp" %>
<%@include file="/js/teller/bankCounter/js-captureIDEvent-teller.jsp" %>
<%@include file="/js/teller/bankCounter/js-accountViewEvent-teller.jsp" %>
<%@include file="/js/teller/bankCounter/js-depositEvent-teller.jsp" %>
<%@include file="/js/teller/bankCounter/js-savingEvent-teller.jsp" %>
<%@include file="/js/teller/bankCounter/js-reportEvent-teller.jsp" %>
<%@include file="/js/teller/bankCounter/js-elecFinanceEvent-teller.jsp" %>
<script>
	let phone = '';
	for(let i = 0; i < $('#phone').text().length; i++) {
		if(i == 3 || i == 7)
			phone += '-';
		phone += $('#phone').text()[i];
	}
	$('#phone').text(phone);
	
	let regNo = '';
	for(let i = 0; i < $('#regNo').text().length; i++) {
		if(i == 6)
			regNo += '-';
		regNo += $('#regNo').text()[i];
	}
	$('#regNo').text(regNo);
</script>
</html>