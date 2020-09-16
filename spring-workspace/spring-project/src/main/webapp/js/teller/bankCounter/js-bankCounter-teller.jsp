<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>

	// work /////
	var passChangeAccount
	var chkTelAuth = false;
	var chkIdCard = false;
	
	$("#menu-toggle").click(function(e) {
  		e.preventDefault();
  		$("#wrapper").toggleClass("toggled");
  	});
	
	/*
	$("#reverseClientScreen").bind('click', function(event) {
		
		$('#workModal').empty();
		let content = '';
		content += '손님의 바탕색을 반전하였습니다.'
		//content += '<a href="" download="${clientVO.name}_${clientVO.id}.png">저장</a>'
		$('#workModal').append(content);
		$("#modal").fadeIn();
		
		socket.emit('work', 'reverseScreen');
	})
	*/
	
	$("#work_selectMenu1000").bind('click', function(event) {
		
		$('#workBtns').empty();
		$('#workTitle').text('자유 입출금 예금가입 현황')
		let content ='';
		content +=     '<button class="btn btn-info" id="userAccountList">자유 입출금 계좌 조회</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		content +=     '<button class="btn btn-info" id="userDepositList">예금 조회</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		content +=     '<button class="btn btn-info" id="userSavingList">적금 조회</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		
		$('#workBtns').empty();
		$('#workBtns').append(content)
		
		$("#userAccountList").trigger("click");
	})
	
	$("#work_selectMenu1001").bind('click', function(event) {
		
		$('#workBtns').empty();
		$('#workTitle').text('자유 입출금 예금가입 현황')
		let content ='';
		content +=     '<button class="btn btn-info" id="userAccountList">자유 입출금 가입 현황</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		content +=     '<button class="btn btn-info" id="refAccountList">자유 입출금 상품 조회</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		content +=     '<button class="btn btn-info" id="AccountSignUp">자유 입츨금 예금 가입</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		
		$('#workBtns').empty();
		$('#workBtns').append(content)
		
		$("#userAccountList").trigger("click");
	})
	
	$("#work_selectMenu1003").bind('click', function(event) {
		
		$('#workDiv').empty();
		let content = '';
		
		//content += '<div id="workName">예금 가입</div>';
		$('#workTitle').text('예금 업무')
		
		content +=     '<button class="btn btn-info" id="userDepositList">예금 가입 현황</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		content +=     '<button class="btn btn-info" id="refDepositList">예금 상품 정보</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		content +=     '<button class="btn btn-info" id="depositSignUp">예금 가입</button>';
		
		$('#workBtns').empty();
		$('#workBtns').append(content)
		$('#workDiv').empty();
		
		$("#userDepositList").trigger("click");
	})
	
	$("#work_selectMenu1004").bind('click', function(event) {
		
		$('#workDiv').empty();
		let content = '';
		
		//content += '<div id="workName">예금 가입</div>';
		$('#workTitle').text('적금 업무')
		
		content +=     '<button class="btn btn-info" id="userSavingList">적금 가입 현황</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		content +=     '<button class="btn btn-info" id="refSavingList">적금 상품 정보</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		content +=     '<button class="btn btn-info" id="savingSignUp">적금 가입</button>';
		
		$('#workBtns').empty();
		$('#workBtns').append(content)
		$('#workDiv').empty();
		
		$("#userSavingList").trigger("click");
	})
	
	$("#work_selectMenu1006").bind('click', function(event) {
		
		$('#workDiv').empty();
		let content = '';
		
		//content += '<div id="workName">예금 가입</div>';
		
		$('#workTitle').text('계좌 제신고')
		content +=     '<button class="btn btn-info" id="changePasswordBtn">계좌 비밀번호 변경</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		content +=     '<button class="btn btn-info" id="LostReport">분실 신고/해제</button>';
		
		$('#workBtns').empty();
		$('#workBtns').append(content)
		$('#workDiv').empty();
		
		$("#changePasswordBtn").trigger("click");
	})
	
	$("#work_selectMenu1007").bind('click', function(event) {
		
		
		////////////////////////////////////		
		
		console.log('dd');
		$('#workBtns').empty();
//		$('#workDiv').empty();
		let content = '';
		
		//content += '<div id="workName">예금 가입</div>';
		
		$('#workTitle').text('전자 금융 가입')
		if('${clientVO.elecFinanceStatus}' == 'T') {
			content +=     '<button class="btn btn-info" id="selectElecFinanceUserInfo">전자금융 가입 정보</button>&nbsp;&nbsp;&nbsp;&nbsp;';
			//content +=     '<button class="btn btn-info" id="changeElecFinanceUserPass">전자금융 비밀번호 변경</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		} else {
			content +=     '<button class="btn btn-info" id="insertElecFinanceUser">전자금융 가입</button>';
			$("#insertElecFinanceUser").trigger("click");
		}
		
		
//		$('#workDiv').empty();
		$('#workBtns').append(content)
		
		if('${clientVO.elecFinanceStatus}' == 'T') {
			//content +=     '<button class="btn btn-info" id="selectElecFinanceUserInfo">전자금융 가입 정보</button>&nbsp;&nbsp;&nbsp;&nbsp;';
			$("#selectElecFinanceUserInfo").trigger("click");
		} else {
			//content +=     '<button class="btn btn-info" id="insertElecFinanceUser">전자금융 가입</button>';
			$("#insertElecFinanceUser").trigger("click");
		}
		
	})
	
	$("#work_selectMenu1008").bind('click', function(event) {
		
		$('#workTitle').text('체크 카드 상담')
		let content = '';
		content +=     '<button class="btn btn-info" id="checkCardBtn">체크카드 안내</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		
		$('#workBtns').empty();
		$('#workBtns').append(content)
		$('#workDiv').empty();
		
		$("#checkCardBtn").trigger("click");
	})
	
	$("#work_selectMenu1009").bind('click', function(event) {
		
		$('#workTitle').text('신용 카드 상담')
		let content = '';
		content +=     '<button class="btn btn-info" id="creditCardBtn">신용카드 안내</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		
		$('#workBtns').empty();
		$('#workBtns').append(content)
		$('#workDiv').empty();
		
		$("#creditCardBtn").trigger("click");
	})
	
	$("#work_selectMenu1010").bind('click', function(event) {
		
		$('#workTitle').text('대출 상담')
		let content = '';
		content +=     '<button class="btn btn-info" id="loanBtn">대출 안내</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		
		$('#workBtns').empty();
		$('#workBtns').append(content)
		$('#workDiv').empty();
		
		$("#loanBtn").trigger("click");
	})
	
	$("#work_selectMenu1011").bind('click', function(event) {
		
		$('#workTitle').text('펀드 상담')
		let content = '';
		content +=     '<button class="btn btn-info" id="fundBtn">펀드 안내</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		
		$('#workBtns').empty();
		$('#workBtns').append(content)
		$('#workDiv').empty();
		
		$("#fundBtn").trigger("click");
	})
	
	$("#work_selectMenu1012").bind('click', function(event) {
		
		$('#workTitle').text('방카슈랑스 상담')
		let content = '';
		content +=     '<button class="btn btn-info" id="insuranceBtn">방카슈랑스 안내</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		
		$('#workBtns').empty();
		$('#workBtns').append(content)
		$('#workDiv').empty();
		
		$("#insuranceBtn").trigger("click");
	})
	
	
	$("#searchWork").bind('click', function(event) {
		
		var workCode = document.getElementById("workCode")
		
		if(workCode.value == '1000')
			$("#work_selectMenu1000").trigger("click");
		else if(workCode.value == '1001')
			$("#work_selectMenu1001").trigger("click");
		else if(workCode.value == '1003')
			$("#work_selectMenu1003").trigger("click");
		else if(workCode.value == '1004')
			$("#work_selectMenu1004").trigger("click");
		/*
		else if(workCode.value == '1005')
			$("#work_selectMenu1005").trigger("click");
		*/
		else if(workCode.value == '1006')
			$("#work_selectMenu1006").trigger("click");
		else if(workCode.value == '1007')
			$("#work_selectMenu1007").trigger("click");
		else if(workCode.value == '1008')
			$("#work_selectMenu1008").trigger("click");
		else if(workCode.value == '1009')
			$("#work_selectMenu1009").trigger("click");
		else if(workCode.value == '1010')
			$("#work_selectMenu1010").trigger("click");
		else if(workCode.value == '1011')
			$("#work_selectMenu1011").trigger("click");
		else if(workCode.value == '1012')
			$("#work_selectMenu1012").trigger("click");
		
	})
	
	document.addEventListener('keydown', function(e){
		const keyCode = e.keyCode;
		
		if(keyCode == 13){ 
			var msg = document.getElementById("message")
			var workCode = document.getElementById("workCode")
			
			if(document.activeElement === msg) {
				if(msg.value != '') {
					let str = '';
					str += '<strong> 텔러 : ' + msg.value + '</strong>';
					str += '<br>'
					$('#chat').append(str);
					sendChat(msg.value);
				
					$('#message').val('');
					console.log('dd');
				}
			}
			
			else if(document.activeElement === workCode) {
				
				if(workCode.value == '1000')
					$("#work_selectMenu1000").trigger("click");
				else if(workCode.value == '1001')
					$("#work_selectMenu1001").trigger("click");
				else if(workCode.value == '1003')
					$("#work_selectMenu1003").trigger("click");
				else if(workCode.value == '1004')
					$("#work_selectMenu1004").trigger("click");
				/*
				else if(workCode.value == '1005')
					$("#work_selectMenu1005").trigger("click");
				*/
				else if(workCode.value == '1006')
					$("#work_selectMenu1006").trigger("click");
				else if(workCode.value == '1007')
					$("#work_selectMenu1007").trigger("click");
				/*
				else if(workCode.value == '1008')
					$("#work_selectMenu1008").trigger("click");
				*/
				
			}
		} 
		
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

	function hyphenPhone(tel) {
		let phone = '';
		for(let i = 0; i < tel.length; i++) {
			if(i == 3 || i == 7)
				phone += '-';
			phone += tel[i];
		}
		return phone;
		//$('#phone').text(phone);
	}
	
	function hyphenRegNo(regNumber) {
		
		let regNo = '';
		for(let i = 0; i < regNumber.length; i++) {
			if(i == 6)
				regNo += '-';
			regNo += regNumber.text()[i];
		}
		//$('#regNo').text(regNo);
		return regNumber
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