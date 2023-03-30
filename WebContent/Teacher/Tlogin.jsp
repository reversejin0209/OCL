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
	<style>
		body{background-color: #fbf4e5;}
	</style>
	<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
	<script>
		$(document).ready(function(){
			
		});
	</script>
</head>
<body>
	<c:if test="${not empty teacher }">
		<script>
			alert('이미 관리자 모드로 들어오셨습니다');
			location.href='${conPath }/allView.do';
		</script>
	</c:if>
	<c:if test="${not empty student }">
		<script>
			alert('사용자 주제에 떼끼'); 
			history.back();
		</script>
	</c:if>
<form action="${conPath }/teacherLogin.do" method="post">
	<input type="hidden" name="next" value="${param.next }">
	<a href="${conPath }/main.do"><img src="${conPath }/img/nomalocl.png" alt="OCL마크"></a>
	<div class="login-wrap">
		<div class="login-html">
		    <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">관리자 로그인</label>
		    <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">사용자 로그인</label>
		    <div class="login-form">
		      <div class="sign-in-htm">
		        <div class="group">
		          <label for="user" class="label">관리자 아이디</label>
		          <input id="user" type="text" name="tid"  required="required" class="input">
		        </div>
		        <div class="group">
		          <label for="pass" class="label">관리자 비밀번호</label>
		          <input id="pass" type="password" name="tpw" class="input" data-type="password" required="required">
		        </div>
		        <div class="group">
		          <input type="submit" class="button" value="로그인">
		        </div>
		        <div class="hr"></div>
		        <div class="foot-lnk">안녕하세요 관리자님</div>
		      </div>
		    	<div class="sign-up-htm">
		        <div class="group">
		          <input type="button" class="button" value="사용자시면 '이곳'을 눌러주세요"
		          	onclick="location.href='${conPath}/loginView.do'">
		        </div>
		        <div class="hr"></div>
		        <div class="foot-lnk"><a href = "${conPath }/teacherLoginView.do">
		        사용자가 아니라면 클릭!</a>
		        </div>
		      </div>
		    </div>
  			</div>
	</div>
</form>
</body>
</html>