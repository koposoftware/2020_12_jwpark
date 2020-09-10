<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

	function accountPwChange() {
		$('#workModal').empty();
		let content = '';
		content += '<input type="password" name="password" id="password" maxlength="4" placeholder="계좌 비밀번호 4자리를 입력해주세요." class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">';
		content += '<div id="pw_check"></div>';
		content += '<button id="changePassword">설정하기</button>';
	
		$('#modal_close_btn').empty();
		$('#modal_close_btn').append('취소하기');
	
		$('#workModal').append(content);
	
		$("#modal").fadeIn();
	}

	$(document).on('click', "#changePassword", function(event) {
		if(!checkPasswordPattern($('#password').val())) {
			$("#pw_check").text("비밀번호는 4자리의 숫자로 구성해주세요.");
			$("#pw_check").css("color", "red");
		} else {
			$("#pw_check").text("사용 가능한 비밀번호입니다.");
			$("#pw_check").css("color", "green");
			socket.emit('work', 'passwordChangeComp:' + encoding($('#password').val()));
			$("#modal").fadeOut();
		}
	})
	
	$(document).on('click', ".checkUserPassword", function(event) {
		$(this).attr('id')
		let accountNo = $(this).attr('id');
		console.log(accountNo)
		if(!checkPasswordPattern($('#password').val())) {
			$("#pw_check").text("비밀번호는 4자리의 숫자로 구성해주세요.");
			$("#pw_check").css("color", "red");
		} else {
			
			$.ajax({
				url : '${pageContext.request.contextPath}/account/password/'+accountNo,
				type : 'post',
				data : {
					password :  $('#password').val()
				},
				success : function(data) {
					if(data == true) {
						$("#pw_check").text("입력을 완료하였습니다.");
						$("#pw_check").css("color", "green");
						socket.emit('work', 'checkPasswordComp');
						$("#modal").fadeOut();			
					} else {
						$("#pw_check").text("입력하신 비밀번호가 계좌의 정보와 다릅니다.");
						$("#pw_check").css("color", "red");
					}
					
				},error : function() {
					alert('실패')	;					
				}
			})
		}
	})
	
	function lostReport() {
		$('#workModal').empty();
		let content = '';
		content += '<div>분실신고가 완료되었습니다.</div>';
		$('#workModal').append(content);
		
		$('#modal_close_btn').empty();
		$('#modal_close_btn').append('확인');
		
		$("#modal").fadeIn();
	}
	
	function cancleLostReport() {
		$('#workModal').empty();
		let content = '';
		content += '<div>분실신고해제가 완료되었습니다.</div>';
		$('#workModal').append(content);
		
		
		$('#modal_close_btn').empty();
		$('#modal_close_btn').append('확인');
		
		$("#modal").fadeIn();
	}
</script>