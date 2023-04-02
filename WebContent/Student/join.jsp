<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="conPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${conPath }/css/login.css" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<style>
	.login-wrap{min-height:700px;}
</style>
<c:if test="${not empty student or not empty teacher}">\
	<script>
		alert('이미 로그인 상태입니다');
		history.back();
	</script>
</c:if>
<script>
	$(function() {
		$('input[name="sid"]').keyup(function() {
			var sid = $(this).val();
			if (sid.length < 2) {
				$('#sidConfirmResult').text('아이디는 2글자 이상');
			} else {
				$.ajax({
					url : '${conPath}/sidConfirm.do',
					type : 'get',
					data : 'sid=' + sid,
					dataType : 'html',
					success : function(data) {
						$('#sidConfirmResult').html(data);
					},
				});// ajax함수
			}//if
		});// keyup event

		$('input[name="spw"], input[name="spwChk"]').keyup(function() {
			var pw = $('input[name="spw"]').val();
			var pwChk = $('input[name="spwChk"]').val();
			if (pw == pwChk) {
				$('#spwChkResult').text('비밀번호 일치');
			} else {
				$('#spwChkResult').text('비밀번호 불일치');
			}
		});// keyup event(비밀번호 일치 확인용)

		// macth함수 사용
		var patternSemail = /^[a-zA-Z0-9_\.]+@[a-zA-Z0-9_]+(\.\w+){1,2}$/;
		$('input[name="semail"]').keyup(function() {
			let semail = $(this).val();
			if (!semail) {
				$('#semailConfirmResult').html(' &nbsp; ');
			} else if (!semail.match(patternSemail)) {
				$('#semailConfirmResult').html('<b>메일 형식을 지켜 주세요</b>');
			} else {
				$.ajax({
					url : '${conPath}/semailConfirm.do',
					type : 'get',
					data : 'semail=' + semail,
					dataType : 'html',
					success : function(data) {
						$('#semailConfirmResult').html(data);
					},
				});
			}
		});

		$('form')
				.submit(
						function() {
							// "사용 가능한 ID입니다"(#idConfirmResult), "비밀번호 일치(#pwChkResult)"가 출력되었을 경우만 submit 가능
							var sidConfirmResult = $('#sidConfirmResult')
									.text().trim();
							var spwChkResult = $('#spwChkResult').text().trim();
							var semailConfirmResult = $('#semailConfirmResult')
									.text().trim();
							if (sidConfirmResult != '사용 가능한 ID') {
								alert('사용 가능한 ID인지 확인 요망');
								$('input[name="sid"]').focus();
								return false; // submit 제한
							} else if (spwChkResult != '비밀번호 일치') {
								alert('비밀번호를 확인하세요');
								$('input[name="spw"]').focus();
								return false;
							} else if (semailConfirmResult != '사용 가능한 메일'
									&& semailConfirmResult != '') {
								alert('메일을 확인하세요');
								$('input[name="semail"]').focus();
								return false;
							}
						});
	});
</script>
<script>
	$(function() {
		$("#datepicker").datepicker(
				{
					dateFormat : "yy-mm-dd",	
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
					changeMonth : true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
					changeYear : true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
					showMonthAfterYear : true,
					yearSuffix : '년',
					showOtherMonths : true, // 현재 달이 아닌 달의 날짜도 회색으로 표시
					//minDate: '-100y',	 // 현재날짜로부터 100년이전까지 년을 표시한다.
					minDate : new Date(1950, 1 - 1, 1), // 1950년 1월1일을 최소 날짜로 세팅
					maxDate : 'y', // 현재 날짜 이전만 선택 가능
					yearRange : 'c-100:c+10', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 
				});
	});
</script>
</head>
<body>
	<form action="${conPath }/join.do" method="post"
		enctype="multipart/form-data">
		<input type="hidden" name="next" value="${param.next }"> <a
			href="${conPath }/main.do"><img
			src="${conPath }/img/nomalocl.png" alt="OCL마크"></a>
		<div class="login-wrap">
			<div class="login-html">
				<input id="tab-1" type="radio" name="tab" class="sign-in" checked><label
					for="tab-1" class="tab">회원가입정보(1)</label> <input id="tab-2"
					type="radio" name="tab" class="sign-up"><label for="tab-2"
					class="tab">회원가입정보(2)</label>
				<div class="login-form">
					<div class="sign-in-htm">
						<div class="group">
							<label for="user" class="label">아이디</label> 
								<input id="user" type="text" name="sid" value="${sid }" required="required"
											class="input" autofocus="autofocus">
								<div id="sidConfirmResult">&nbsp;</div>
						</div>
						<div class="group">
							<label for="pass" class="label">비밀번호</label> 
								<input id="pass" type="password" name="spw" class="input" 
										data-type="password" required="required">
						</div>
						<div class="group">
							<label for="pass" class="label">비밀번호 확인</label>
								<input id="pass" type="password" name="spwChk" class="input" 
										data-type="password" required="required">
								<div id="spwChkResult">&nbsp;</div></td>
						</div>
						<div class="group">
							<label for="user" class="label">이름</label> 
								<input id="pass" type="text" name="sname" class="input" required="required">
						</div>
						<div class="group">
							<label for="user" class="label">전화번호</label> 
							<input id="user" type="text" name="snumber" class="input" required="required">
						</div>
						<div class="group">
							<input type="button" class="button" value="가입정보(2를)눌러주세요">
						</div>
						<div class="hr"></div>
						<div class="foot-lnk">
							<a href="${conPath }/loginView.do">이미 회원이신가요 ?</a>
						</div>
					</div>
					<div class="sign-up-htm">
						<div class="group"> 
							<label for="user" class="label">생년월일</label> 
								<input id="datepicker" type="text" name="sbirth" class="input" >
						</div>
						<div class="group">
							<label for="user" class="label">메일</label> 
								<input id="user"type="text" name="semail" class="input">
								<div id="semailConfirmResult">&nbsp;</div>
						</div>
						<div class="group">
							<label for="user" class="label">성별</label> 
								<input type="radio" name="sgender" value="m">남 
								<input type="radio" name="sgender" value="f">여</td>
						</div>
						<div class="group">
							<label for="user" class="label">사진</label> 
								<input id="user" type="file" name="sphoto" class="input">
						</div>
						<div class="group">
							<label for="user" class="label">주소</label> 
							<input id="user" type="text" name="saddress" class="input">
						</div>
						<div class="group">
							<input type="submit" class="button" value="회원가입">
						</div>
						<div class="hr"></div>
						<div class="foot-lnk">
							<a href="${conPath }/teacherLoginView.do"> 관리자이시면 '여기'를 눌러주세요 </a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</head>
</html>