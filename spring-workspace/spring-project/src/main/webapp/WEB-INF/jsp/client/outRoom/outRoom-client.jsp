<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>하나은행 화상창구</title>
	<link rel="icon" type="image/png" sizes="16x16" href="${ pageContext.request.contextPath }/resources/images/favicon/favicon.ico">
</head>
<style>
	.title{
		font-size: xxx-large;
		text-align: center;
		margin-top : 150px;
	}
	
	.loginDiv {
		text-align: center;
		margin-top : 300px;
	}
	
	.btn-primary {
    	color: #fff;
    	background-color: #008c8c;
    	border-color: #008c8c;
    	width : 150px;
	}
	
</style>
<body>
	<header>
		<%@include file="/WEB-INF/jsp/include/header.jsp" %>
	</header>
	<section>
	
		<div id="page-content">
    	<div class="container text-center">
    		<div class="row justify-content-center">
    			<div class="col-md-7">
    				<div class="title">이용해주셔서 감사합니다.</div>
    				<button class="btn btn-primary btn-lg" style="background-color: #008c8c; border-color: #008c8c; float: right; margin-right: 10px;">이어서 상담하기</button>
    				<button class="btn btn-primary btn-lg" style="background-color: #008c8c; border-color: #008c8c; float: right; margin-right: 10px;">상담 내역 확인</button>
    			</div>
    		</div>
    	</div>
    </div>
    
	</section>
	<footer>
		<%@include file="/WEB-INF/jsp/include/footer.jsp" %>
	</footer>
</body>
</html>