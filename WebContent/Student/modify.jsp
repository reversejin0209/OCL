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
	<link href="${conPath }/css/login.css" rel="stylesheet">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script>
  	$(function(){
  		var patternSemail = /^[a-zA-Z0-9_\.]+@[a-zA-Z0-9_]+(\.\w+){1,2}$/;
  		$('input[name="semail"]').keyup(function(){
  			let semail = $(this).val();
  			if( (!semail) || (semail == '${student.semail}')){
  				$('#semailConfirmResult').html(' &nbsp; ');
  			}else if(patternSemail.test(semail)){
  				$.ajax({
  					url : '${conPath}/semailConfirm.do',
  					type : 'get',
  					data : 'semail='+semail,
  					dataType : 'html',
  					success : function(data){
  						$('#semailConfirmResult').html(data);
  					},
  				});
  			}else if(!patternSemail.test(semail)){
  				$('#semailConfirmResult').html('<b>메일 형식을 지켜 주세요</b>');
  			}
  		});
  		
  		$('form').submit(function(){
  			var oldSpw = $('input[name="oldSpw"]').val();
  			var semailConfirmResult = $('#semailConfirmResult').text().trim();
  			if(oldSpw != '${student.spw}'){
  				alert('현비밀번호를 확인하세요');
  				$('input[name="oldSpw"]').focus();
  				return false; // submit 제한
  			}else if( (semailConfirmResult =='메일 형식을 지켜 주세요') || 
  								(semailConfirmResult == '사용 불가한 중복된 메일')){
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
<style>
	.login-wrap{min-height:700px;}
</style>
</head>
<body>
<c:if test="${empty student }">
	<script>location.href='${conPath}/loginView.do?next=modifyView.do';</script>
</c:if>
	<form action="${conPath }/modify.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="dbSpw" value="${student.spw }">
		<input type="hidden" name="dbSphoto" value="${student.sphoto }">
 <a href="${conPath }/main.do"><img src="${conPath }/img/nomalocl.png" alt="OCL마크"></a>
		<div class="login-wrap">
			<div class="login-html">
				<input id="tab-1" type="radio" name="tab" class="sign-in" checked><label
					for="tab-1" class="tab">회원정보수정(1)</label> <input id="tab-2"
					type="radio" name="tab" class="sign-up"><label for="tab-2"
					class="tab">회원정보수정(2)</label>
				<div class="login-form">
					<div class="sign-in-htm">
						<div class="group">
							<label for="user" class="label">아이디</label> 
								<input type="text" id="user" class="input" name="sid" value="${student.sid }" 
								readonly="readonly" size="3">
							<label for="user" class="label">사진</label> 
								<img src="${conPath }/studentPhotoUp/${student.sphoto}" alt="${student.sname }사진">
						</div>
						<div class="group">
							<label for="pass" class="label">현비밀번호</label> 
								<input id="pass" type="password" name="oldSpw" class="input" data-type="password">
						</div>
						<div class="group">
							<label for="pass" class="label">새비밀번호</label>
								<input id="pass" type="password" name="spw" class="input" 
										data-type="password" >
						</div>
						<div class="group">
							<label for="user" class="label">이름</label> 
							<input id="user" type="text" name="sname" class="input" required="required" value="${student.sname }" >
						</div>
						<div class="group">
							<label for="user" class="label">전화번호</label> 
							<input id="user" type="text" name="snumber" class="input"  value="${student.snumber }">
						</div>
						<div class="group">
							<input type="button" class="button" value="정보수정(2를)눌러주세요">
						</div>
						<div class="hr"></div>
					</div>
					<div class="sign-up-htm">
						<div class="group"> 
							<label for="user" class="label">생년월일</label> 
								<input id="datepicker" type="text" name="sbirth" class="input" 
										value="${student.sbirth }">
						</div>
						<div class="group">
							<label for="user" class="label">메일</label> 
								<input id="user"type="text" name="semail" class="input" value="${student.semail }">
								<div id="semailConfirmResult">&nbsp;</div>
						</div>
						<div class="group">
							<label for="user" class="label">성별</label> 
								<input type="radio" name="sgender" value="m" value="${student.sgender }">남 
								<input type="radio" name="sgender" value="f" value="${student.sgender }">여
						</div>
						<div class="group">
							<label for="user" class="label">사진</label> 
								<input id="user" type="file" name="sphoto" class="input">
						</div>
						<div class="group">
							<label for="user" class="label">주소</label> 
							<input id="user" type="text" name="saddress" class="input" value="${student.saddress }">
						</div>
						<div class="group">
							<input type="submit" class="button" value="수정완료">
						</div>
						<div class="hr"></div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>