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
		body {background-color: #fbf4e5}
	</style>
	<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
	<script>
		$(document).ready(function(){
			
		});
	</script>
</head>
<jsp:include page="../main/header.jsp"/>
<body>	
	<form action="${conPath }/FileBoardReply.do" method="post" enctype="multipart/form-data">
		<!-- reply.do시 필요한 원글 정보 : bGroup, bStep, bIndent
			                     지금 입력할 답변글 : bName, bTitle, bContent
			               			pageNum -->
		<input type="hidden" name="fgroup" value="${originBoard.fgroup }">
		<input type="hidden" name="fstep" value="${originBoard.fstep }">
		<input type="hidden" name="findent" value="${originBoard.findent }">
		<input type="hidden" name="pageNum" value="${param.pageNum }">
	    <div class="board_wrap">
	        <div class="board_title">
	            <strong>답변글</strong>
	            <p>번호 : <b>${originBoard.fno }</b> 에 대한<br>
	                                  답변글을 입력해주세요</p>
	        </div>
	        <div class="board_write_wrap">
	            <div class="board_write">
	                <div class="title">
	                    <dl>
	                        <dt>제목</dt>
	                        <dd>
	                        	<input type="text" name="ftitle" value="[답]${originBoard.ftitle }" required="required">
	                        </dd>
	                    </dl>
	                    
	                </div>
	                <div class="info">
	                    <dl>
	                        <dt>작성자</dt>
	                        <dd>						
	                        	<input type="text" required="required" 
	                        	value="<c:if test="${not empty student.sname }">[학생님] ${student.sname } (${student.sid})</c:if><c:if test="${not empty teacher.tname }">[선생님] ${teacher.tname } (${teacher.tid})</c:if>"
	                        			readonly="readonly">
							</dd>
	                    </dl>
	                    <dl>
	                        <dt>첨부파일</dt>
	                        <dd>
	                        	<input type="file" name="ffileName" class="btn"> 원첨부파일:
								<c:if test="${not empty originBoard.ffileName }">
							 		<a href="${conPath }/fileBoardUp/${originBoard.ffileName}" target="_blank">${originBoard.ffileName}</a>
							 	</c:if>
							 	<c:if test="${empty originBoard.ffileName }">
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
					<input type="submit" value="답변쓰기" class="on">
					<input type="reset" value="뒤로가기" onclick="history.back()">
					<input type="button" value="목록" 
						  onclick="location='${conPath}/FileBoardList.do?pageNum=${param.pageNum }'">
						  
	            </div>
	        </div>
	    </div>
	</form>	
</body>
<jsp:include page="../main/footer.jsp"/>
</html>