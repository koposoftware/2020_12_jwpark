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
		margin-top : 150px;
	}
	
	.reportDiv {
		text-align: center;
		margin-top : 90px;
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
    		<div class="row justify-content-center">
    			<div class="title">업무 기록 관리</div>
    				<div class="reportDiv">
    					<table class="table table-hover" style="width: 100%; text-align:center">
    					<!-- <table border="1" style="width: 100%">  -->
							<tr>
								<th>텔러</th>
								<th>상담 분류</th>
								<th>제목</th>
								<th>내용</th>
								<th>손님</th>
								<th>상담 일시</th>
							</tr>
							<c:forEach items="${records}" var="record" varStatus="loop">
								<tr>
									<td>${record.adminName}(${record.empNo})</td>
									<td>${record.middleCategory}</td>
									<td>${record.title}</td>
									<td>${record.consultingReport}</td>
									<td>${record.name}(${record.id})</td>
									<td>${record.reportYMD}</td>
								</tr>
							</c:forEach>
						</table>
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