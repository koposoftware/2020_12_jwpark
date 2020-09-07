<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	$(document).on('click', "#changeElecFinanceUserPass", function() {
		
		$('#workModal').empty();
		let content = '';
		content += '손님에게 비밀번호 입력 화면을 출력하였습니다.';
		$('#workModal').append(content);
		$("#modal").fadeIn();
			
		socket.emit('work', 'elecFinancePwChange');
	})
	
	$(document).on('click', "#insertElecFinanceUser", function() {
		
		
	})
	
	$(document).on('click', "#selectElecFinanceUserInfo", function() {
		
		$('#workDiv').empty();
		
		let content = '';
		
		$('#workTitle').text('전자 금융 가입 정보 조회')
		//content += '<div id="workName">예금 목록</div>';
		content += '<div id="workSpace">';
		
		$.ajax({
			url : '${pageContext.request.contextPath}/elecFinance/' + '${clientVO.regNo}',
			type : 'get',
			success : function(data) {
				
				if(data.length != 0) {
					content += '<div style="width:100%; height:200px; overflow:auto">';
					content +=     '<table class="table table-hover" style="text-align:center">';
					content +=         '<thead>';
					content +=             '<tr>'
					content +=                 '<th scope="col">아이디</th>';
					content +=                 '<th scope="col">휴대폰 번호</th>';
					content +=                 '<th scope="col">연결된 입출금 계좌 번호</th>';
					content +=                 '<th scope="col">가입일</th>';
					content +=                 '<th scope="col">비밀번호 변경</th>';
					content +=             '</tr>';
					content +=         '</thead>';
					content +=         '<tbody>';
					content +=         '<tr>';
					content +=             '<td>' + data.id + '</td>';
					content +=             '<td>' + hyphenPhone(data.tel) + '</td>';
					content +=             '<td>' + makeHyphen(data.refAccountNo, 4) + '</td>';
					content +=             '<td>' + data.regDate + '</td>';
					content +=             '<td><button id="changeElecFinanceUserPass">비밀번호 변경</button></td>';
					content +=         '</tr>';
					content +=         '</tbody>';
					content +=     '</table>';
					content += '</div>';
					
					$('#workDiv').append(content);
					
				}
				else {
					content += '손님은 전자금융에 가입되지 않았습니다.';
					$('#workDiv').append(content);
				}
				
			},error : function() {
				
				$('#workModal').empty();
				let content = '';
				content += '전자금융 가입 정보 조회에 실패했습니다.';
				$('#workModal').append(content);
				$("#modal").fadeIn();
			}
		})
	})
	
</script>