<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

	var chkSavingAgree = false;

	var savingMinEntryAmmount, savingMaxEntryAmmount;
	var savingMinSavingAmmount, savingMaxSavingAmmount;
	var savingMinPeriod, savingMaxPeriod;

	var savingSigninEntryAmmount, savingSinginSavingAmmount, savingSigninPeriod;
	var savingSigninAccountNo, savingSigninProductName;

	$(document).on('click', "#userSavingList", function() {
	
		$('#workDiv').empty();
		
		let content = '';
		
		$('#workTitle').text('사용자 적금 가입 현황');
		//content += '<div id="workName">예금 목록</div>';
		content += '<div id="workSpace">';
		
		$.ajax({
			url : '${pageContext.request.contextPath}/saving/' + '${clientVO.regNo}',
			type : 'get',
			success : function(data) {
				
				if(data.length != 0) {
					content += '<div style="width:100%; height:200px; overflow:auto">';
					content +=     '<table class="table table-hover" style="text-align:center">';
					content +=         '<thead>';
					content +=             '<tr>'
					content +=                 '<th scope="col">계좌 번호</th>';
					content +=                 '<th scope="col">상품명</th>';
					content +=                 '<th scope="col">적용 금리</th>';
					content +=                 '<th scope="col">총 적금액</th>';
					content +=                 '<th scope="col">적금액(월)</th>';
					content +=                 '<th scope="col">가입일</th>';
					content +=                 '<th scope="col">만기일</th>';
					content +=                 '<th scope="col">연결된 계좌</th>';
					content +=             '</tr>';
					content +=         '</thead>';
					content +=         '<tbody>';
					
					for(i = 0; i < data.length; i++) {
						
						content +=         '<tr>';
						content +=             '<td>' + makeHyphen(data[i].accountNo, 4) + '</td>';
						content +=             '<td>' + data[i].nameCode + '</td>';
						content +=             '<td>' + data[i].interest + '%</td>';
						content +=             '<td>' + comma(data[i].savingAmmount) + '원</td>';
						content +=             '<td>' + comma(data[i].plannedAmmount) + '원</td>';
						content +=             '<td>' + data[i].regDate + '</td>';
						content +=             '<td>' + data[i].expiredDate + '</td>';
						content +=             '<td>' + makeHyphen(data[i].refAccountNo, 4) + '</td>';
						content +=         '</tr>';
					}							
					content +=         '</tbody>';
					content +=     '</table>';
					content += '</div>';
					
					$('#workDiv').append(content);
					
				}
				else {
					content += '손님이 가입한 적금상품이 없습니다.';
					$('#workDiv').append(content);
				}
				
			},error : function() {
				
				$('#workModal').empty();
				let content = '';
				content += '적금가입 조회에 실패했습니다.';
				$('#workModal').append(content);
				$("#modal").fadeIn();
			}
		})
	})
	

	$(document).on('click', "#refSavingList", function() {
	
		$('#workDiv').empty();
		
		let content = '';
		
		//content += '<div id="workName">예금 가입</div>';
		$('#workTitle').text('적금 상품 정보')
		content += '<div id="workSpace">';
		content += '<div id="linkBtn" style="text-align:left;" >';
		content +=     '<button class="btn btn-info" id="showAllSavingLink">적금 전체 상품 목록 링크</button>';
		content += '</div>';
		$.ajax({
			url : '${pageContext.request.contextPath}/savingProducts',
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
					content +=                 '<th scope="col">최저  적금액(월)</th>';
					content +=                 '<th scope="col">최대 적금액(월)</th>';
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
						if(data[i].minEntryAmmount != 0){
							content +=             '<td>' + comma(data[i].minEntryAmmount * 1000) + '원</td>';
						} else {
							content +=             '<td>제한 없음</td>';
						}
						if(data[i].maxEntryAmmount != 0){
							content +=             '<td>' + comma(data[i].maxEntryAmmount * 1000) + '원</td>';
						} else {
							content +=             '<td>제한 없음</td>';
						}
						if(data[i].minSavingAmmount != 0){
							content +=             '<td>' + comma(data[i].minSavingAmmount * 1000) + '원</td>';
						} else {
							content +=             '<td>제한 없음</td>';
						}
						if(data[i].maxSavingAmmount != 0){
							content +=             '<td>' + comma(data[i].maxSavingAmmount * 1000) + '원</td>';
						} else {
							content +=             '<td>제한 없음</td>';
						}
						content +=             '<td><button class="depositLeaflet" id="' + data[i].leafletUrl + '">열기</button></td>';	
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
	
	$(document).on('click', "#showAllSavingLink", function() {

		var openNewWindow = window.open("about:blank");
		openNewWindow.location.href = "https://www.kebhana.com/cont/mall/mall08/mall0805/index.jsp";
	})
	
	$(document).on('click', ".savingLeaflet", function() {

		let url = $(this).attr('id');
		var openNewWindow = window.open("about:blank");
		openNewWindow.location.href = url;
	})
	
	
	$(document).on('click', "#savingSignUp", function() {

		$('#workDiv').empty();
	
		let content = '';
	
		$('#workTitle').text('적금 가입')
		content += '<div id="workSpace">';
	
		$.ajax({
			url : '${pageContext.request.contextPath}/savingProducts',
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
					content +=                 '<th scope="col">최저 적금액(월)</th>';
					content +=                 '<th scope="col">최대 적금액(월)</th>';
					content +=                 '<th scope="col">가입 서비스</th>';
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
						if(data[i].minEntryAmmount != 0){
							content +=             '<td>' + comma(data[i].minEntryAmmount * 1000) + '원</td>';
						} else {
							content +=             '<td>제한 없음</td>';
						}
						if(data[i].maxEntryAmmount != 0){
							content +=             '<td>' + comma(data[i].maxEntryAmmount * 1000) + '원</td>';
						} else {
							content +=             '<td>제한 없음</td>';
						}
						if(data[i].minSavingAmmount != 0){
							content +=             '<td>' + comma(data[i].minSavingAmmount * 1000) + '원</td>';
						} else {
							content +=             '<td>제한 없음</td>';
						}
						if(data[i].maxSavingAmmount != 0){
							content +=             '<td>' + comma(data[i].maxSavingAmmount * 1000) + '원</td>';
						} else {
							content +=             '<td>제한 없음</td>';
						}
						content +=             '<td><button class="savingSignUpBtn" id="' + data[i].nameCode + '">가입하기</button></td>';	
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
				content += '적금상품 조회에 실패했습니다.';
				$('#workModal').append(content);
				$("#modal").fadeIn();
			}
		})
	})

	$(document).on('click', ".savingSignUpBtn", function() {
		
		$('#workDiv').empty();
		
		let content = '';
		
		$('#workTitle').text('적금 가입');
		content += 	'<div id="workSpace" style="text-align : left">';
		content += 	'<div id="leftSpace" style="width:50%; display:inline; float:left;">';
	
		content += 		'<div class="savingProductName" id="' + $(this).attr('id') +'"style="font-size:x-large;">상품명 : ' + $(this).attr('id') + '</div>';
		content += 		'<br>';
		content += 		'<div style="font-size:x-large;">출금계좌</div>';
		let result = false;
		
		let deposit;
		chkPassword = false;
		chkSavingAgree = false;
		$.ajax({
			url : '${pageContext.request.contextPath}/savingProductOne/' + $(this).attr('id'),
			type : 'get',
			success : function(data) {
				
				if(data.length != 0) {
					let saving = data;
					
					//////////////////////////////////////////
					$.ajax({
						url : '${pageContext.request.contextPath}/account/'+'${clientVO.regNo}',
						type : 'get',
						success : function(data) {
							
							if(data.length != 0) {
								
								savingMinEntryAmmount = saving.minEntryAmmount * 1000;
								savingMaxEntryAmmount = saving.maxEntryAmmount * 1000;
								savingMinSavingAmmount = saving.minSavingAmmount * 1000;
								savingMaxSavingAmmount = saving.maxSavingAmmount * 1000;
								savingMinPeriod = saving.minPeriod;
								savingMaxPeriod = saving.maxPeriod;
								
								content += 			'<select name="account" id="accountSelect" style="text-align-last:center;width:90%;height:50px;font-size:22px;">'
								for(let i = 0; i < data.length; i++) {
									if(i == 0) {
										content += 				'<option class="accountlist" value=' + data[i].accountNo + ' selected>' + makeHyphen(data[i].accountNo, 4) +', ' +  comma(data[i].withdrawableBalance) +'원</option>'
									} else {
										content += 				'<option class="accountlist" value=' + data[i].accountNo + '>' + makeHyphen(data[i].accountNo, 4) +', ' +  comma(data[i].withdrawableBalance) +'원</option>'
									}
								}
								content +=		'</select>';
								content += 		'<div id="inputPassword" style="text-align:right; padding-right:10%;">'
								content +=			'<div id="chkPass" >';
								content +=			'</div>';
								content +=			'<br>';
								content +=			'<button id="askPassword" class="btn btn-info" style="width:150px; height:40px;">비밀번호 입력받기</button>';
								content += 		'</div>'
								content += 	'</div>';
								content += 	'<div id="rightSpace" style="width:50%; display:inline; float:left;">';
								content += 		'<div id="ammountPeriod" style="font-size:x-large;">';
								
								//content +=			'<div style="margin-top:5%">';
								content +=			'<div>';
								content +=				'신규 금액';
								
								let phEntryAmmount;
								if(saving.minEntryAmmount != 0)
									phEntryAmmount = 			'최소 ' + comma(saving.minEntryAmmount * 1000) + '원 ';
								else
									phEntryAmmount = 			'최소 ' + comma(10000) + '원';
								if(saving.maxEntryAmmount != 0)
									phEntryAmmount += 			'최대 ' + comma(saving.maxEntryAmmount * 1000) + '원 ';
								else
									phEntryAmmount += 			'최대 제한 없음';
								
								content +=				'<input type="text" autocomplete="off" id="savingEntryAmmount" placeholder=" ' + phEntryAmmount + '" style="width:90%; height:30px;text-align:right;"> 원';
								
								content +=			'</div>';
								content +=			'<div>';
								content +=				'적금액(월)';
								
								let phSavingAmmount;
								if(saving.minSavingAmmount != 0)
									phSavingAmmount = 			'최소 ' + comma(saving.minSavingAmmount * 1000) + '원 ';
								else
									phSavingAmmount = 			'최소 ' + comma(10000) + '원';
								if(saving.maxSavingAmmount != 0)
									phSavingAmmount += 			'최대 ' + comma(saving.maxSavingAmmount * 1000) + '원 ';
								else
									phSavingAmmount += 			'최대 제한 없음';
								
								content +=				'<input type="text" autocomplete="off" id="savingSavingAmmount" placeholder=" ' + phSavingAmmount + '" style="width:90%; height:30px; text-align:right;"> 원';
								
								content +=			'</div>';
								
								//content +=			'<div style="margin-top:5%">';
								content +=			'<div>';
								content +=			'가입 기간 ';
								
								let phPeriod;
								if(saving.minPeriod != 0)
									phPeriod = 			'최소 ' + saving.minPeriod + '개월'
								else
									phPeriod = 			'최소 1개월'
								if(saving.maxPeriod != 0)
									phPeriod += ' 최대 ' + saving.maxPeriod +'개월'
								else
									phPeriod += ' 최대 제한없음'
								
								content +=			'<input type="text" autocomplete="off" id="savingPeriod" placeholder=" ' + phPeriod + '"style="width:90%; height:30px; text-align:right;"> 개월';
								content += 			'</div>';
								content += 		'</div>';
								content += 		'<div id="inputAgreement" style="text-align:right; padding-right:5%;">';
								content +=			'<div id="chkSavingAgree"></div>';
								content +=			'<button id="savingAgree" class="btn btn-info" style="width:150px; height:40px;">동의서 전송하기</button>';
								content += 		'</div>';
								content += 		'<div style="text-align:right; padding-right:5%; margin-top:10px;">';
								content +=			'<button id="savingInputComp" class="btn btn-info" style="width:150px; height:40px;">가입 진행하기</button>';
								content += 		'</div>';
								content += 	'</div>';
								//content += '</div>'
							}
							else {
								content += '존재하는 사용자 계좌가 없습니다.';
								$('#workDiv').append(content);
							}
							
							$('#workDiv').append(content);
							
							$("#chkPass").text("비밀번호 인증 미완료");
							$("#chkPass").css("color", "red");		
							
							$("#chkSavingAgree").text("사용자 동의서 작성 미완료");
							$("#chkSavingAgree").css("color", "red");		
						},error : function() {
								
							$('#workModal').empty();
							let content = '';
							content += '적금상품 조회에 실패했습니다.';
							$('#workModal').append(content);
								$("#modal").fadeIn();
						}
					})
					//////////////////////////////////////////
					
				}
				else {
					content += '존재하는 적금상품이 없습니다.';
					$('#workDiv').append(content);
					
				}
				
			},error : function() {
					
				$('#workModal').empty();
				let content = '';
				content += '적금상품 조회에 실패했습니다.';
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
		
		$('#workModal').empty();
		let content = '';
		content += '손님에게 비밀번호 입력 화면을 출력하였습니다.';
		$('#workModal').append(content);
		$("#modal").fadeIn();
		
	})


	$(document).on('click', "#savingAgree", function() {
		$('#workModal').empty();
		let content = '';
		content += '동의서 작성화면을 출력하였습니다.';
		$('#workModal').append(content);
		$("#modal").fadeIn();
		socket.emit('work', 'savingAgree');
	})
	

	$(document).on('click', "#savingInputComp", function() {
		
		var accountSelect = document.getElementById("accountSelect");
		var selectValue = accountSelect.options[accountSelect.selectedIndex].value;
		
		if($('#savingEntryAmmount').val() == '' || $('#savingSavingAmmount').val() == '' || $('#savingPeriod').val() == '') {
			$('#workModal').empty();
			let content = '';
			content += '입력이 완료되지 않았습니다.';
			$('#workModal').append(content);
			$("#modal").fadeIn();
			return;
		}
		
		$.ajax({
			url : '${pageContext.request.contextPath}/account/withDrawable/'+selectValue,
			type : 'get',
			success : function(data) {
				
				let aBool = true;
				if(Number(savingMinEntryAmmount) <= Number($('#savingEntryAmmount').val())) {
					if(savingMaxEntryAmmount != 0) {
						if(Number($('#savingEntryAmmount').val()) <= Number(savingMaxEntryAmmount)){
						} else {
							aBool = false;
						}
					}
				} else {
					aBool = false;
				}
				if( Number(data.withdrawableBalance) <= Number($('#savingEntryAmmount').val())) {
					
					aBool = false;
				}
				
				if(!aBool) {
					$('#workModal').empty();
					let content = '';
					content += '신규 금액항목이 올바르지 않습니다.';
					$('#workModal').append(content);
					$("#modal").fadeIn();
					return;
				}			
			},error : function() {
					
				$('#workModal').empty();
				let content = '';
				content += '잔액 조회에 실패했습니다.';
				$('#workModal').append(content);
				$("#modal").fadeIn();
				return;
			}
		})
		
		let sBool = true;
		if(Number(savingMinSavingAmmount) <= Number($('#savingSavingAmmount').val())) {
			if(savingMaxSavingAmmount != 0) {
				if(Number($('#savingSavingAmmount').val()) <= Number(savingMaxSavingAmmount)){
				} else {
					alert('dd')
					sBool = false;
					
				}
			}
		} else {
			alert('dfd')
			sBool = false;
		}
		
		if(!sBool) {
			$('#workModal').empty();
			let content = '';
			content += '적금액(월)항목이 올바르지 않습니다';
			$('#workModal').append(content);
			$("#modal").fadeIn();
			return;
		}
		
		let pBool = true;
		if(Number(savingMinPeriod) <= Number($('#savingPeriod').val())) {
			if(savingMaxPeriod != 0) {
				if(Number($('#savingPeriod').val()) <= Number(savingMaxPeriod)){
				} else {
					pBool = false;
					
				}
			}
		} else {
			pBool = false;
		}
		
		if(!pBool) {
			$('#workModal').empty();
			let content = '';
			content += '가입기간항목이 올바르지 않습니다';
			$('#workModal').append(content);
			$("#modal").fadeIn();
			return;
		}
		
		if(!chkPassword) {
			$('#workModal').empty();
			let content = '';
			content += '손님의 비밀번호를 입력이 완료되지않았습니다.';
			$('#workModal').append(content);
			$("#modal").fadeIn();
			return;
		} else if(!chkSavingAgree) {
			$('#workModal').empty();
			let content = '';
			content += '손님의 동의서 작성이 완료되지않았습니다';
			$('#workModal').append(content);
			$("#modal").fadeIn();
			return;
		}
		
		
		$('.modal-header').empty();
		let content = '';
		content += '<div style="text-align : left;">';
		content +=     '<table class="table table-hover" style="text-align:left">';
		content +=         '<tbody>';
		content +=         '<tr>';
		content +=             '<td>상품종류 : ' + $(".savingProductName").attr('id') + '</td>';
		content +=         '</tr>';
		content +=         '<tr>';
		content +=             '<td>출금계좌번호 : ' + makeHyphen(selectValue, 4) + '</td>';
		content +=         '</tr>';
		content +=         '<tr>';
		content +=             '<td>신규금액 : ' + comma($('#savingEntryAmmount').val()) + '원</td>';
		content +=         '</tr>';
		content +=         '<tr>';
		content +=         '<tr>';
		content +=             '<td>적금액(월) : ' + comma($('#savingSavingAmmount').val()) + '원</td>';
		content +=         '</tr>';
		content +=         '<tr>';
		content +=             '<td>가입기간 : ' + $('#savingPeriod').val() + '개월</td>';
		content +=         '</tr>';
		content +=         '</tbody>';
		content +=     '</table>';
		content += 		'<div>가입 정보를 확인 후 손님에게 안내해주세요. 손님이 동의하시면 가입이 완료됩니다.</div>';
		content += '</div>';
		
		$('.modal-header').append(content);
		
		$("#mi-modal").modal('show');
		
		document.getElementById("modal-btn-si").onclick = null;
		
		$("#modal-btn-si").unbind("click");
		
		$("#modal-btn-si").bind("click",function(){
			savingSigninEntryAmmount = $('#savingEntryAmmount').val();
			savingSinginSavingAmmount = $('#savingSavingAmmount').val();
			savingSigninPeriod = $('#savingPeriod').val();
			savingSigninAccountNo = selectValue;
			savingSigninProductName = $(".savingProductName").attr('id');
			
			console.log('send Message : savingInputcomp')
			socket.emit('work', 'savingInputComp:' + $(".savingProductName").attr('id') + ':' + makeHyphen(selectValue, 4) + ':' + $('#savingEntryAmmount').val() + ':' + $('#savingSavingAmmount').val() + ':' + $('#savingPeriod').val())
			
			$("#mi-modal").modal('hide');
		});
		
		/*
		$("#modal-btn-si").on("click", function(){
			
			savingSigninEntryAmmount = $('#savingEntryAmmount').val();
			savingSinginSavingAmmount = $('#savingSavingAmmount').val();
			savingSigninPeriod = $('#savingPeriod').val();
			savingSigninAccountNo = selectValue;
			savingSigninProductName = $(".savingProductName").attr('id');
			
			console.log('send Message : savingInputcomp')
			socket.emit('work', 'savingInputComp:' + $(".savingProductName").attr('id') + ':' + makeHyphen(selectValue, 4) + ':' + $('#savingEntryAmmount').val() + ':' + $('#savingSavingAmmount').val() + ':' + $('#savingPeriod').val())
			
			$("#mi-modal").modal('hide');
		});
		*/
		$("#modal-btn-no").on("click", function(){
			$("#mi-modal").modal('hide');
		});
	})

	function savingSuccess(){
		
		$('.modal-header').empty();
		let content = '';
		content += '<div>손님이 동의서 작성을 완료하였습니다. 가입을 진행하시겠습니까?</div>';
		
		$('.modal-header').append(content);
		
		$("#mi-modal").modal('show');
	
		
		$("#modal-btn-si").unbind("click");
		$("#modal-btn-si").bind("click",function(){
			
			$.ajax({
				url : '${pageContext.request.contextPath}/saving',
				type : 'post',
				data : {		
					
					regNo : '${clientVO.regNo}',
					nameCode : savingSigninProductName,
					savingAmmount : savingSigninEntryAmmount,
					plannedAmmount : savingSinginSavingAmmount,
					expiredDate : savingSigninPeriod,
					refAccountNo : savingSigninAccountNo 
					
				},
				success : function(data) {
					
					$('#workModal').empty();
					let content = '';
					content += '적금가입에 성공하였습니다.';
					$('#workModal').append(content);
					$("#modal").fadeIn();
					$('#workDiv').empty();
					$("#userSavingList").trigger("click");
					
				},error : function() {
					alert('실패');
				}
					
			})
			
			$("#mi-modal").modal('hide');
		})

		
		$("#modal-btn-no").bind("click",function(){
			
			$("#mi-modal").modal('hide');
		})
		
	}

</script>