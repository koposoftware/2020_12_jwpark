<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
		console.log('${userVO.id}');
		var host = 'https://192.168.217.52';
		var port = '1337';
		var nodeUrl = 'https://192.168.217.52:1337'
		var springUrl = 'https://192.168.217.52:8811'
		//var url = 'https://localhost:1337'
		//var url = 'https://192.168.0.7:1337';
		var socket;
		
		var bool = true;
		
		var jobType;
		
		//$("#loading_image").hide();
		
		function connectToServer() {

			var options = {
				'forceNew' : true
			};
			//var url = "http://" + host + ":" + port;
			//var url = "https://" + host + ":" + port;
			//println(url);
			//socket = io.connect(url, options);
			socket = io.connect(nodeUrl, options);

			socket.on('connect', function() {
				
				//println("웹 소켓 서버에 연결되었습니다. : " + nodeUrl);
				
				socket.on('check', function(event) {
					console.log(event);
					//println('check Event');
					//socket.emit('type', 'client:' + 'jinwoo11')
					socket.emit('waitRoom', 'client:' + '${userVO.id}' + ':' + jobType)
				})
				
				socket.on('ready', function(id) {
					println('ready Event');
					//location.href="https://localhost:8811/spring-project/bankCounter";
					//location.href= "https://192.168.0.7:8811/spring-project/bankCounter";
					//location.href= "https://192.168.217.52:8811/spring-project/bankCounter";
					location.href= springUrl + "/spring-project/bankCounter";
				})
				
				socket.on('waitingClients', function(event) {
					console.log('wait Client : ' + event);
					$("#clientCount").empty();
					$("#clientCount").append('상담 대기중인 손님 ' + event + '명');
				})
				
				socket.on('message', function(message) {
					
				});
			});
			
			socket.on('disconnect', function() {
				println('웹 소켓 연결이 종료되었습니다.');
			});
		}
		
		$(".job").bind('click', function(event) {
			
			jobType = $(this).attr("id");
			
			connectToServer();
			
			//$("#loading_image").show();
			//document.getElementById("modal").style.display="block";
			$("#modal").fadeIn();
			/*
			if(bool) {
				println('bankJob 버튼이 클릭되었습니다.');
				connectToServer('bankJob');
				
				//$("#loading_image").show();
				document.getElementById("modal").style.display="block";
				
			} else {
				//$("#loading_image").hide();
				document.getElementById("modal").style.display="none";
				socket.emit('clientDisconnect');
			}
			bool = !bool
			*/
		})
		
		$(".btn-primary").bind('click', function(event) {
			
			var openNewWindow = window.open("about:blank");
			
			if($(this).attr('id') == 'deposit'){
				openNewWindow.location.href = "https://www.kebhana.com/cont/mall/mall08/mall0805/index.jsp?catId=spb_2811";
			} else if($(this).attr('id') == 'card') {
				openNewWindow.location.href = "https://www.hanacard.co.kr/index2.jsp";
			} else if($(this).attr('id') == 'fund') {
				openNewWindow.location.href = "https://www.kebhana.com/cont/mall/mall26/mall2602/index.jsp?_menuNo=62634";
			} else if($(this).attr('id') == 'insurance') {
				openNewWindow.location.href = "https://www.kebhana.com/cont/mall/mall08/mall0805/index.jsp?insSch=insAllSch&_menuNo=99073";
			}
		})

		$("#STMlink").bind('click', function(event) {
			
			var openNewWindow = window.open("about:blank");
			openNewWindow.location.href = "https://www.kebhana.com/cont/info/info03/info030d/index.jsp";
		})
		
		document.getElementById("modal_close_btn").onclick = function() {
			
			$("#modal").fadeOut();
			//document.getElementById("modal").style.display="none";
			socket.emit('waitRoomClientDisconnect');
    	}   
		
		function println(data) {
			console.log (data);
			$('#result').append('<p>' + data + '</p>')
		}
</script>