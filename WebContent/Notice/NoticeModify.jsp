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
<form action="${conPath }/NoticeModify.do" method="post">
		<input type="hidden" name="pageNum" value="${param.pageNum }">
		<input type="hidden" name="nno" value="${Ndto.nno }">
	    <div class="board_wrap">
	        <div class="board_title">
	            <strong>공지수정 게시판</strong>
	            <p>번호 : <b>${Ndto.nno }</b> 에 대한<br>
	                                  공지사항을 수정해주세요</p>
	        </div>
	        <div class="board_write_wrap">
	            <div class="board_write">
	                <div class="title">
	                    <dl>
	                        <dt>제목</dt>
	                        <dd>
	                        	<input type="text" name="ntitle" value="${Ndto.ntitle }" required="required">
	                        </dd>
	                    </dl>
	                </div>
	                <div class="info">
	                    <dl>
	                        <dt>작성자</dt>
	                        <dd>	
	                        	<input type="text" name="tname" value="<c:if test="${not empty Ndto.tname }"> [선생님] ${Ndto.tname } (${Ndto.tid})
	                        	</c:if>"readonly="readonly"  required="required">
							</dd>
	                    </dl>
	                </div>
	                <div class="cont">
	                    <textarea name="ncontent" placeholder="내용 입력"></textarea>
	                </div>
	            </div>
	            <div class="bt_wrap">
					<input type="submit" value="수정" class="on">
					<input type="reset" value="이전" onclick="history.back()">
					<input type="button" value="목록" 
						  onclick="location='${conPath}/NoticeList.do?pageNum=${param.pageNum }'">
	            </div>
	        </div>
	    </div>
	</form>
</body>
<jsp:include page="../main/footer.jsp"/>
</html>