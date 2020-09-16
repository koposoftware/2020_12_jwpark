<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>하나 화상창구 - 텔러</title>
	<link rel="icon" type="image/png" sizes="16x16" href="${ pageContext.request.contextPath }/resources/images/favicon/favicon.ico">
</head>
<style>
	.title{
		font-size: xxx-large;
		text-align: center;
		margin-top : 60px;
		display:block;
	}
	
	.reportDiv {
		text-align: center;
		margin-top : 50px;
	}
	
	.btn-primary {
    	color: #fff;
    	background-color: #008c8c;
    	border-color: #008c8c;
    	width : 150px;
	}
	
	#client-info {
		margin-bottom : 10px;
	}
	
	#check {
		padding-left : 10px;
	}
</style>
<body>
	<header>
		<%@include file="/WEB-INF/jsp/include/header_teller.jsp" %>
	</header>
	<section>
		<div id="page-content">
    	<div class="container text-center">
    		<div class="row justify-content-center" style="display : block">
    			<div class="title">업무 기록 관리</div>
    			<br>
    			<div class="reportDiv">
    				<!-- <table border="1" style="width: 100%">  -->
    				<table class="table table-hover" style="width: 100%; text-align:center">
						<tr>
							<th>손님</th>
							<th>상담 분류</th>
							<th>제목</th>
							<th style="width:40%">내용</th>
							<th>텔러</th>
							<th>상담 일시</th>
						</tr>
						<c:forEach items="${records}" var="record" varStatus="loop">
							<tr>
								<td>${record.name}(${record.id})</td>
								<td>${record.middleCategory}</td>
								<td>${record.title}</td>
								<td>${record.consultingReport}</td>
								<td>${record.adminName}(${record.empno})</td>
								<td>${record.reportYmd}</td>
							</tr>
						</c:forEach>
					</table>
    			</div>
    			<div style="text-align: right">
    				<button id="go">대기실로 이동</button>
    				
    			</div>			
    		</div>
    	</div>
    </div>
    
	</section>
	<footer>
		<%@include file="/WEB-INF/jsp/include/footer.jsp" %>
	</footer>
</body>
<script>
	$(document).on('click', "#go", function() {
		
		location.href="${pageContext.request.contextPath}/teller/waitRoom";
	})
</script>
</html>