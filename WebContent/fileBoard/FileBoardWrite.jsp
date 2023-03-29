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
	<link href="${conPath}/css/css.css" rel="stylesheet">
	<style>
		body {background-color: #fbf4e5;}
	</style>
	<script>
		$(document).ready(function(){
	
		});
	</script>
	<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
</head>
<jsp:include page="../main/header.jsp"/>
<body>
	<c:if test="${empty student or teacher }">
		<script>
			location.href='${conPath}/logeinView.do?next=FileboardWriteView.do';
		</script>
	</c:if>
	<form action="${conPath }/FileBoardWrite.do" method="post" enctype="multipart/form-data">
	    <div class="board_wrap">
	        <div class="board_title">
	            <strong>학급게시판 글등록</strong>
	            <p>게시판 내용을 입력해주세요</p>
	        </div>
	        <div class="board_write_wrap">
	            <div class="board_write">
	                <div class="title">
	                    <dl>
	                        <dt>제목</dt>
	                        <dd>
	                        	<input type="text" name="ftitle" required="required" placeholder="제목 입력">
	                        </dd>
	                    </dl>
	                </div>
	                <div class="info">
	                    <dl>
	                        <dt>첨부파일</dt>
	                        <dd><input type="file" name="ffileName"></dd>
	                    </dl>
	                </div>
	                <div class="cont">
	                    <textarea name="fcontent" placeholder="내용 입력"></textarea>
	                </div>
	            </div>
	            <div class="bt_wrap">
	            	<input type="submit" value="글쓰기" class="on">
	            	<input type="reset" value="초기화">
	            	<input type="button" value="목록"
		            	onclick="location.href='${conPath}/FileBoardList.do'"
																FileBoardList>
	            </div>
	        </div>
	    </div>
	</form>
</body>
<jsp:include page="../main/footer.jsp"/>
</html>