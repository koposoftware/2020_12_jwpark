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
    			<div class="col-md-7">
    				<div class="title">상담내용을 기록해주세요.</div>
    				<div class="reportDiv">
    				<div id="client-info" style="text-align:left; font-size:xx-large;">${clientVO.name} 손님</div>
    				
    				<form class="form-horizontal" action="${pageContext.request.contextPath }/teller/report" onsubmit="return checkInput()" method="post" name="lForm" >
    					<div class="middleCategory" style="text-align:left; font-size:x-large; margin-bottom:10px;">
    						상담 분류
    						<div id="check">
	    						<input type="radio" name="chk_info" value="1">예금
	    						<input type="radio" name="chk_info" value="2">적금
	    						<input type="radio" name="chk_info" value="3">카드
	    						<input type="radio" name="chk_info" value="4">대출
	    						<input type="radio" name="chk_info" value="5">연금
	    						<input type="radio" name="chk_info" value="6">펀드
	    						<input type="radio" name="chk_info" value="7">보험
	    						<input type="radio" name="chk_info" value="8">외환
	    						<input type="radio" name="chk_info" value="9">수표
	    						<input type="radio" name="chk_info" value="10">금
    						</div>
    					</div>
    					
						<div class="input-group input-group-lg">
  							<input id="reportTitle" name="reportTitle" type="text" class="form-control" aria-label="Large" maxlength="20" placeholder="한줄 제목" autocomplete="off" aria-describedby="inputGroup-sizing-sm">
						</div>
						<br>
						<div class="input-group input-group-lg">
  							<textarea id="reportArea" name="reportArea" rows="5" placeholder="한줄 상담리포트" class="form-control" autocomplete="off" aria-describedby="inputGroup-sizing-sm">
  							
  							</textarea>
						</div>
						<div align="center">
    					<br>
    					<button type="submit" class="btn btn-primary btn-lg" style="background-color: #008c8c; border-color: #008c8c; float: right">저장하기</button>    					
  						</div>
  		  			</form>
    				
    				</div>
    			</div>
    		</div>
    	</div>
    </div>
    
	</section>
	<footer>
		<%@include file="/WEB-INF/jsp/include/footer.jsp" %>
	</footer>
</body>
<%@include file="/js/teller/outRoom/js-outRoom-teller.jsp" %>
</html>