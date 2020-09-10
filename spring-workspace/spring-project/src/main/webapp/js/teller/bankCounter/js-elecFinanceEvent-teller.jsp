<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

	let elecEntryID = '';
	let elecEntryPassword = '';
	let bInputIDPassword = false;
	let bcheckIdentityDoc = false;
	let chkElecAgree = false;
	
	let refAccountNo = '';
	
	$(document).on('click', "#changeElecFinanceUserPass", function() {
		
		$('#workModal').empty();
		let content = '';
		content += '손님에게 비밀번호 입력 화면을 출력하였습니다.';
		$('#workModal').append(content);
		$("#modal").fadeIn();
			
		socket.emit('work', 'elecFinancePwChange');
	})
	
	$(document).on('click', "#insertElecFinanceUser", function() {
		
		$('#workDiv').empty();
		
		let content = '';
		
		
		$('#workTitle').text('전자 금융 가입')
		//content += '<div id="workName">예금 목록</div>';
		content += '<div id="workSpace">';
		
		$.ajax({
			url : '${pageContext.request.contextPath}/account/'+'${clientVO.regNo}',
			type : 'get',
			async : false,
			success : function(data) {
				$('#workDiv').empty();
					
				let content = '';
				//content += '<div id="workName">사용자 계좌 조회</div>';
				$('#workTitle').text('전자 금융 가입');
					
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
					content +=                 '<th scope="col">이체 한도</th>';
					content +=                 '<th scope="col">생성일</th>';
					content +=                 '<th scope="col">가입하기</th>';
					content +=             '</tr>';
					content +=         '</thead>';
					content +=         '<tbody>';
						
					for(i = 0; i<data.length; i++) {
						//data[i].accountNo = makeHyphen(data[i].accountNo, 4);
						data[i].balance = comma(data[i].balance);
						data[i].withdrawableBalance = comma(data[i].withdrawableBalance);
						data[i].limitation = comma(data[i].limitation);
							
						content +=         '<tr>';
						content +=             '<td>' + data[i].accountNo + '</td>';
						content +=             '<td>' + data[i].nameCode + '</td>';
						content +=             '<td style="text-align:right">' + data[i].balance + '원</td>';
						content +=             '<td style="text-align:right">' + data[i].withdrawableBalance + '원</td>';
						content +=             '<td>' + data[i].dormant + '</td>';
						content +=             '<td>' + data[i].lost + '</td>';
						content +=             '<td>' + data[i].limitation + '원</td>';
						content +=             '<td>' + data[i].regDate + '</td>';
						content +=             '<td><button class="chooseElecAccount" id="' + data[i].accountNo + '">해당 계좌로 가입하기</button></td>';
						content +=         '</tr>';
					}
					content +=         '</tbody>';
					content +=     '</table>';
					content += '</div>';
				} else {
					content += '<div>손님의 입출금계좌가 존재하지 않습니다. 입출금계좌 가입을 먼저 진행해주십시오.</div>';
				}	
				$('#workDiv').append(content);
			},error : function() {
				alert('실패');
			}
		})
	})
	
	$(document).on('click', ".chooseElecAccount", function() {
		
		refAccountNo = $(this).attr("id");
		
		$('#workDiv').empty();
		
		let content = '';
		
		bInputIDPassword = false;
		bcheckIdentityDoc = false;
		
		$('#workTitle').text('전자 금융 가입')
		//content += '<div id="workName">예금 목록</div>';
		content += '<div id="workSpace" style="text-align : left">';
		content += '<div id="leftSpace" style="width:50%; display:inline; float:left;">';
		content += '<button id="getElecIDPassword">ID, 비밀번호 입력받기</button>'
		content += '<div id="elecInputCheck" style="color:red;">아이디, 비밀번호 입력이 완료되지 않았습니다.</div>'
		content += '<button id="getIdentityDocument">신분증 확인 체크</button>'
		content += '<div id="checkIdentityDocument" style="color:red;">신분증 확인이 완료되지 않았습니다.</div>'
		content += '<button id="getElecFinanceAgreement">동의서 작성하기</button>'
		content += '<div id="chkElecAgree" style="color:red;">동의서 작성이 완료되지 않았습니다.</div>'
		content += '</div>';
		content += '<div id="rightSpace" style="width:50%; display:inline; float:left;">';
		content += '<button id="elecFinanceInputComp">가입하기</button>';
		content += '</div>';
		
		$('#workDiv').append(content);
	})
	
	$(document).on('click', "#elecFinanceInputComp", function() {
		
		if(!bInputIDPassword) {
			
			$('#workModal').empty();
			let content = '';
			content += 'ID, 비밀번호 입력이 완료되지 않았습니다.';
			$('#workModal').append(content);
			$("#modal").fadeIn();
			return;
		}
		
		if(!bcheckIdentityDoc) {
			
			$('#workModal').empty();
			let content = '';
			content += '신분증 확인 절차가 이루어지지 않았습니다.';
			$('#workModal').append(content);
			$("#modal").fadeIn();
			return;
		}
		
		if(!chkElecAgree) {
			
			$('#workModal').empty();
			let content = '';
			content += '동의서 작성이 완료되지 않았습니다.';
			$('#workModal').append(content);
			$("#modal").fadeIn();
			return;
		}
		/*
		if(!telCheck) {
			
			$('#workModal').empty();
			let content = '';
			content += '휴대폰 인증이 완료되지 않았습니다.';
			$('#workModal').append(content);
			$("#modal").fadeIn();
			return;
		}
		*/
		$.ajax({
			url : '${pageContext.request.contextPath}/elecFinance/',
			type : 'post',
			data : {
				id : elecEntryID,
				password : elecEntryPassword,
				refAccountNo : refAccountNo,
				regNo : '${clientVO.regNo}',
				tel : '${clientVO.tel}',
			},
			success : function(data) {
				$('#workModal').empty();
				let content = '';
				content += '전자금융 가입이 완료되었습니다.';
				$('#workModal').append(content);
				$("#modal").fadeIn();
				
				<c:set target="${clientVO}" property="elecFinanceStatus" value="T" />
				
				$("elecFinanceStatus").text('전자금융 가입여부 : O');
				
				$("#work_selectMenu1007").trigger("click");
				
				socket('work', 'elecFinanceJoinSuccess');
				
			},error : function() {
				$('#workModal').empty();
				let content = '';
				content += '전자금융 가입에 실패했습니다.';
				$('#workModal').append(content);
				$("#modal").fadeIn();
			}
		})
	})
	
	$(document).on('click', "#getElecIDPassword", function() {
		
		socket.emit('work', 'getElecIDPassword');
		$('#workModal').empty();
		let content = '';
		content += '손님에게 아이디, 비밀번호 입력화면을 출력하였습니다.';
		$('#workModal').append(content);
		$("#modal").fadeIn();
	})
	
	$(document).on('click', "#getElecFinanceAgreement", function() {
		
		socket.emit('work', 'getElecFinanceAgreement');
		$('#workModal').empty();
		let content = '';
		content += '손님에게 동의서 작성화면을 출력하였습니다.';
		$('#workModal').append(content);
		$("#modal").fadeIn();
	})
	
	function elecFinanceAgreeComp(){
		
		$('#workModal').empty();
		let content = '';
		content += '손님이 동의항목 동의를 완료하였습니다.';
		
		$("#chkElecAgree").text("사용자 동의 완료");
		$("#chkElecAgree").css("color", "green");
		
		$('#workModal').append(content);
		$("#modal").fadeIn();
		
		chkElecAgree = true;
	}
	
	$(document).on('click', "#selectElecFinanceUserInfo", function() {
		
		$('#workDiv').empty();
		
		let content = '';
		
		$('#workTitle').text('전자 금융 가입 정보 조회')
		//content += '<div id="workName">예금 목록</div>';
		content += '<div id="workSpace">';
		
		$.ajax({
			url : '${pageContext.request.contextPath}/elecFinance/' + '${clientVO.regNo}',
			type : 'get',
			async : false,
			success : function(data) {
				
				if(data.length != 0) {
					
					content += '<div style="width:100%; height:200px; overflow:auto">';
					content +=     '<table class="table table-hover" style="text-align:center">';
					content +=         '<thead>';
					content +=             '<tr>';
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
	
	function elecFinanceSetIdPassword(id, password) {
		
		elecEntryID = id;
		elecEntryPassword = password;
		
		$("#elecInputCheck").text("아이디, 비밀번호 입력이 완료되었습니다.");
		$("#elecInputCheck").css("color", "green");
		bInputIDPassword = true;
	}
	
	$(document).on('click', "#getIdentityDocument", function() {
		
		$('#workModal').empty();
		let content = '';
		$("#checkIdentityDocument").text("신분증 확인이 완료되었습니다.");
		$("#checkIdentityDocument").css("color", "green");
		bcheckIdentityDoc = true;
	})
</script>