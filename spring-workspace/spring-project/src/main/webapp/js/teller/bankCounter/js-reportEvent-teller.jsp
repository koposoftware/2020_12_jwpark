<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

	$(document).on('click', ".chooseChangePassAccount", function() {
		
		$('#workModal').empty();
		let content = '';
		content += '손님에게 비밀번호 입력 화면을 출력하였습니다.';
		$('#workModal').append(content);
		$("#modal").fadeIn();
			
		passChangeAccount = $(this).attr('id');
			
		socket.emit('work', 'accountPwChange');
	})
	
	$(document).on('click', "#changePasswordBtn", function(event) {
		
		$('#workModal').empty();
		$.ajax({
			url : '${pageContext.request.contextPath}/account/'+'${clientVO.regNo}',
			type : 'get',
			success : function(data) {
				$('#workDiv').empty();
				
				let content = '';
				//content += '<div id="workName">계좌 비밀번호 변경</div>';
				$('#workTitle').text('계좌 비밀번호 변경')
				
				if(data.length != 0) {
					content += '<div style="width:100%; height:200px; overflow:auto">';
					content +=     '<table class="table table-hover" style="text-align:center">';
					content +=         '<thead>';
					content +=             '<tr>'
					content +=                 '<th scope="col">계좌번호</th>';
					content +=                 '<th scope="col">상품명</th>';
					content +=                 '<th scope="col">잔액</th>';
					content +=                 '<th scope="col">출금가능액</th>';
					content +=                 '<th scope="col" style="width:8%">휴면 상태</th>';
					content +=                 '<th scope="col" style="width:10%">분실 신고 상태</th>';
					content +=                 '<th scope="col">생성일</th>';
					content +=                 '<th scope="col">선택</th>';
					content +=             '</tr>';
					content +=         '</thead>';
					content +=         '<tbody>';
					
					for(i = 0; i<data.length; i++) {
						data[i].accountNo = makeHyphen(data[i].accountNo, 4);
						data[i].balance = comma(data[i].balance);
						data[i].withdrawableBalance = comma(data[i].withdrawableBalance);
						
						content +=         '<tr>';
						content +=             '<td>' + data[i].accountNo + '</td>';
						content +=             '<td>' + data[i].nameCode + '</td>';
						content +=             '<td style="text-align:right">' + data[i].balance + '원</td>';
						content +=             '<td style="text-align:right">' + data[i].withdrawableBalance + '원</td>';
						content +=             '<td>' + data[i].dormant + '</td>';
						content +=             '<td>' + data[i].lost + '</td>';
						content +=             '<td>' + data[i].regDate + '</td>';
						content +=             '<td><button class="chooseChangePassAccount" id="' + data[i].accountNo + '">비밀번호 변경</button></td>';
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
	
	$(document).on('click', "#LostReport", function(event) {
		
		$('#workModal').empty();
		$.ajax({
			url : '${pageContext.request.contextPath}/account/'+'${clientVO.regNo}',
			type : 'get',
			success : function(data) {
				$('#workDiv').empty();
				
				let content = '';
				//content += '<div id="workName">분실 신고/해제</div>';
				$('#workTitle').text('분실 신고/해제')
				
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
					content +=                 '<th scope="col">선택</th>';
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
						if(data[i].lost == 'T') {
							content +=             '<td><button class="chooseCancleLostReport" id="' + data[i].accountNo + '">분실 해제</button></td>';	
						} else {
							content +=             '<td><button class="chooseLostReport" id="' + data[i].accountNo + '">분실 신고</button></td>';
						}
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
	
	
	$(document).on('click', ".chooseLostReport", function() {
		
		let lostAccount = $(this).attr('id');
		
		$.ajax({
			url : '${pageContext.request.contextPath}/account/lostReport/' + lostAccount,
			type : 'get',
			success : function(data) {
				
				$('#workModal').empty();
				$.ajax({
					url : '${pageContext.request.contextPath}/account/'+'${clientVO.regNo}',
					type : 'get',
					success : function(data) {
						$('#workDiv').empty();
						
						let content = '';
						//content += '<div id="workName">계좌 비밀번호 변경</div>';
						$('#workTitle').text('계좌 비밀번호 변경')
						
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
							content +=                 '<th scope="col">선택</th>';
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
								if(data[i].lost == 'T') {
									content +=             '<td><button class="chooseCancleLostReport" id="' + data[i].accountNo + '">분실 해제</button></td>';	
								} else {
									content +=             '<td><button class="chooseLostReport" id="' + data[i].accountNo + '">분실 신고</button></td>';
								}
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
				
				$('#workModal').empty();
				let content = '';
				content += '분실신고를 완료하였습니다.';
				$('#workModal').append(content);
				$("#modal").fadeIn();
				socket.emit('work', 'lostReport');
				
			}, error : function() {
				
				$('#workModal').empty();
				let content = '';
				content += '분실신고에 실패했습니다.';
				$('#workModal').append(content);
				$("#modal").fadeIn();
			}
			
		})
	})

	$(document).on('click', ".chooseCancleLostReport", function() {
	
		let lostAccount = $(this).attr('id');
	
		$.ajax({
			url : '${pageContext.request.contextPath}/account/cancleLostReport/' + lostAccount,
			type : 'get',
			success : function(data) {
			
				$('#workModal').empty();
			
				$.ajax({
					url : '${pageContext.request.contextPath}/account/'+'${clientVO.regNo}',
					type : 'get',
					success : function(data) {
						$('#workDiv').empty();
					
						let content = '';
						//content += '<div id="workName">계좌 비밀번호 변경</div>';
						$('#workTitle').text('계좌 비밀번호 변경')
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
							content +=                 '<th scope="col">선택</th>';
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
								if(data[i].lost == 'T') {
									content +=             '<td><button class="chooseCancelLostReport" id="' + data[i].accountNo + '">분실 해제</button></td>';	
								} else {
									content +=             '<td><button class="chooseLostReport" id="' + data[i].accountNo + '">분실 신고</button></td>';
								}
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
				
				$('#workModal').empty();
				let content = '';
				content += '분실신고 해제를 성공하였습니다.';
				$('#workModal').append(content);
				$("#modal").fadeIn();
				socket.emit('work', 'cancleLostReport');
				
			},error : function() {
				
				$('#workModal').empty();
				let content = '';
				content += '분실신고 해제에 실패했습니다.';
				$('#workModal').append(content);
				$("#modal").fadeIn();
			}
			
		})
	})

</script>