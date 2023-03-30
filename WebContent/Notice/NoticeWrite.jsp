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
	<link href="${conPath }/css/css.css" rel="stylesheet">
	<style>
		body{background-color: #fbf4e5;}
	</style>
	<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
</head>
<jsp:include page="../main/header.jsp"/>
<body>
<%-- <c:if test="${empty student or empty teacher }">
		<script>
			location.href='${conPath}/logeinView.do?next=NoticeWriteView.do';
		</script>
	</c:if> --%>
	<form action="${conPath }/NoticeWrite.do" method="post">
	    <div class="board_wrap">
	        <div class="board_title">
	            <strong>공지사항 등록</strong>
	            <p>공지하실 내용을 입력해주세요</p>
	        </div>
	        <div class="board_write_wrap">
	            <div class="board_write">
	                <div class="title">
	                    <dl>
	                        <dt>제목</dt>
	                        <dd>
	                        	<input type="text" name="ntitle" required="required" value="[월일()알림장]">
	                        </dd>
	                    </dl>
	                </div>
	                <div class="cont">
	                    <textarea name="ncontent" placeholder="내용 입력" ></textarea>
	                </div>
	            </div>
	            <div class="bt_wrap">
	            	<input type="submit" value="알림장등록" class="on">
	            	<input type="reset" value="다시쓰기">
	            	<input type="button" value="목록으로"
		            	onclick="location.href='${conPath}/NoticeList.do'"
																NoticeList>
	            </div>
	        </div>
	    </div>
	</form>
</body>
<jsp:include page="../main/footer.jsp"/>
</html>