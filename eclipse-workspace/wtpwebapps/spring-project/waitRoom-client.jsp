<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>하나은행 화상창구 대기실</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.3.0/socket.io.dev.js"></script>
<script src="/spring-project/js/client/waitRoom/waitRoom-client.js"></script>
</head>
<body>
	손님
	<input type="button" id="bankJob" value="예/적금 업무">
	<p>결과 :</p>
	<div id="result"></div>
	<div align="center" id="loading_image" style="width:100%; height:100%; text-align:center; font-size:12pt; color:black; font-weight:bold; padding-top:100px;">
		<img src="/rtc-merge/image/loading.gif"><br>
		Loading ...
	</div>
</body>
</html>