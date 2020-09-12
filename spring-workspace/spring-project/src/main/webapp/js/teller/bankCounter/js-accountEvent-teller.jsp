<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	
	var newAccountPassword = '';	
	var chkAccountAgree = false; 
	
	var productName = ''; 
	var reasonSelectValue = '';
	var propertySelectValue = '';
	var transactionPurposeSelectValue = '';
	var sourceOfFundSelectValue = '';
	
	$(document).on('click', "#refAccountList", function() {

		$('#workDiv').empty();
		let content = '';
		
		//content += '<div id="workName">예금 가입</div>';
		$('#workTitle').text('자유 입출금 예금(비대면) 상품 정보')
		content += '<div id="workSpace">';
		content += '<div id="linkBtn" style="text-align:left;" >';
		//content +=     '<button class="btn btn-info" id="showAllDepositLink">예금 전체 상품 목록 링크</button>';
		content += '</div>';
		$.ajax({
			url : '${pageContext.request.contextPath}/accountProcutList',
			type : 'get',
			success : function(data) {
				
				if(data.length != 0) {
					content += '<div style="width:100%; height:200px; overflow:auto">';
					content +=     '<table class="table table-hover" style="text-align:center">';
					content +=         '<thead>';
					content +=             '<tr>'
					content +=                 '<th scope="col">상품명</th>';
					content +=                 '<th scope="col">최고 이율</th>';
					content +=                 '<th scope="col">리플렛</th>';
					content +=             '</tr>';
					content +=         '</thead>';
					content +=         '<tbody>';
					
					for(i = 0; i < data.length; i++) {
						
						content +=         '<tr>';
						content +=             '<td>' + data[i].nameCode + '</td>';
						content +=             '<td>' + data[i].maxInterest + '%</td>';
						content +=             '<td><button class="depositLeaflet" id="' + data[i].leafletUrl + '">열기</button></td>';	
						content +=         '</tr>';
					}							
					content +=         '</tbody>';
					content +=     '</table>';
					content += '</div>';
					
					$('#workDiv').append(content);
					
				}
				else {
					content += '존재하는 자유입출금 예금상품이 없습니다.';
					$('#workDiv').append(content);
				}
				
			},error : function() {
				
				$('#workModal').empty();
				let content = '';
				content += '자유입출금예금상품 조회에 실패했습니다.';
				$('#workModal').append(content);
				$("#modal").fadeIn();
			}
		})
	})
	
	$(document).on('click', "#AccountSignUp", function() {
		
		$('#workDiv').empty();
		
		let content = '';
	
		$('#workTitle').text('자유 입출금 예금(비대면) 가입')
		content += '<div id="workSpace">';
	
		$.ajax({
			url : '${pageContext.request.contextPath}/accountProcutList',
			type : 'get',
			success : function(data) {
			
				if(data.length != 0) {
					
					content += '<div style="width:100%; height:200px; overflow:auto">';
					content +=     '<table class="table table-hover" style="text-align:center">';
					content +=         '<thead>';
					content +=             '<tr>'
					content +=                 '<th scope="col">상품명</th>';
					content +=                 '<th scope="col">최고 이율</th>';
					content +=                 '<th scope="col">가입 서비스</th>';
					content +=             '</tr>';
					content +=         '</thead>';
					content +=         '<tbody>';
					
					for(i = 0; i < data.length; i++) {
						
						content +=         '<tr>';
						content +=             '<td>' + data[i].nameCode + '</td>';
						content +=             '<td>' + data[i].maxInterest + '%</td>';
						content +=             '<td><button class="accountSignUpBtn" id="' + data[i].nameCode + '">가입하기</button></td>';	
						content +=         '</tr>';
					}							
					content +=         '</tbody>';
					content +=     '</table>';
					content += '</div>';
					
					$('#workDiv').append(content);
				
				}
				else {
					content += '존재하는 자유입출금 예금상품이 없습니다.';
					$('#workDiv').append(content);
				}
			
			},error : function() {
			
				$('#workModal').empty();
				let content = '';
				content += '자유입출금 예금상품 조회에 실패했습니다.';
				$('#workModal').append(content);
				$("#modal").fadeIn();
			}
		})
	})

	
	$(document).on('click', ".accountSignUpBtn", function() {
		
		$('#workTitle').text('자유 입출금 예금(비대면) 가입')
		$('#workDiv').empty();
		
		console.log($(this).attr("id"));
		
		let content = '';
		
		content += 	'<div id="workSpace" style="text-align : left">';
		content += 	'<div id="leftSpace" style="width:50%; display:inline; float:left;">';
		content += 		'<div class="accountProductName" id="' + $(this).attr('id') +'"style="font-size:x-large;">상품명 : ' + $(this).attr('id') + '</div>';
		
		content += 		'<div style="font-size:large">계좌 개설목적</div>';
		content += 		'<select name="reason" id="reason" style="text-align-last:center;width:90%;height:30px;font-size:22px;">'
		content += 			'<option class="reasonlist" value="일반 급여통장" selected>일반 급여통장</option>';
		content += 			'<option class="reasonlist" value="법인 통장" >법인 통장</option>';
		content += 			'<option class="reasonlist" value="아르바이트통장" >아르바이트통장</option>'
		content += 			'<option class="reasonlist" value="연금수급" >연금수급</option>'
		content += 			'<option class="reasonlist" value="모임통장" >모임통장</option>'
		content += 			'<option class="reasonlist" value="자동이체" >자동이체</option>'
		content += 			'<option class="reasonlist" value="기타" >기타</option>'
		content +=		'</select>';
		
		content += 		'<div style="font-size:large">재산 현황</div>';
		content += 		'<select name="property" id="property" style="text-align-last:center;width:90%;height:30px;font-size:22px;">'
		content += 			'<option class="propertylist" value="10억원 미만" selected>10억원 미만</option>';
		content += 			'<option class="propertylist" value="100억원 미만" >100억원 미만</option>';
		content += 			'<option class="propertylist" value="1000억원 미만" >1000억원 미만</option>'
		content += 			'<option class="propertylist" value="1000억원 이상" >1000억원 이상</option>'
		content +=		'</select>';
		
		content += 		'<div style="font-size:large">거래 목적</div>';
		content += 		'<select name="transactionPurpose" id="transactionPurpose" style="text-align-last:center;width:90%;height:30px;font-size:22px;">'
		content += 			'<option class="transactionPurposelist" value="급여 및 생활비" selected>급여 및 생활비</option>';
		content += 			'<option class="transactionPurposelist" value="저축 및 투자" >저축 및 투자</option>';
		content += 			'<option class="transactionPurposelist" value="보험료 납부 결제" >보험료 납부 결제</option>'
		content += 			'<option class="transactionPurposelist" value="공과금 납부 결제" >공과금 납부 결제</option>'
 		content += 			'<option class="transactionPurposelist" value="카드 대금 결제" >카드 대금 결제</option>'
 		content += 			'<option class="transactionPurposelist" value="대출원리 금상환결제" >대출원리 금상환결제</option>'
 		content += 			'<option class="transactionPurposelist" value="사업상 거래" >사업상 거래</option>'
 		content += 			'<option class="transactionPurposelist" value="기타" >기타</option>'
		content +=		'</select>';
		
		content += 		'<div style="font-size:large">거래 자금 원천</div>';
		content += 		'<select name="sourceOfFund" id="sourceOfFund" style="text-align-last:center;width:90%;height:30px;font-size:22px;">'
		content += 			'<option class="sourceOfFundlist" value="근로 및 연금소득" selected>근로 및 연금소득</option>';
		content += 			'<option class="sourceOfFundlist" value="퇴직소득" >퇴직소득</option>';
		content += 			'<option class="sourceOfFundlist" value="부동산임대소득" >부동산임대소득</option>'
		content += 			'<option class="sourceOfFundlist" value="부동산양도소득" >부동산양도소득</option>'
 		content += 			'<option class="sourceOfFundlist" value="금융소득" >금융소득</option>'
 		content += 			'<option class="sourceOfFundlist" value="상속/증여" >상속/증여</option>'
 		content += 			'<option class="sourceOfFundlist" value="차입/부채상환" >차입/부채상환</option>'
 		content += 			'<option class="sourceOfFundlist" value="기타" >기타</option>'
		content +=		'</select>';
			
		content += 	'</div>';
		content += 	'<div id="rightSpace" style="width:50%; display:inline; float:left;">';
		content += 		'<div id="inputPassword" style="text-align:right; padding-right:10%;">'
		content += 		'<br>';
		if(chkTelAuth) {
			content +=			'<div id="chkTelAuth" style="color:green">휴대폰 인증 완료</div>';
		} else {
			content +=			'<div id="chkTelAuth" style="color:red">휴대폰 인증 미완료</div>';
		}
		if(chkIdCard) {
			content +=			'<div id="chkIDCard" style="color:green">신분증 확인 및 촬영 완료</div>';
		} else {
			content +=			'<div id="chkIDCard" style="color:red">신분증 확인 및 촬영 미완료</div>';
		}
		
		content +=			'<div id="chkPass"></div>';
		content +=			'<button id="askNewAccountPassword" class="sbtn btn-info" style="width:150px; height:40px;">비밀번호 입력받기</button>';
		content +=			'<div id="chkNewPassword" style="color:red">비밀번호 입력 미완료</div>';
		content += 			'<div id="inputAgreement" style="text-align:right; padding-right:5%;">';
		content +=				'<div id="chkAccountAgree">사용자 동의 미완료</div>';
		content +=				'<button id="accountAgree" class="btn btn-info" style="width:150px; height:40px;">동의서 전송하기</button>';
		content += 			'</div>';
		content += 			'<div style="text-align:right; padding-right:5%; margin-top:10px;">';
		content +=				'<button id="accountInputComp" class="btn btn-info" style="width:150px; height:40px;">가입 진행하기</button>';
		content += 			'</div>';
		content += 		'</div>';
		content += 	'</div>';
		
		$('#workDiv').append(content);
	})
	
	$(document).on('click', "#accountInputComp", function() {
		
		if(newAccountPassword == '') {
			$('#workModal').empty();
			let content = '';
			content += '손님의 비밀번호 입력이 완료되지않았습니다.';
			$('#workModal').append(content);
			$("#modal").fadeIn();
			return;
		}
		if(!chkAccountAgree) {
			$('#workModal').empty();
			let content = '';
			content += '손님의 동의서 작성이 완료되지않았습니다.';
			$('#workModal').append(content);
			$("#modal").fadeIn();
			return;
		}

		if(!chkTelAuth) {
			$('#workModal').empty();
			let content = '';
			content += '휴대폰 본인인증이 완료되지않았습니다.';
			$('#workModal').append(content);
			$("#modal").fadeIn();
			return;
		} 

		if(!chkIdCard) {
			$('#workModal').empty();
			let content = '';
			content += '신분증 확인이 완료되지않았습니다.';
			$('#workModal').append(content);
			$("#modal").fadeIn();
			return;
		} 
		
		var accountSelect = document.getElementById("accountSelect");
		  
		// select element에서 선택된 option의 value가 저장된다.
		productName = $(".accountProductName").attr('id');
		reasonSelectValue = reason.options[reason.selectedIndex].value;
		propertySelectValue = property.options[property.selectedIndex].value;
		transactionPurposeSelectValue = transactionPurpose.options[transactionPurpose.selectedIndex].value;
		sourceOfFundSelectValue = sourceOfFund.options[sourceOfFund.selectedIndex].value;

		$('.modal-header').empty();
		let content = '';
		content += '<div style="text-align : left;">';
		content +=     '<table class="table table-hover" style="text-align:left">';
		content +=         '<tbody>';
		content +=         '<tr>';
		content +=             '<td>이름 : ' + '${clientVO.name}' + '</td>';
		content +=         '</tr>';
		content +=         '<tr>';
		content +=             '<td>상품명 : ' + productName + '</td>';
		content +=         '</tr>';
		content +=         '<tr>';
		content +=             '<td>계좌 개설 목적 : ' + reasonSelectValue + '</td>';
		content +=         '</tr>';
		content +=         '<tr>';
		content +=             '<td>재산 현황 : ' + propertySelectValue + '</td>';
		content +=         '</tr>';
		content +=         '<tr>';
		content +=             '<td>거래 목적 : ' + transactionPurposeSelectValue + '</td>';
		content +=         '</tr>';
		content +=         '<tr>';
		content +=             '<td>거래 자금 원천 : ' + sourceOfFundSelectValue + '</td>';
		content +=         '</tr>';
		content +=         '</tbody>';
		content +=     '</table>';
		content += 		'<div>가입 정보를 확인 후 손님에게 안내해주세요.</div>';
		content += '</div>';
		
		$('.modal-header').append(content);
		
		$("#mi-modal").modal('show');
		
		$("#modal-btn-si").unbind("click");
		$("#modal-btn-si").bind("click",function(){
			
			socket.emit('work', 'accountInputComp:' + '${clientVO.name}' + ':' + productName  + ':' + reasonSelectValue + ':' + propertySelectValue + ':' + transactionPurposeSelectValue + ':' + sourceOfFundSelectValue)
			
			$("#mi-modal").modal('hide');
		})
		
		$("#modal-btn-no").unbind("click");
		$("#modal-btn-no").bind("click",function(){
			$("#mi-modal").modal('hide');
		})
		
	})
	
	$(document).on('click', "#askNewAccountPassword", function() {
		
		socket.emit('work', 'askNewAccountPassword');
		
		$('#workModal').empty();
		let content = '';
		content += '손님에게 비밀번호 입력 화면을 출력하였습니다.';
		
		$('#workModal').append(content);
		$("#modal").fadeIn();
		
	})
	
	function setNewAccountPassword(pass) {
		
		$('#workModal').empty();
		let content = '';
		content += '<div>손님이 비밀번호 입력을 완료했습니다.</div>';
		newAccountPassword = pass;
		$('#workModal').append(content);
		$("#modal").fadeIn();
		
		$('#chkNewPassword').css("color", "green");
		$('#chkNewPassword').text("비밀번호 입력 완료");
	}
	
	$(document).on('click', "#accountAgree", function() {
		
		$('#workModal').empty();
		let content = '';
		content += '동의서 작성화면을 출력하였습니다.';
		$('#workModal').append(content);
		$("#modal").fadeIn();
		socket.emit('work', 'accountAgree');
	})
	
	
	function accountAgreeComp(){
		
		$('#workModal').empty();
		let content = '';
		content += '손님이 동의항목 동의를 완료하였습니다.';
		
		$("#chkAccountAgree").text("사용자 동의 완료");
		$("#chkAccountAgree").css("color", "green");
		
		$('#workModal').append(content);
		$("#modal").fadeIn();
		
		chkAccountAgree = true;
	}
	
	function accountSigninSuccess(){
		
		$('.modal-header').empty();
		let content = '';
		content += '<div>손님이 동의서 작성을 완료하였습니다. 가입을 진행하시겠습니까?</div>';
		
		$('.modal-header').append(content);
		
		$("#mi-modal").modal('show');
		
		$("#modal-btn-si").unbind("click");
		$("#modal-btn-si").bind("click",function(){
			
			$.ajax({
				url : '${pageContext.request.contextPath}/account',
				type : 'post',
				data : {		
					
					regNo : '${clientVO.regNo}',
					password : newAccountPassword,
					nameCode : productName,
					reason : reasonSelectValue,
					property : propertySelectValue,
					transactionPurpose : transactionPurposeSelectValue,
					sourceOfFund : sourceOfFundSelectValue
					
				},
				success : function(data) {
					
					newAccountPassword = '';
					chkAccountAgree = false;
					
					productName = ''; 
					reasonSelectValue = '';
					propertySelectValue = '';
					transactionPurposeSelectValue = '';
					sourceOfFundSelectValue = '';
					
					$('#workModal').empty();
					let content = '';
					content += '입출금 예금가입에 성공하였습니다.';
					$('#workModal').append(content);
					$("#modal").fadeIn();
					$('#workDiv').empty();
					$("#userAccountList").trigger("click");
					
					socket.emit('work', 'accountJoinSuccess');
				},error : function() {
					alert('실패');
				}
			})
			
			$("#mi-modal").modal('hide');
		})
		
		
		$("#modal-btn-no").unbind("click");
		$("#modal-btn-no").bind("click",function(){
			$("#mi-modal").modal('hide');
		})
		
		/*
		$("#modal-btn-no").on("click", function(){
			$("#mi-modal").modal('hide');
		});
		*/
		
	}
</script>