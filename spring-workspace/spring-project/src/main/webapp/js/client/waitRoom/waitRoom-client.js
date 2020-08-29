/**
 * 
 */
$(document).ready(function() {
		
		var host = 'https://192.168.217.52';
		var port = '1337';
		//var url = 'https://192.168.217.52:1337'
		var url = 'https://localhost:1337'
		var socket;
		
		var bool = true;
		
		$("#loading_image").hide();
		
		function connectToServer(jobType) {

			var options = {
				'forceNew' : true
			};
			//var url = "http://" + host + ":" + port;
			//var url = "https://" + host + ":" + port;
			println(url);
			socket = io.connect(url, options);

			socket.on('connect', function() {
				
				println("웹 소켓 서버에 연결되었습니다. : " + url);
				
				socket.on('check', function(event) {
					console.log(event);
					println('check Event');
					socket.emit('type', 'client:' + 'jinwoo11')
					//socket.emit('type', 'client:' + ${userVO.id})
				})
				
				socket.on('ready', function(id) {
					println('ready Event');
					//location.href="https://localhost:8811/spring-project/bankCounter-client.jsp";
					location.href="https://localhost:8811/spring-project/bankCounter";
				})
				
				
				socket.on('message', function(message) {
					
					if(message ==='got user media') {
					}
				});
			});
			
			socket.on('disconnect', function() {
				println('웹 소켓 연결이 종료되었습니다.');
			});
		}
		
		$("#bankJob").bind('click', function(event) {
			if(bool) {
				println('bankJob 버튼이 클릭되었습니다.');
				connectToServer('bankJob');
				$("#loading_image").show();
				
			} else {
				$("#loading_image").hide();
				socket.emit('clientDisconnect');
			}
			bool = !bool
		})
		
		function println(data) {
			console.log (data);
			$('#result').append('<p>' + data + '</p>')
		}
	})