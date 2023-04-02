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
	<form action="${conPath }/FileBoardModify.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="pageNum" value="${param.pageNum }">
		<input type="hidden" name="fno" value="${FileBoard.fno }">
		<input type="hidden" name="dbFileName" value="${FileBoard.ffileName }">
	    <div class="board_wrap">
	        <div class="board_title">
	            <strong>글수정 게시판</strong>
	            <p>번호 : <b>${FileBoard.fno }</b> 에 대한<br>
	                                  수정할 정보를 입력해주세요</p>
	        </div>
	        <div class="board_write_wrap">
	            <div class="board_write">
	                <div class="title">
	                    <dl>
	                        <dt>제목</dt>
	                        <dd>
	                        	<input type="text" name="ftitle" value="${FileBoard.ftitle }" required="required">
	                        </dd>
	                    </dl>
	                </div>
	                <div class="info">
	                    <dl>
	                        <dt>작성자</dt>
	                        <dd>						
	                        	<input type="text" required="required"
								value="<c:if test="${not empty FileBoard.sname }">[학생님] ${FileBoard.sname } (${FileBoard.sid})</c:if>
										<c:if test="${not empty FileBoard.tname }">[선생님] ${FileBoard.tname } (${FileBoard.tid})</c:if>
										"readonly="readonly">
							</dd>
	                    </dl>
	                    <dl>
	                        <dt>첨부파일</dt>
	                        <dd>
	                        	<input type="file" name="ffileName" class="btn"> 원첨부파일:
								<c:if test="${not empty FileBoard.ffileName }">
							 		<a href="${conPath }/fileBoardUp/${FileBoard.ffileName}" target="_blank">${FileBoard.ffileName}</a>
							 	</c:if>
							 	<c:if test="${empty FileBoard.ffileName }">
							 		첨부파일없음
							 	</c:if>
							 </dd>
	                    </dl>

	                </div>
	                <div class="cont">
	                    <textarea name="fcontent" placeholder="내용 입력"></textarea>
	                </div>
	            </div>
	            <div class="bt_wrap">
					<input type="submit" value="수정" class="on">
					<input type="reset" value="이전" onclick="history.back()">
					<input type="button" value="목록" 
						  onclick="location='${conPath}/FileBoardList.do?pageNum=${param.pageNum }'">
	            </div>
	        </div>
	    </div>
	</form>	
</body>
<jsp:include page="../main/footer.jsp"/>
</html>