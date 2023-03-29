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
	<style>
		#content_form {
				height:400px; 
				margin: 20px auto 80px;
		}
	</style>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script>
  	$(function(){
  		// macth함수 사용
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
  			// 현비밀번호확인과 사용불가한 중복된 메일일 경우 submit 제한
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
</head>
<body>
	<c:if test="${empty student }">
		<script>location.href='${conPath}/loginView.do?next=modifyView.do';</script>
	</c:if>
	<jsp:include page="../main/header.jsp"/>
	<div id="content_form">
		<form action="${conPath }/modify.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="dbSpw" value="${student.spw }">
			<input type="hidden" name="dbSphoto" value="${student.sphoto }">
			<table>
				<caption>정보수정</caption>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="sid" value="${student.sid }" readonly="readonly" size="3">
					</td>
					<td rowspan="4">
						<img src="${conPath }/studentPhotoUp/${student.sphoto}"
								 alt="${student.sname }사진">
					</td>
				</tr>
				<tr>
					<th>현비밀번호</th>
					<td>
						<input type="password" name="oldSpw">
					 </td>
				</tr>
				<tr>
					<th>새비밀번호</th>
					<td><input type="password" name="spw" size="3"></td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name="sname" value="${student.sname }" required="required" size="3">
					</td>
				</tr>
				<tr>
					<th>메일</th>
					<td colspan="2">
						<input type="email" name="semail" value="${student.semail }">
						<div id="semailConfirmResult"> &nbsp; </div>
					</td>
				</tr>
				<tr>
					<th>사진</th>
					<td colspan="2">
						<input type="file" name="sphoto">
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td colspan="2">
						<input type="text" name="sbirth" value="${student.sbirth }"
							id="datepicker">
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="2">
						<input type="text" name="saddress" value="${student.saddress }">
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<input type="submit" value="정보수정" class="btn">
						<input type="reset" value="초기화" class="btn">
						<input type="reset" value="이전" onclick="history.back()" class="btn">
						<input type="button" value="회원탈퇴" class="btn"
							onclick="location.href='${conPath}/withdrawal.do'">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
<jsp:include page="../main/footer.jsp"/>
</html>
