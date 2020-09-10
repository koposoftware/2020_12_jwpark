<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

	var telCheck = false;
	
	$("#sendSMSAuth").bind('click', function(event) {
		
		$('#workModal').empty();
		let content = '';
		content += '손님에게 문자인증 화면을 출력하였습니다.';
		$('#workModal').append(content);
		$("#modal").fadeIn();
		
		socket.emit('work', 'smsAuth');
	})
	
</script>