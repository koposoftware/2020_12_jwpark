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
    				
    				<form class="form-horizontal" action="${pageContext.request.contextPath }/teller/report" method="post" name="lForm" >
    					<div class="middleCategory" style="text-align:left; font-size:x-large; margin-bottom:10px;">
    						상담 분류
    						<div id="check">
	    						<input type="radio" name="chk_info" value="예금">예금
	    						<input type="radio" name="chk_info" value="적금">적금
	    						<input type="radio" name="chk_info" value="카드">카드
	    						<input type="radio" name="chk_info" value="대출">대출
	    						<input type="radio" name="chk_info" value="연금">연금
	    						<input type="radio" name="chk_info" value="펀드">펀드
	    						<input type="radio" name="chk_info" value="보험">보험
	    						<input type="radio" name="chk_info" value="외환">외환
	    						<input type="radio" name="chk_info" value="수표">수표
	    						<input type="radio" name="chk_info" value="금">금
    						<!-- <input type="radio" name="chk_info" value="단순 상담">단순 상담  -->
    						</div>
    					</div>
    					
						<div class="input-group input-group-lg">
  							
  							<input type="text" class="form-control" aria-label="Large" id="empNo" name="empNo" maxlength="20" placeholder="한줄 제목" autocomplete="off" aria-describedby="inputGroup-sizing-sm">
						</div>
						<br>
						<div class="input-group input-group-lg">
  							<textarea id="reportArea" rows="5" placeholder="한줄 상담리포트" class="form-control" autocomplete="off" aria-describedby="inputGroup-sizing-sm">
  							
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
<script>
	$('#reportArea').empty();
	$("input:radio[name='chk_info']:radio[value='예금']").prop('checked', true); // 선택하기
</script>
</html>