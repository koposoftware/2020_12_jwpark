<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	
	$("#sendSMSAuth").bind('click', function(event) {
		
		$('#workModal').empty();
		let content = '';
		content += '손님에게 문자인증 화면을 출력하였습니다.';
		$('#workModal').append(content);
		$("#modal").fadeIn();
		
		socket.emit('work', 'smsAuth');
	})
	
	function authComp() {
		$('#workModal').empty();
		let content = '';
		content += '손님이 휴대폰 본인인증을 완료하였습니다.';
		
		$('#workModal').append(content);
		$("#modal").fadeIn();
		
		$('#authStatus').css("color", "green");
		$('#authStatus').text("휴대폰 본인인증 완료");
		
		$('#chkTelAuth').css("color", "green");
		$('#chkTelAuth').text("휴대폰 인증 완료");
		
		chkTelAuth = true;
	}
	
</script>