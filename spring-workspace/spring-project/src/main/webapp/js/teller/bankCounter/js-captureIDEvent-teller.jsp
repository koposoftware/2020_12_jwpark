<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	
	$("#captureID").bind('click', function(event) {
		
		$('.modal-header').empty();
		let content = '';
		content += '<div>손님의 신분증을 촬영합니다.</div><div>손님의 화면에 신분증의 글씨가 잘 보이게 촬영해주세요.</div><hr><div>확인 버튼을 누르면 촬영합니다.</div>';
		
		$('.modal-header').append(content);
		
		$("#mi-modal").modal('show');
	
		$("#modal-btn-si").unbind("click");
		$("#modal-btn-si").bind("click",function(){
			
			capture();
			$("#mi-modal").modal('hide');
		})
		
		$("#modal-btn-no").bind("click",function(){
			
			$("#mi-modal").modal('hide');
		})
		
		
	})

	function capture() {
		
		$('#workModal').empty();
		let content = '';
		content += '<div id="cnvsDiv"><canvas id="cnvs" style="width: 100%"></canvas></div>'
		//content += '<button id="saveCapture">저장</button>'
		content += '<div>손님의 신분증이 저장되었습니다.</div>'
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
		
		socket.emit('work', 'captureId');
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
			url : '${pageContext.request.contextPath}/saveIDCardImage/${clientVO.id}/${clientVO.name}' ,
			data : formdata,
			processData : false,
			contentType : false,
			success : function(result) {
				
				$('#idCardAuthStatus').css("color", "green");
				$('#idCardAuthStatus').text("신분증 확인 완료");
				
				$('#chkIDCard').css("color", "green");
				$('#chkIDCard').text("신분증 확인 및 촬영 완료");
				chkIdCard = true;
			}
		})
	}
	
	$(document).on('click', "#saveCapture", function() {
		
		
	})
	
</script>