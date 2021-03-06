<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Bootstrap core CSS -->
<link href="${ pageContext.request.contextPath }/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="${ pageContext.request.contextPath }/resources/css/simple-sidebar.css" rel="stylesheet">
<style>

	@font-face {
		font-family: Hana B;
		src: url('${ pageContext.request.contextPath }/resources/css/HANAB.TTF');
	}
	
	html, body {
		height: 100%;
	}
	
	.bg-light {
		background-color: #FFFFFF!important;
	}
	
	nav.navbar.navbar-expand-lg.navbar-light.bg-light div.container {
		padding-left : 100;
		margin-left : 100;
	}
	
	nav.navbar.navbar-expand-lg.navbar-light.bg-light {
		width: 100%;
		border-bottom-color: black;
		border-bottom-width: thin;
		border-bottom-style: solid;
	}
	
	body{
		font-family: "Hana B";
		overflow:auto;
	}
</style>
<!-- Bootstrap core JavaScript -->
<script src="${ pageContext.request.contextPath }/vendor/jquery/jquery.min.js"></script>
<script src="${ pageContext.request.contextPath }/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div class="container" style="padding-left : 70px">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/"><img src="${ pageContext.request.contextPath }/resources/images/hanalogo.png" style="width:150px; height:40px;"></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
	</div>
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav ml-auto">
			<c:choose>
				<c:when test="${ userVO.id != null }">
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="float: right; font-size: large;">
							${ userVO.name }님 환영합니다.
						</a>
						<div class="dropdown-menu dropdown-menu-right animate slideIn" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">Action</a>
							<a class="dropdown-item" href="#">Another action</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/logout">로그아웃</a>
						</div>
					</li>
				</c:when>
				<c:otherwise>
					<a href="${pageContext.request.contextPath}/login" style="padding-right: 30px; font-size: x-large;">로그인</a>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</nav>