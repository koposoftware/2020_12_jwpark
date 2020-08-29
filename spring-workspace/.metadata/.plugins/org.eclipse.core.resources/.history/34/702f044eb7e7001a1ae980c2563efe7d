<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>화상창구상담 서비스</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.3.0/socket.io.dev.js"></script>
	<script src="https://www.webrtc-experiment.com/common.js"></script>
<script src="/spring-project/js/client/bankCounter/bankCounter-client.js"></script>
</head>
<body>

	<h1>손님화면</h1>
	
	<div align="center" id="loading_image" style="width:100%; height:100%; text-align:center; font-size:12pt; color:black; font-weight:bold; padding-top:100px;">
		<img src="/spring-project/image/loading.gif"><br>
		Loading ...
	</div>
	
	<div id="videos">
		<video id="localVideo" autoplay muted playsinline></video>
		<video id="remoteVideo" autoplay playsinline></video>
	</div>
	
	<h1>getDisplayMedia demo</h1>
	<p>Purpose of this demo is to test all getDisplayMedia API functionalities.</p>
	<br><br><br>
	<button id="screenShareBtn">Test getDisplayMedia API</button>
	<hr>
	<video id="screenShareVideo" autoplay playsinline muted="false" volume=0></video>
	<br>
	<textarea id="settings" style="width: 100%; height: 218px; display: none;"></textarea>
	<br>
	<textarea id="capabilities" style="width: 100%; height: 354px; display: none;"></textarea>
	<br>
	
	<hr/>
	<p>log</p>
	<div id="result"></div>
</body>
</html>