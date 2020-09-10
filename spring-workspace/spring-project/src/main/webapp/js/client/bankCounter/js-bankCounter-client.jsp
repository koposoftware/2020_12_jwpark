<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	document.getElementById("modal_close_btn").onclick = function() {
		
		if(workType == 'pwChange'){
			socket.emit('work', 'pwClose');
		} else if(workType == 'inputPassword'){
			socket.emit('work', 'pwClose');
		} else if(workType == 'depositAgree'){
			socket.emit('work', 'depositAgreeClose');
		} else if(workType == 'savingAgree'){
			socket.emit('work', 'savingAgreeClose');
		} else if(workType == 'smsAuth'){
			socket.emit('work', 'authFailure');
		} else if(workType == 'elecFinancePwChange'){
			socket.emit('work', 'elecFinancePwChangeClose');
		} else if(workType == 'getElecIDPassword'){
			socket.emit('work', 'getElecIDPasswordClose');
		} 
		$("#modal").fadeOut();
		
	}   
	
	
	
	document.addEventListener('keydown', function(e){
		const keyCode = e.keyCode;
		//console.log(e.keyCode)
		if(keyCode == 13){ 
			var msg = document.getElementById("message")

			if(document.activeElement === msg) {
				if(msg.value != '') {
					let str = '';
					str += '<strong> 손님 : ' + msg.value + '</strong>';
					str += '<br>'
					$('#chat').append(str);
					sendChat(msg.value);
				
					$('#message').val('');
					
				}
			}
			
		} 
		
	})
	
	function checkPasswordPattern(str) {
		var pattern1 = /[0-9]/; // 숫자
		if(!pattern1.test(str) || str.length != 4)
			return false;
		else
			return true;
	}
	
	  function checkIdPattern(str) {
		  var pattern1 = /[0-9]/; // 숫자 
		  var pattern2 = /[a-zA-Z]/; // 문자
		  //var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/;	// 특수문자 

		  if(!pattern1.test(str) || !pattern2.test(str) || str.length < 6) {
			  return false
		  }
		  else
			  return true;
	  }
	  
	  function checkElecFinancePasswordPattern(str) {
		  var pattern1 = /[0-9]/; // 숫자 
		  var pattern2 = /[a-zA-Z]/; // 문자 
		  var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자 
		  if(!pattern1.test(str) || !pattern2.test(str) || !pattern3.test(str) || str.length < 8) 
			  return false; 
		  else
			  return true;
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
	
	function println(data) {
		console.log(data);
		$('#result').append('<p>' + data + '</p>')
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
			
	window.onbeforeunload = function() {
		sendMessage('bye');
	};
</script>