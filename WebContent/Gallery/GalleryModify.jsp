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
	<form action="${conPath }/GalleryModify.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="pageNum" value="${param.pageNum }">
		<input type="hidden" name="gno" value="${Gallery.gno }">
		<input type="hidden" name="dbGfileName" value="${Gallery.gfileName }">
	    <div class="board_wrap">
	        <div class="board_title">
	            <strong>학급앨범</strong>
	            <p>번호 : <b>${Gallery.gno }</b> 에 대한<br>
	                                  수정할 정보를 입력해주세요</p>
	        </div>
	        <div class="board_write_wrap">
	            <div class="board_write">
	                <div class="title">
	                    <dl>
	                        <dt>제목</dt>
	                        <dd>
	                        	<input type="text" name="gtitle" value="${Gallery.gtitle }" required="required">
	                        </dd>
	                    </dl>
	                </div>
	                <div class="info">
	                    <dl>
	                        <dt>작성자</dt>
	                        <dd>						
	                        	<input type="text" required="required"
									value="<c:if test="${not empty Gallery.tname }">[선생님] ${Gallery.tname } (${Gallery.tid})</c:if>
											<c:if test="${not empty Gallery.sname }">[학생님] ${Gallery.sname } (${Gallery.sid})</c:if>
											"readonly="readonly">
							</dd>
	                    </dl>
	                    <dl>
	                        <dt>첨부파일</dt>
	                        <dd>
	                        	<input type="file" name="gfileName" class="btn"> 원첨부파일:
								<c:if test="${not empty Gallery.gfileName }">
							 		<a href="${conPath }/fileBoardUp/${Gallery.gfileName}" target="_blank">${Gallery.gfileName}</a>
							 	</c:if>
							 	<c:if test="${empty Gallery.gfileName }">
							 		첨부파일없음
							 	</c:if>
							 </dd>
	                    </dl>

	                </div>
	                <div class="cont">
	                    <textarea name="gcontent" placeholder="내용 입력"></textarea>
	                </div>
	            </div>
	            <div class="bt_wrap">
					<input type="submit" value="수정" class="on">
					<input type="reset" value="이전" onclick="history.back()">
					<input type="button" value="목록" 
						  onclick="location='${conPath}/GalleryList.do?pageNum=${param.pageNum }'">
	            </div>
	        </div>
	    </div>
	</form>	
</body>
<jsp:include page="../main/footer.jsp"/>
</html>