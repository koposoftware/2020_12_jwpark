<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	$(document).on('click', "#userAccountList", function() {
		
		$('#workDiv').empty();
		$.ajax({
			url : '${pageContext.request.contextPath}/account/'+'${clientVO.regNo}',
			type : 'get',
			success : function(data) {
				$('#workDiv').empty();
					
				let content = '';
				//content += '<div id="workName">사용자 계좌 조회</div>';
				$('#workTitle').text('자유 입출금 계좌 조회');
					
				if(data.length != 0) {
					content += '<div style="width:100%; height:200px; overflow:auto">';
					content +=     '<table class="table table-hover" style="text-align:center">';
					content +=         '<thead>';
					content +=             '<tr>'
					content +=                 '<th scope="col">종류</th>';
					content +=                 '<th scope="col">계좌번호</th>';
					content +=                 '<th scope="col">상품명</th>';
					content +=                 '<th scope="col">잔액</th>';
					content +=                 '<th scope="col">출금가능액</th>';
					content +=                 '<th scope="col" style="width:8%">휴면 상태</th>';
					content +=                 '<th scope="col" style="width:10%">분실 신고 상태</th>';
					content +=                 '<th scope="col">생성일</th>';
					content +=                 '<th scope="col">최종 거래일</th>';
					content +=             '</tr>';
					content +=         '</thead>';
					content +=         '<tbody>';
						
					for(i = 0; i<data.length; i++) {
						data[i].accountNo = makeHyphen(data[i].accountNo, 4);
						data[i].balance = comma(data[i].balance);
						data[i].withdrawableBalance = comma(data[i].withdrawableBalance);
							
						content +=         '<tr>';
						content +=             '<td>' + data[i].type + '</td>';
						content +=             '<td>' + data[i].accountNo + '</td>';
						content +=             '<td>' + data[i].productName + '</td>';
						content +=             '<td style="text-align:right">' + data[i].balance + '원</td>';
						content +=             '<td style="text-align:right">' + data[i].withdrawableBalance + '원</td>';
						content +=             '<td>' + data[i].dormant + '</td>';
						content +=             '<td>' + data[i].lost + '</td>';
						content +=             '<td>' + data[i].regDate + '</td>';
						content +=             '<td>' + data[i].recentlyUseDate + '</td>';
						content +=         '</tr>';
					}
						
					content +=         '</tbody>';
					content +=     '</table>';
					content += '</div>';
				} else {
					content += '<div>손님의 계좌가 존재하지 않습니다.</div>';
				}	
				$('#workDiv').append(content);
			},error : function() {
				alert('실패');
			}
				
		})
	})
</script>