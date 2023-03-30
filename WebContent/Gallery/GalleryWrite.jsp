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
	<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
</head>
<jsp:include page="../main/header.jsp"/>
<body> 
	<form action="${conPath }/GalleryWrite.do" method="post" enctype="multipart/form-data">
	    <div class="board_wrap">
	        <div class="board_title">
	            <strong>앨범 등록</strong>
	            <p>추억의 사진을 남겨주세요</p>
	        </div>
	        <div class="board_write_wrap">
	            <div class="board_write">
	                <div class="title">
	                    <dl>
	                        <dt>제목</dt>
	                        <dd>
	                        	<input type="text" name="gtitle" required="required" placeholder="제목 입력">
	                        </dd>
	                    </dl>
	                </div>
	                <div class="info">
	                    <dl>
	                        <dt>첨부파일</dt>
	                        <dd><input type="file" name="gfileName"></dd>
	                    </dl>
	                </div>
	                <div class="cont">
	                    <textarea name="gcontent" placeholder="간단한 설명을 적어주세요"></textarea>
	                </div>
	            </div>
	            <div class="bt_wrap">
	            	<input type="submit" value="글쓰기" class="on">
	            	<input type="reset" value="초기화">
	            	<input type="button" value="목록"
		            	onclick="location.href='${conPath}/Gallery.do'">
	            </div>
	        </div>
	    </div>
	</form>
</body>
<jsp:include page="../main/footer.jsp"/>
</html>