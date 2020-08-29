<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	<title>하나 화상창구 서비스 - 텔러</title>
	<link rel="icon" type="image/png" sizes="16x16" href="${ pageContext.request.contextPath }/resources/images/favicon/favicon.ico">
	<style>
		.title{
			
			font-size: xxx-large;
			text-align: center;
			margin-top : 150px;
		}
		
		#page-content {
			flex: 1 0 auto;
			height: 100%;
			width : 100%;
			background-size : 100% 90%;
			background-repeat: no-repeat;
			//background-image :url('${ pageContext.request.contextPath }/resources/images/w.jpg');
		}
		
		.start {
			
			text-align: center;
			margin-top : 200px;
		}
		
		#startBtn {
			
			height: 70px;
			width: 300px;
			border-color: white;
			font-size: xx-large;
			border-width: inherit;
			background-color: lightgray;
			border-radius: 20px 20px 20px 20px
		}
		
		.covervid-video {
			z-index : 9997;
    		position: absolute;
    		top: 50px;
    		left: 0;
    		width: 100%;
    		height: 100%;
		}
		
	</style>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
	<script>
		$(document).ready(function() {
			$("#startBtn").click(function() {
				<c:choose>
					<c:when test="${ not empty tellerVO}">
						location.href="${pageContext.request.contextPath}/teller/waitRoom";
					</c:when>
					<c:otherwise>
						location.href="${pageContext.request.contextPath}/teller/login";
					</c:otherwise>
				</c:choose>
				
			})
		})
	</script>
</head>
<body>
	<header>
		<%@include file="/WEB-INF/jsp/include/header_teller.jsp" %>
	</header>
	<div id="page-content">
    	<div class="container text-center">
    		<div class="row justify-content-center">
    			<div class="col-md-7">
    				<div class="title">하나은행 화상 창구상담 서비스 - 직원 화면<br><br><br>손님의 기쁨, 그 하나를 위하여</div>
    				<div class="start">
    					<input type="button" id="startBtn" value="시작하기">
    				</div>
    			</div>
    		</div>
    	</div>
    </div>
    <footer>
    	<%@include file="/WEB-INF/jsp/include/footer.jsp" %>
	</footer>
	
	<!-- 
		<div class="covervid-wrapper">
    	<video class="covervid-video" autoplay loop muted>
        	<source src="${ pageContext.request.contextPath }/resources/assets/videos/hanavideo.mp4" type="video/mp4">
        </video>
        </div>
     -->

	<!-- 
	<script src="${ pageContext.request.contextPath }/covervid.js"></script>
	<script src="${ pageContext.request.contextPath }/resources/assets/scripts/scripts.js"></script>

	
	<script type="text/javascript">
		// If using jQuery
			 //$('.masthead-video').coverVid(1920, 1080);
			$('.coverid-video').coverVid(1920, 1080);
		// If not using jQuery (Native Javascript)
			//coverVid(document.querySelector('.masthead-video'), 640, 360);
	</script>
	 -->
	
	<!-- 
	<section class="masthead">
		<video class="masthead-video" autoplay loop muted style="margin-top : 120px">
			<source src="${ pageContext.request.contextPath }/resources/assets/videos/hanavideo.mp4" type="video/mp4">
		</video>
		 
		<div class="masthead-overlay"></div>
		<div class="masthead-arrow"></div>
		
	</section>
	-->

</body>

</html>