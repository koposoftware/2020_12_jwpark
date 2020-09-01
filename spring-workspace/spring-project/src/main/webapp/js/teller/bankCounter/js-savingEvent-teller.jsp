<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

	$(document).on('click', "#refSavingList", function() {
	
		$('#workDiv').empty();
		
		let content = '';
		
		//content += '<div id="workName">예금 가입</div>';
		$('#workTitle').text('적금 상품 정보')
		content += '<div id="workSpace">';
		content += '<div id="linkBtn" style="text-align:left;" >';
		content +=     '<button class="btn btn-info" id="showAllSavingLink">적금 전체 상품 목록 링크</button>';
		content += '</div>';
		$.ajax({
			url : '${pageContext.request.contextPath}/savingProducts',
			type : 'get',
			success : function(data) {
				
				if(data.length != 0) {
					content += '<div style="width:100%; height:200px; overflow:auto">';
					content +=     '<table class="table table-hover" style="text-align:center">';
					content +=         '<thead>';
					content +=             '<tr>'
					content +=                 '<th scope="col">상품명</th>';
					content +=                 '<th scope="col">최고 이율</th>';
					content +=                 '<th scope="col">최저 가입 기간</th>';
					content +=                 '<th scope="col">최대 가입 기간</th>';
					content +=                 '<th scope="col">최저 가입 금액</th>';
					content +=                 '<th scope="col">최대 가입 금액</th>';
					content +=                 '<th scope="col">최저  적금액(월)</th>';
					content +=                 '<th scope="col">최대 적금액(월)</th>';
					content +=                 '<th scope="col">리플렛</th>';
					content +=             '</tr>';
					content +=         '</thead>';
					content +=         '<tbody>';
					
					for(i = 0; i < data.length; i++) {
						
						content +=         '<tr>';
						content +=             '<td>' + data[i].nameCode + '</td>';
						content +=             '<td>' + data[i].maxInterest + '%</td>';
						
						if(data[i].minPeriod != 0){
							content +=             '<td>' + data[i].minPeriod + '개월</td>';
						} else {
							content +=             '<td>제한 없음</td>';
						}
						if(data[i].maxPeriod != 0){
							content +=             '<td>' + data[i].maxPeriod + '개월</td>';
						} else {
							content +=             '<td>제한 없음</td>';
						}	
						if(data[i].minEntryAmmount != 0){
							content +=             '<td>' + comma(data[i].minEntryAmmount * 1000) + '원</td>';
						} else {
							content +=             '<td>제한 없음</td>';
						}
						if(data[i].maxEntryAmmount != 0){
							content +=             '<td>' + comma(data[i].maxEntryAmmount * 1000) + '원</td>';
						} else {
							content +=             '<td>제한 없음</td>';
						}
						if(data[i].minSavingAmmount != 0){
							content +=             '<td>' + comma(data[i].minSavingAmmount * 1000) + '원</td>';
						} else {
							content +=             '<td>제한 없음</td>';
						}
						if(data[i].maxSavingAmmount != 0){
							content +=             '<td>' + comma(data[i].maxSavingAmmount * 1000) + '원</td>';
						} else {
							content +=             '<td>제한 없음</td>';
						}
						content +=             '<td><button class="depositLeaflet" id="' + data[i].leafletUrl + '">열기</button></td>';	
						content +=         '</tr>';
					}							
					content +=         '</tbody>';
					content +=     '</table>';
					content += '</div>';
					console.log(content);
					$('#workDiv').append(content);
					
				}
				else {
					content += '존재하는 예금상품이 없습니다.';
					$('#workDiv').append(content);
				}
				
			},error : function() {
				
				$('#workModal').empty();
				let content = '';
				content += '예금상품 조회에 실패했습니다.';
				$('#workModal').append(content);
				$("#modal").fadeIn();
			}
		})
	})
	
	$(document).on('click', "#showAllSavingLink", function() {

		var openNewWindow = window.open("about:blank");
		openNewWindow.location.href = "https://www.kebhana.com/cont/mall/mall08/mall0805/index.jsp";
	})
	
	$(document).on('click', ".savingLeaflet", function() {

		let url = $(this).attr('id');
		var openNewWindow = window.open("about:blank");
		openNewWindow.location.href = url;
	})
</script>