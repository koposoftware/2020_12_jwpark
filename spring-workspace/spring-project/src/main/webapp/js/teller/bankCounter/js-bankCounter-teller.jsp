<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>

	// work /////
	var passChangeAccount

	var chkPassword = false;
	var chkDepositAgree = false;
	
	$("#menu-toggle").click(function(e) {
  		e.preventDefault();
  		$("#wrapper").toggleClass("toggled");
  	});
	
	
	$("#work_selectAccount1000").bind('click', function(event) {
		
		$.ajax({
			url : '${pageContext.request.contextPath}/account/'+'${clientVO.regNo}',
			type : 'get',
			success : function(data) {
				$('#workDiv').empty();
					
				let content = '';
				content += '<div id="workName">사용자 계좌 조회</div>';
					
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
	
	$("#work_selectAccount1003").bind('click', function(event) {
		
		$('#workDiv').empty();
		let content = '';
		
		content += '<div id="workName">예금 가입</div>';
		content += '<div id="workSpace">';
		content +=     '<button class="btn btn-info" id="refDepositList">예금 상품 정보</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		content +=     '<button class="btn btn-info" id="depositSignUp">예금 가입</button>';
		content += '</div>';
		
		$('#workDiv').append(content)
		
	})
	
	$("#work_selectAccount1006").bind('click', function(event) {
		
		$('#workDiv').empty();
		let content = '';
		
		content += '<div id="workName">계좌 제신고</div>';
		content += '<div id="workSpace">';
		content +=     '<button class="btn btn-info" id="changePasswordBtn">계좌 비밀번호 변경</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		content +=     '<button class="btn btn-info" id="LostReport">분실 신고/해제</button>';
		content += '</div>';
		
		
		$('#workDiv').append(content)
		
	})
	
	$(document).on('click', "#changePasswordBtn", function(event) {
		
		$('#workModal').empty();
		$.ajax({
			url : '${pageContext.request.contextPath}/account/'+'${clientVO.regNo}',
			type : 'get',
			success : function(data) {
				$('#workDiv').empty();
				
				let content = '';
				content += '<div id="workName">계좌 비밀번호 변경</div>';
				
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
				content += '<div id="workName">분실 신고/해제</div>';
				
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
		
	$(document).on('click', ".chooseChangePassAccount", function() {
		
		$('#workModal').empty();
		let content = '';
		content += '손님에게 비밀번호 입력 화면을 출력하였습니다.';
		$('#workModal').append(content);
		$("#modal").fadeIn();
			
		passChangeAccount = $(this).attr('id');
			
		socket.emit('work', 'accountPwChange');
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
						content += '<div id="workName">계좌 비밀번호 변경</div>';
						
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
						content += '<div id="workName">계좌 비밀번호 변경</div>';
						
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
		
		
	$(document).on('click', "#refDepositList", function() {

		$('#workDiv').empty();
		
		let content = '';
		
		content += '<div id="workName">예금 가입</div>';
		content += '<div id="workSpace">';
		content +=     '<button class="btn btn-info" id="showAllDepositLink">예금 전체 상품 목록 링크</button>';
		
		$.ajax({
			url : '${pageContext.request.contextPath}/depositProducts',
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
						if(data[i].minAmmount != 0){
							content +=             '<td>' + comma(data[i].minAmmount * 10000) + '원</td>';
						} else {
							content +=             '<td>제한 없음</td>';
						}
						if(data[i].maxAmmount != 0){
							content +=             '<td>' + comma(data[i].maxAmmount * 10000) + '원</td>';
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
	
	$(document).on('click', "#depositSignUp", function() {

		$('#workDiv').empty();
		
		let content = '';
		
		content += '<div id="workName">예금 가입</div>';
		content += '<div id="workSpace">';
		
		$.ajax({
			url : '${pageContext.request.contextPath}/depositProducts',
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
						if(data[i].minAmmount != 0){
							content +=             '<td>' + comma(data[i].minAmmount * 10000) + '원</td>';
						} else {
							content +=             '<td>제한 없음</td>';
						}
						if(data[i].maxAmmount != 0){
							content +=             '<td>' + comma(data[i].maxAmmount * 10000) + '원</td>';
						} else {
							content +=             '<td>제한 없음</td>';
						}
						content +=             '<td><button class="depositSignUpBtn" id="' + data[i].nameCode + '">가입하기</button></td>';	
						content +=         '</tr>';
					}							
					content +=         '</tbody>';
					content +=     '</table>';
					content += '</div>';
					
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
		
		
	$(document).on('click', "#showAllDepositLink", function() {

		var openNewWindow = window.open("about:blank");
		openNewWindow.location.href = "https://www.kebhana.com/cont/mall/mall08/mall0805/index.jsp";
	})
	
	$(document).on('click', ".depositLeaflet", function() {

		let url = $(this).attr('id');
		var openNewWindow = window.open("about:blank");
		openNewWindow.location.href = url;
	})

	$(document).on('click', ".depositSignUpBtn", function() {
		
		$('#workDiv').empty();
		
		let content = '';
		
		content += '<div id="workName">예금 가입</div>';
		content += '<div id="workSpace">';
		content += '<div style="font-size:x-large;">상품명 : ' + $(this).attr('id') + '</div>';
		
		let result = false;
		
		let deposit;
		chkPassword = false;
		chkDepositAgree = false;
		$.ajax({
			url : '${pageContext.request.contextPath}/depositProductOne/' + $(this).attr('id'),
			type : 'get',
			success : function(data) {
				
				if(data.length != 0) {
					let deposit = data;
					
					//////////////////////////////////////////
					$.ajax({
						url : '${pageContext.request.contextPath}/account/'+'${clientVO.regNo}',
						type : 'get',
						success : function(data) {
							
							if(data.length != 0) {
								
								content += '<select name="account" id="accountSelect" style="text-align-last:center;width:500px;height:50px;font-size:22px;">'
								for(let i = 0; i < data.length; i++) {
									if(i == 0) {
										content += '<option class="accountlist" value=' + data[i].accountNo + ' selected>' + makeHyphen(data[i].accountNo, 4) +', ' +  comma(data[i].withdrawableBalance) +'원</option>'
									} else {
										content += '<option class="accountlist" value=' + data[i].accountNo + '>' + makeHyphen(data[i].accountNo, 4) +', ' +  comma(data[i].withdrawableBalance) +'원</option>'
									}
								}
								content +=	'</select>';
								content +=		'<div id="depositSignUpSpace">'
								content +=			'<div id="chkPass"></div>';
								content +=			'<button id="askPassword">비밀번호 입력받기</button>';
								content +=			'<div>신규 금액 <input type="text" autocomplete="off" id="depositAmmount">';
								
								if(deposit.minAmmount != 0)
									content += 			'최소 ' + comma(deposit.minAmmount * 10000) + '원 ';
								else
									content += 			'최소 ' + comma(10000) + '원';
								if(deposit.maxAmmount != 0)
									content += 			'최대 ' + comma(deposit.maxAmmount * 10000) + '원 ';
								else
									content += 			'최대 제한 없음';
								content +=			'</div>';
								content +=			'<div>가입 기간 <input type="text" autocomplete="off" id="depositPeriod">'
								if(deposit.minPeriod != 0)
									content += 			'최소 ' + deposit.minPeriod + '개월'
								else
									content += 			'최소 1개월'
								if(deposit.maxPeriod != 0)
									content += ' 최대 ' + deposit.maxPeriod +'개월'
								else
									content += ' 최대 제한없음'
								
								content += 		'</div>';
								content += '</div>';
								
								content +=	'<button id="depositAgree">동의서 전송하기</button>';
								content +=	'<div id="chkDepositAgree"></div>';
								
							}
							else {
								content += '존재하는 사용자 계좌가 없습니다.';
								$('#workDiv').append(content);
							}
							
							$('#workDiv').append(content);
							
							$("#chkPass").text("비밀번호 인증 미완료");
							$("#chkPass").css("color", "red");		
							
							$("#chkDepositAgree").text("사용자 동의서 작성 미완료");
							$("#chkDepositAgree").css("color", "red");		
						},error : function() {
								
							$('#workModal').empty();
							let content = '';
							content += '예금상품 조회에 실패했습니다.';
							$('#workModal').append(content);
								$("#modal").fadeIn();
						}
					})
					//////////////////////////////////////////
					
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
	
	$(document).on('click', "#askPassword", function() {
		
		var accountSelect = document.getElementById("accountSelect");
		  
		// select element에서 선택된 option의 value가 저장된다.
		var selectValue = accountSelect.options[accountSelect.selectedIndex].value;
		
		socket.emit('work', 'askPassword:'+selectValue);
	})
	
	$(document).on('click', "#depositAgree", function() {
		
		socket.emit('work', 'depositAgree');
	})
	
	
	document.getElementById("modal_close_btn").onclick = function() {
	
		$("#modal").fadeOut();
	}

	window.onbeforeunload = function() {
		sendMessage('bye');
	};

	function makeHyphen(accountNo, code){
	
		let str="";
		for( let i = 0; i < accountNo.length; i++) {
			str += accountNo[i];
			if(i == 2 || i == 8 )
				str += '-';
		}
		return str;
	}

	function comma(num){
	
		var len, point, str;
		num = num + "";
		point = num.length % 3;
		len = num.length;
		str = num.substring(0, point);
		while (point < len){
			if (str != "") str += ",";
			str += num.substring(point, point + 3);
			point += 3;
		}
		return str;
	}

	function encoding(text) {
		output = new String;
		temp = new Array();
		temp2 = new Array();
		textSize = text.length;
		for(i = 0; i< textSize; i++) {
			rnd = Math.round(Math.random() * 122) + 68;
			temp[i] = text.charCodeAt(i) + rnd;
			temp2[i] = rnd;
		}
		for(i = 0; i < textSize; i++) {
			output += String.fromCharCode(temp[i], temp2[i]);
		}
		return output;
	}
	
	function decoding(text) {
		output = new String;
		temp = new Array();
		temp2 = new Array();
		textSize = text.length;
		
		for(i = 0; i< textSize; i++) {
			temp[i] = text.charCodeAt(i);
			temp2[i] = text.charCodeAt(i+1);
		}
		for(i = 0; i < textSize; i = i+2) {
			output += String.fromCharCode(temp[i] - temp2[i]);
		}
		return output;
	}

</script>