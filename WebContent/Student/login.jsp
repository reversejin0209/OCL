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
</head>
<body>
	<c:if test="${not empty  joinResult}">
		<script>
			alert('${joinResult}');
		</script>
	</c:if>
	<c:if test="${not empty  joinErrorMsg}">
		<script>
			alert('${joinErrorMsg}');
			history.back();
		</script>
	</c:if>
	<c:if test="${not empty student and teacher}">
		<script>
			alert('이미 로그인 상태입니다');
			history.back();
		</script>
	</c:if>
<form action="${conPath }/login.do" method="post">
	<input type="hidden" name="next" value="${param.next }">
	<a href="${conPath }/main.do"><img src="${conPath }/img/nomalocl.png" alt="OCL마크"></a>
	<div class="login-wrap">
		<div class="login-html">
		    <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">사용자 로그인</label>
		    <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">관리자모드</label>
		    <div class="login-form">
		      <div class="sign-in-htm">
		        <div class="group">
		          <label for="user" class="label">아이디</label>
		          <input id="user" type="text" name="sid" value="${sid }" required="required" class="input">
		        </div>
		        <div class="group">
		          <label for="pass" class="label">비밀번호</label>
		          <input id="pass" type="password" name="spw" class="input" data-type="password" required="required">
		        </div>
		        <div class="group">
		          <input type="submit" class="button" value="로그인">
		        </div>
		        <div class="hr"></div>
		        <div class="foot-lnk">
		          <a href="${conPath }/joinView.do">아직 회원아 아니신가요?</a>
		        </div>
		      </div>
		    	<div class="sign-up-htm">
		        <div class="group">
		          <input type="button" class="button" value="관리자시면 '이곳'을 눌러주세요"
		          	onclick="location.href='${conPath}/teacherLoginView.do'">
		        </div>
		        <div class="hr"></div>
		        <div class="foot-lnk"><a href = "${conPath }/loginView.do">
		         관리자가 아니라면 클릭!</a>
		        </div>
		      </div>
		    </div>
  			</div>
	</div>
</form>
</body>
</html>