<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

	var host = 'https://192.168.217.52';
	var port = '1337';
	//var url = 'https://192.168.217.52:1337'
	//var url = 'https://localhost:1337'
	var url = 'https://192.168.0.7:1337';
	var socket;
	
	connectToServer();
	
	function connectToServer() {

		var options = {
			'forceNew' : true
		};
		//var url = "http://" + host + ":" + port;
		//var url = "https://" + host + ":" + port;
		
		socket = io.connect(url, options);

		socket.on('connect', function() {

			socket.on('check', function(event) {
				
				console.log('check Event');
				socket.emit('waitRoom', 'waitTeller')
			})
			
			socket.on('ready', function(room) {
				
				var clientID = room.split(':')[0];
				var jobType = room.split(':')[1];
				
				console.log(room)
				
				var keys = new Array();
				keys.push('userID');
				keys.push('jobType');
				var values = new Array();
				values.push(clientID);
				values.push(jobType);
				
				//post_to_url("https://localhost:8811/spring-project/teller/bankCounter", "userID", clientID);
				//post_to_url("https://localhost:8811/spring-project/teller/bankCounter", keys, values);
				post_to_url("https://192.168.0.7:8811/spring-project/teller/bankCounter", keys, values);
				//location.href="https://localhost:8811/spring-project/teller/bankCounter";
				console.log('joined: ' + room);
			})
			
			// 'message' event 날아왔을 때 행동 정의
			socket.on('message', function(message) {
				
			});
			
			socket.on('waitingClients', function(event) {
				console.log('wait Client : ' + event);
				$("#clientCount").empty();
				$("#clientCount").append('상담 대기중인 손님 ' + event + '명');
			})
		});
		
		socket.on('disconnect', function() {
			console.log('웹 소켓 연결이 종료되었습니다.');
		});
	}
	
	$("#startCounseling").bind('click', function(event) {
		
		sendStart();
		$("#modal").fadeIn();
	})
	
	document.getElementById("modal_close_btn").onclick = function() {
		
		$("#modal").fadeOut();
		//document.getElementById("modal").style.display="none";
		socket.emit('waitRoomTellerDisconnect');
	}   
	
	function sendStart() {
		
		if(socket == undefined) {
			alert('You are not connected status. Connect Server.');
			return;
		}
		
		socket.emit('waitRoom', 'teller');
	}
	
	function post_to_url(path, key, param) {
		let method = "post"; // 전송 방식 기본값을 POST로
  	 	
  	    var form = document.createElement("form");
  	    form.setAttribute("method", method);
  	    form.setAttribute("action", path);
  	    
  	    for(let i = 0; i < key.length; i++) {
  	    	var hiddenField = document.createElement("input");
  	    	hiddenField.setAttribute("type", "hidden");
  	    	hiddenField.setAttribute("name", key[i]);
  	    	hiddenField.setAttribute("value", param[i]);
  	    	console.log(key[i]);
  	    	console.log(param[i]);
  	    	
  	    	form.appendChild(hiddenField);
  	    }
  	    
  	    document.body.appendChild(form);
  	    form.submit();
	}

</script>