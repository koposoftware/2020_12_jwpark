<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

	$(document).on('click', "#checkCardBtn", function() {
		$('#workSpace').empty();
		$('#workDiv').empty();
		
		let content = '';
		
		$('#workTitle').text('체크 카드 상담')
		//content += '<div id="workName">예금 목록</div>';
		content += '<div id="workSpace" style="text-align:left">';
		content += '<div style="font-size : x-large">체크카드 안내  </div>';
		content += 	'<button class="btn btn-info" id="showcheckCardLink">체크카드 안내 링크</button>';
		content += '</div>';
		$('#workDiv').append(content);
		
	})
		
	$(document).on('click', "#showcheckCardLink", function() {

		var openNewWindow = window.open("about:blank");
		openNewWindow.location.href = "https://www.hanacard.co.kr/OPI31000000D.web?schID=pcd&mID=OPI31000005P&CT_ID=241704050328506";
	})
	
	$(document).on('click', "#creditCardBtn", function() {
		
		$('#workSpace').empty();
		$('#workDiv').empty();
		
		let content = '';
		
		$('#workTitle').text('신용 카드 상담')
		//content += '<div id="workName">예금 목록</div>';
		content += '<div id="workSpace" style="text-align:left">';
		content += '<div style="font-size : x-large">신용카드 안내 </div>';
		content += 		'<button class="btn btn-info" id="showCreditCardLink">신용카드 안내 링크</button>';
		content += '</div>';
		$('#workDiv').append(content);
		
	})
		
	$(document).on('click', "#showCreditCardLink", function() {

		var openNewWindow = window.open("about:blank");
		openNewWindow.location.href = "https://www.hanacard.co.kr/OPI31000000D.web?schID=pcd&mID=OPI31000005P&CT_ID=241704030444153";
	})
	
	$(document).on('click', "#loanBtn", function() {
		$('#workSpace').empty();
		$('#workDiv').empty();
		
		let content = '';
		
		$('#workTitle').text('대출 상담')
		//content += '<div id="workName">예금 목록</div>';
		content += '<div id="workSpace" style="text-align:left">';
		content += '<div style="font-size : x-large">대출 안내  </div>';
		content += 	'<button class="btn btn-info" id="loanLink">대출 안내 링크</button>';
		content += '</div>';
		$('#workDiv').append(content);
		
	})
		
	$(document).on('click', "#loanLink", function() {

		var openNewWindow = window.open("about:blank");
		openNewWindow.location.href = "https://www.kebhana.com/cont/mall/mall08/mall0805/index.jsp?catId=spb_2821,spb_2822,spb_2823,spb_2824,spb_2825,spb_2826&_menuNo=98786";
	})
	
	$(document).on('click', "#fundBtn", function() {
		$('#workSpace').empty();
		$('#workDiv').empty();
		
		let content = '';
		
		$('#workTitle').text('펀드 상담')
		//content += '<div id="workName">예금 목록</div>';
		content += '<div id="workSpace" style="text-align:left">';
		content += '<div style="font-size : x-large">펀드 안내  </div>';
		content += 	'<button class="btn btn-info" id="fundLink">펀드 안내 링크</button>';
		content += '</div>';
		$('#workDiv').append(content);
		
	})
		
	$(document).on('click', "#fundLink", function() {

		var openNewWindow = window.open("about:blank");
		openNewWindow.location.href = "https://www.kebhana.com/cont/mall/mall26/mall2602/index.jsp?_menuNo=62634";
	})
	
	$(document).on('click', "#insuranceBtn", function() {
		$('#workSpace').empty();
		$('#workDiv').empty();
		
		let content = '';
		
		$('#workTitle').text('방카슈랑스 상담')
		//content += '<div id="workName">예금 목록</div>';
		content += '<div id="workSpace" style="text-align:left">';
		content += '<div style="font-size : x-large">펀드 안내  </div>';
		content += 	'<button class="btn btn-info" id="insuranceLink">방카슈랑스 안내 링크</button>';
		content += '</div>';
		$('#workDiv').append(content);
		
	})
		
	$(document).on('click', "#insuranceLink", function() {

		var openNewWindow = window.open("about:blank");
		openNewWindow.location.href = "https://www.kebhana.com/cont/mall/mall08/mall0805/index.jsp?insSch=insAllSch&_menuNo=99073";
	})
</script>