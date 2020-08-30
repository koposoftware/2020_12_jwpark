<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>하나은행 화상창구 대기실</title>
<link rel="icon" type="image/png" sizes="16x16" href="${ pageContext.request.contextPath }/resources/images/favicon/favicon.ico">
<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.3.0/socket.io.dev.js"></script>
<!-- <script src="/spring-project/js/client/waitRoom/waitRoom-client.js"></script>  -->
<style>
	.title{
		font-size: xxx-large;
		text-align: center;
		margin-top : 120px;
	}
	
	div .col-md-7 {
		flex: none;
		max-width : none;
	}
	
	.menu {
		font-size: xx-large;
		text-align: center;
		margin-top : 100px;
	}
	
	.job {
		
		width: 250px;
		height : 100px;
		border-color: white;
		font-size: xx-large;
		border-width: inherit;
		background-color: lightgray;
		border-radius: 20px 20px 20px 20px
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
	
	aside #link{
		padding-left: 25px;
	}
	
	aside .refMsg {
		margin-top : 80px;
		margin-right : 100px;
	}
	
	.btn-primary {
		width : 120px;
		height : 120px;
		
	}
	
	.stmInfo {
		
		font-size: x-large;
	}
	
	#STMlink {
		font-size: large;
		width : 350px;
		height : 50px;
		margin-top: 10px;
	}
	
	#modal_close_btn {
		border-color: white;
		border-width: inherit;
		background-color: lightgray;
		border-radius: 10px 10px 10px 10px;
		font-size: large;
	}
	
	#clientCount{
		font-size : x-large;
	}
</style>
</head>

<body>
	<header>
		<%@include file="/WEB-INF/jsp/include/header.jsp" %>
	</header>
	
	<div id="modal">
			<div class="modal_content">
			
				<div align="center" id="loading_image" style="width:100%; height:100%; text-align:center; font-size: large; color:black; font-weight:bold;">
								<img src="${ pageContext.request.contextPath }/resources/images/loading.gif"><br>
								<div id="clientCount">상담 대기중인 손님 0명</div>
								<br>
								손님, 잠시만 기다려주세요.<br>
								텔러와 연결중입니다.
				</div>
				<button type="button" id="modal_close_btn">취소하기</button>
    			<!-- 
    			<h2>모달 창</h2>
    			<p>모달 창 입니다.</p>
    			 -->
    		</div>
    	<div class="modal_layer"></div>    	
    </div>
	<aside style="float: right; align-content: center;">
		<div class="refMsg" style="font-size: large">상담 전 참고해보세요!</div>
		
		<div id="link"><br>
		<img src="${ pageContext.request.contextPath }/resources/images/list.jpg" style="width:120px;">
		<br>
		<br>
			<button class="btn btn-primary" id="deposit" style="font-size:x-large; background-color: #008C8C; border-color: #008C8C; border-radius: 20px 20px 20px 20px;">예/적금</button><br><br>
			<button class="btn btn-primary" id="card" style="font-size:x-large; background-color: #008C8C; border-color: #008C8C; border-radius: 20px 20px 20px 20px;">카드</button><br><br>
			<button class="btn btn-primary" id="fund" style="font-size:x-large; background-color: #008C8C; border-color: #008C8C; border-radius: 20px 20px 20px 20px;">펀드</button><br><br>
			<button class="btn btn-primary" id="insurance" style="font-size:x-large; background-color: #008C8C; border-color: #008C8C; border-radius: 20px 20px 20px 20px;">보험</button><br><br>
		</div>
		
	</aside>    				
	<section>
		<div id="page-content">
    		<div class="container text-center">
    			<div class="row justify-content-center">
	    			<div class="col-md-7">
    					<div class="title">손님, 원하시는 업무를 선택해주세요.</div>
    					<div class="menu">
    						<input type="button" class="job" id="bankJob" value="예/적금 업무">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" class="job" id="cardJob" value="카드 업무">
							<br>
							<br>
							<input type="button" class="job" id="efJob" value="전자금융 업무">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" class="job" id="certificationJob" value="증명서 발급 업무">
    					</div>
	    			</div>
	    			<div class="stmInfo">
	    				<br><br><br>
	    				각종 발급 업무는 STM창구를 이용하시면 더 빨리 해결하실 수 있습니다.<br>
	    				<input type="button" id="STMlink" value="STM 위치 조회">
	    			</div>
    			</div>
    		</div>
    	</div>
	</section>
	
	<footer>
		<%@include file="/WEB-INF/jsp/include/footer.jsp" %>
	</footer>
</body>
<%@include file="/js/client/waitRoom/js-waitRoom-client.jsp" %>
</html>
