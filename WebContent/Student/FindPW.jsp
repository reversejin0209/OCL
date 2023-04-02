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
	<link href="${conPath}/css/login.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
	<script>
		$(document).ready(function(){
			
		});
	</script>
</head>
<style>
	.login-wrap{min-height:500px;}
</style>
<body>
<form method="post">
	<input type="hidden" name="next" value="${param.next }">
	<a href="${conPath }/main.do"><img src="${conPath }/img/nomalocl.png" alt="OCL마크"></a>
	<div class="login-wrap">
		<div class="login-html">
		    <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">비밀번호찾기</label>
		    <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">아이디찾기</label>
		    <div class="login-form">
		      <div class="sign-in-htm">
		        <div class="group">
		          <label for="user" class="label">찾으시는 분의 성함</label>
		          <input id="user" type="text" name="sname"  required="required" class="input">
		        </div>
		        <div class="group">
		          <label for="user" class="label">찾으시는 분의 이메일</label>
		          <input id="user" type="text" name="semail" class="input" required="required">
		        </div>
		        <div class="group">
		          <label for="user" class="label">찾으시는 분의 아이디</label>
		          <input id="user" type="text" name="sid" class="input" required="required">
		        </div>
		        <div class="group">
		          <input type="submit" class="button" value="비밀번호 찾기">
		          	<c:if test="${not empty student.spw}">
		          		<script>
							alert('찾으시는 비밀번는 ${student.spw}입니다');
						</script>
		          	</c:if>
		        </div>
		        <div class="group">
		          <input type="button" class="button" value="로그인 하러가기 "
		          	onclick="location.href='${conPath}/loginView.do'" >
		        </div>
		        <div class="hr"></div>
		      </div>
		    	<div class="sign-up-htm">
		        <div class="group">
		        <div class="group">
		          <input type="button" class="button" value="아이디 찾으러 가기" 
		          	onclick="location.href='${conPath}/findPW.do'">
		        </div>
		        <div class="hr"></div>
		      </div>
		    </div>
  		</div>
	</div>
</div>
</form>
</body>
</html>