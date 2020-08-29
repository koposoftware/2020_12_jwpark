<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>하나 화상창구 로그인</title>
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
    				<div class="title">손님, 로그인을 해주세요</div>
    				<div class="loginDiv">
    				
    				<form class="form-horizontal" action="${pageContext.request.contextPath }/login" method="post" name="lForm" >
    				
						<div class="input-group input-group-lg">
  							<div class="input-group-prepend">
    							<span class="input-group-text" id="inputGroup-sizing-lg">
    								<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-person" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  										<path fill-rule="evenodd" d="M13 14s1 0 1-1-1-4-6-4-6 3-6 4 1 1 1 1h10zm-9.995-.944v-.002.002zM3.022 13h9.956a.274.274 0 0 0 .014-.002l.008-.002c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664a1.05 1.05 0 0 0 .022.004zm9.974.056v-.002.002zM8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4zm3-2a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
									</svg>
								</span>
  							</div>
  							<input type="text" class="form-control" aria-label="Large" id="id" name="id" maxlength="20" placeholder="ID를 입력해주세요" autocomplete="off" aria-describedby="inputGroup-sizing-sm">
						</div>
						<br>
						<div class="input-group input-group-lg">
  							<div class="input-group-prepend">
    							<span class="input-group-text" id="inputGroup-sizing-lg">
    								<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-key" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  										<path fill-rule="evenodd" d="M0 8a4 4 0 0 1 7.465-2H14a.5.5 0 0 1 .354.146l1.5 1.5a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0L13 9.207l-.646.647a.5.5 0 0 1-.708 0L11 9.207l-.646.647a.5.5 0 0 1-.708 0L9 9.207l-.646.647A.5.5 0 0 1 8 10h-.535A4 4 0 0 1 0 8zm4-3a3 3 0 1 0 2.712 4.285A.5.5 0 0 1 7.163 9h.63l.853-.854a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.793-.793-1-1h-6.63a.5.5 0 0 1-.451-.285A3 3 0 0 0 4 5z"/>
  										<path d="M4 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
									</svg>
								</span>
  							</div>
  							<input type="password" class="form-control" aria-label="Large" name="password" id="pwd" placeholder="비밀번호를 입력해주세요" maxlength="20" aria-describedby="inputGroup-sizing-sm">
						</div>
						<div align="center">
						
    					<br>
    					<button type="submit" class="btn btn-primary btn-lg" style="background-color: #008c8c; border-color: #008c8c; float: right">로 그 인</button>
    					&nbsp;&nbsp;&nbsp;
    					<button type="submit" class="btn btn-primary btn-lg" style="background-color: #008c8c; border-color: #008c8c; float: right; margin-right: 10px;">회원가입</button>
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
</html>