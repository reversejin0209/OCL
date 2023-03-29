<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="${conPath }/css/style.css" rel="stylesheet">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  	<c:if test="${not empty student }">
		<script>
			alert('이미 로그인 상태입니다');
			history.back();
		</script>
	</c:if>
  <script>
	var patternSpc = /[~`!@#$%^&*()-_+=|\\\[\]{};:?,.\/]/; // 특수문자패턴
	var patternNum = /[0-9]/; // 숫자 패턴
    var patternLower = /[a-z]/; // 소문자패턴
    var patternUpper = /[A-Z]/; // 대문자패턴    
  	$(function(){
  		$('input[name="sid"]').keyup(function(){
  			var sid = $(this).val();
  			if(sid.length<2){
  				$('#sidConfirmResult').text('아이디는 2글자 이상');
  			}else{
  				$.ajax({
  					url : '${conPath}/sidConfirm.do',
  					type : 'get',
  					data : 'sid='+sid,
  					dataType : 'html',
  					success : function(data){
  						$('#sidConfirmResult').html(data);
  					},
  				});// ajax함수
  			}//if
  		});// keyup event
  		
  		$('input[name="spw"], input[name="spwChk"]').keyup(function(){
  			var pw = $('input[name="spw"]').val();
  			var pwChk = $('input[name="spwChk"]').val();
  			if(pw == pwChk){
  				$('#spwChkResult').text('비밀번호 일치');
  			}else{
  				$('#spwChkResult').text('비밀번호 불일치');
  			}
  		});// keyup event(비밀번호 일치 확인용)
  		 
  		// macth함수 사용
  		var patternSemail = /^[a-zA-Z0-9_\.]+@[a-zA-Z0-9_]+(\.\w+){1,2}$/;
  		$('input[name="semail"]').keyup(function(){
  			let semail = $(this).val();
  			if(!semail){
  				$('#semailConfirmResult').html(' &nbsp; ');
  			}else if(!semail.match(patternSemail)){
  				$('#semailConfirmResult').html('<b>메일 형식을 지켜 주세요</b>');
  			}else{
  				$.ajax({
  					url : '${conPath}/semailConfirm.do',
  					type : 'get',
  					data : 'semail='+semail,
  					dataType : 'html',
  					success : function(data){
  						$('#semailConfirmResult').html(data);
  					},
  				});
  			}
  		});
  		
  		$('form').submit(function(){
  		// "사용 가능한 ID입니다"(#idConfirmResult), "비밀번호 일치(#pwChkResult)"가 출력되었을 경우만 submit 가능
			var sidConfirmResult = $('#sidConfirmResult').text().trim();
  			var spwChkResult = $('#spwChkResult').text().trim();
  			var semailConfirmResult = $('#semailConfirmResult').text().trim();
  			if(sidConfirmResult != '사용 가능한 ID'){
  				alert('사용 가능한 ID인지 확인 요망');
  				$('input[name="sid"]').focus();
  				return false; // submit 제한
  			}else if(spwChkResult != '비밀번호 일치'){
  				alert('비밀번호를 확인하세요');
  				$('input[name="spw"]').focus();
  				return false;
  			}else if(semailConfirmResult != '사용 가능한 메일' && semailConfirmResult!= ''){
  				alert('메일을 확인하세요');
  				$('input[name="semail"]').focus();
  				return false;
  			}
  		});
  	});
  </script>
  <script>
  $( function() {
    $( "#datepicker" ).datepicker({
    	dateFormat: "yy-mm-dd",
    	monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    	dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
    	changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
    	changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
    	showMonthAfterYear: true,
    	yearSuffix: '년',
    	showOtherMonths: true, // 현재 달이 아닌 달의 날짜도 회색으로 표시
    	//minDate: '-100y',	 // 현재날짜로부터 100년이전까지 년을 표시한다.
    	minDate: new Date(1950, 1 - 1, 1), // 1950년 1월1일을 최소 날짜로 세팅
    	maxDate : 'y', // 현재 날짜 이전만 선택 가능
    	yearRange: 'c-100:c+10', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 
    });
  } );
  </script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content_form">
		<form action="${conPath }/join.do" method="post" enctype="multipart/form-data">
			<table>
				<caption>회원가입</caption>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="sid" required="required" autofocus="autofocus">
						<div id="sidConfirmResult"> &nbsp; </div>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="spw" required="required"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="spwChk" required="required">
						<div id="spwChkResult"> &nbsp; </div>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="sname" required="required"></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input type="text" name="snumber"></td>
				</tr>
				<tr>
					<th>생년월일</th><td><input type="text" name="sbirth" id="datepicker"></td>
				</tr>
				<tr>
					<th>메일</th>
					<td>
						<input type="text" name="semail">
						<div id="semailConfirmResult"> &nbsp; </div>
					</td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						<input type="radio" name="sgender" value="m">남
						<input type="radio" name="sgender" value="f">여
					</td>
				</tr>
				<tr>
					<th>사진</th>
					<td><input type="file" name="sphoto"></td>
				</tr>
				<tr>
					<th>주소</th><td><input type="text" name="saddress"></td>
				</tr>
				<tr>
					<td colspan="2">
						<p>
							<input type="submit" value="회원가입" class="btn">
							<input type="button" value="로그인" class="btn" onclick="location='${conPath}/loginView.do'">
						</p>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>
</head>
<body>
	
</body>
</html>