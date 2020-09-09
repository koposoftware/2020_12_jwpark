<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>

	// work /////
	var passChangeAccount
	
	var telCheck = false;
	
	$("#menu-toggle").click(function(e) {
  		e.preventDefault();
  		$("#wrapper").toggleClass("toggled");
  	});
	
	$("#sendSMSAuth").bind('click', function(event) {
		
		$('#workModal').empty();
		let content = '';
		content += '손님에게 문자인증 화면을 출력하였습니다.';
		$('#workModal').append(content);
		$("#modal").fadeIn();
		
		socket.emit('work', 'smsAuth');
	})
	
	$("#captureID").bind('click', function(event) {
		
		$('#workModal').empty();
		let content = '';
		content += '<div id="cnvsDiv"><canvas id="cnvs" style="width: 100%"></canvas></div>'
		content += '<button id="saveCapture">저장</button>'
		//content += '<a href="" download="${clientVO.name}_${clientVO.id}.png">저장</a>'
		$('#workModal').append(content);
		$("#modal").fadeIn();
		
		var cnvs= document.getElementById('cnvs');
		var ctx = cnvs.getContext('2d');
		
		var div = document.getElementById('cnvsDiv'); 
		
		var rate = remoteVideo.clientWidth / remoteVideo.clientHeight;
		console.log(remoteVideo.clientWidth)
		console.log(remoteVideo.clientHeight)
		//cnvs.width= div.clientHeight * rate;
		cnvs.width= div.clientWidth;
		cnvs.height= div.clientWidth/rate;
		ctx.drawImage(remoteVideo, 0, 0, cnvs.clientHeight * rate, cnvs.clientHeight);
		
	})
	
	
	$(document).on('click', "#saveCapture", function() {
		
		//var canvas = document.createElement('canvas');
		var imgDataUrl = cnvs.toDataURL('image/png');
		
		var blobBin = atob(imgDataUrl.split(',')[1]);
		var array = [];
		for(var i = 0; i < blobBin.length; i++) {
			array.push(blobBin.charCodeAt(i));
		}
		var file = new Blob([new Uint8Array(array)], {type: 'image/png'});
		var formdata = new FormData();
		formdata.append("file", file);
		
		$.ajax({
			type : 'post',
			url : '${pageContext.request.contextPath}/saveIDCardImage',
			data : formdata,
			processData : false,
			contentType : false,
			success : function(result) {
				
			}
		})
	})
	
	$("#reverseClientScreen").bind('click', function(event) {
		
		$('#workModal').empty();
		let content = '';
		content += '손님의 바탕색을 반전하였습니다.'
		//content += '<a href="" download="${clientVO.name}_${clientVO.id}.png">저장</a>'
		$('#workModal').append(content);
		$("#modal").fadeIn();
		
		socket.emit('work', 'reverseScreen');
	})
	
	$("#work_selectAccount1000").bind('click', function(event) {
		
		$('#workBtns').empty();
		$('#workTitle').text('자유 입출금 계좌 조회')
		let content ='';
		content +=     '<button class="btn btn-info" id="userAccountList">자유 입출금 계좌 조회</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		content +=     '<button class="btn btn-info" id="userDepositList">예금 조회</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		content +=     '<button class="btn btn-info" id="userSavingList">적금 조회</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		
		$('#workBtns').empty();
		$('#workBtns').append(content)
		
		$("#userAccountList").trigger("click");
	})
	
	$("#work_selectAccount1003").bind('click', function(event) {
		
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
	
	$("#work_selectAccount1004").bind('click', function(event) {
		
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
	
	$("#work_selectAccount1006").bind('click', function(event) {
		
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
	
	$("#work_selectAccount1007").bind('click', function(event) {
		
		$('#workDiv').empty();
		let content = '';
		
		//content += '<div id="workName">예금 가입</div>';
		
		$('#workTitle').text('전자 금융 가입')
		if('${clientVO.elecFinanceStatus}' == 'T') {
			content +=     '<button class="btn btn-info" id="selectElecFinanceUserInfo">전자금융 가입 정보</button>&nbsp;&nbsp;&nbsp;&nbsp;';
			//content +=     '<button class="btn btn-info" id="changeElecFinanceUserPass">전자금융 비밀번호 변경</button>&nbsp;&nbsp;&nbsp;&nbsp;';
		} else {
			content +=     '<button class="btn btn-info" id="insertElecFinanceUser">전자금융 가입</button>';
		}
		
		$('#workBtns').empty();
		$('#workBtns').append(content)
		$('#workDiv').empty();
		
		if('${clientVO.elecFinanceStatus}' == 'T') {
			content +=     '<button class="btn btn-info" id="selectElecFinanceUserInfo">전자금융 가입 정보</button>&nbsp;&nbsp;&nbsp;&nbsp;';
			$("#selectElecFinanceUserInfo").trigger("click");
		} else {
			content +=     '<button class="btn btn-info" id="insertElecFinanceUser">전자금융 가입</button>';
			$("#insertElecFinanceUser").trigger("click");
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