<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

	function captureId() {
		
		$('#workModal').empty();
		let content = '';
		content += '신분증을 캡쳐하였습니다.';
		
		$('#modal_close_btn').empty();
		$('#modal_close_btn').append('확인');
		
		$('#workModal').append(content);
		$("#modal").fadeIn();
	}
	
</script>