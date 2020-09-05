<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	$('#reportArea').empty();
	$("input:radio[name='chk_info']:radio[value='예금']").prop('checked', true); // 선택하기
	
	function checkInput() {
		console.log($('#reportTitle').val());
		console.log($('#reportArea').val());
		if($('#reportTitle').val() == '')
			return false;
		if($('#reportArea').val() == '')
			return false;
	}
	
</script>
