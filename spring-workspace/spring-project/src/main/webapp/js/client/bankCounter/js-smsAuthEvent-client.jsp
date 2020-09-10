<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	
	function smsAuth() {
		
		$('#workModal').empty();
		let content = '';
		content += '휴대폰 본인인증 화면';
		content += '<button id="startAuth">인증하기</button>';
		
		$('#workModal').append(content);
		
		$('#modal_close_btn').empty();
		$('#modal_close_btn').append('취소하기');
		
		$("#modal").fadeIn();
		
	}
	
	function startAuth() {
		$('#workModal').empty();
		let content = '';
		content += '<div>휴대폰 본인인증 화면</div>';
		content += '<div>휴대폰에 인증문자를 발송하였습니다. 확인 후 입력해주세요.</div>';
		content += '<input type="text" autocomplete="off" id="sms">';
		content += '<button id="checkSMS">인증하기</button>';
		
		$('#workModal').append(content);
		
		$('#modal_close_btn').empty();
		$('#modal_close_btn').append('취소하기');
		
		$("#modal").fadeIn();
		
		$.ajax({ 
			
			url: '${pageContext.request.contextPath}/sendSMS/', 
			data: { 
				receiver: '${userVO.tel}' 
			}, 
			type: "post", 
			success: function(result) {
				
				if (result == "ok") { 
					
				} else { 
					alert("인증번호 전송 실패"); 
				} 
			}
			
		});
		
	}
	
	$(document).on('click', "#startAuth", function() {
		startAuth();
	})
	
	$(document).on('click', "#checkSMS", function() {
		phoneCheck();
	})
	
	
	function phoneCheck() { 
		$.ajax({ 
			url: '${pageContext.request.contextPath}/smsCheck/',
			type: "post", 
			data: { 
				code: $("#sms").val() 
			}, 
			success: function(result) { 
				if (result == true) { 
					$('#workModal').empty();
					let content = '';
					content += '본인 인증에 성공하셨습니다.';
					
					$('#workModal').append(content);
					
					$('#modal_close_btn').empty();
					$('#modal_close_btn').append('확인');
					
					$("#modal").fadeOut();
					socket.emit('work', 'authComp');
				} else { 
					alert("번호 인증 실패"); 
				} 
			} 
		}); 
	}
</script>