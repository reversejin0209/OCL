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
	<script>
		$(document).ready(function(){
			
		});
	</script>
</head>
<jsp:include page="../main/header.jsp"/>
<body>

    <div class="board_wrap">
        <div class="board_title">
            <strong>공지사항</strong>
            <p>공지사항을 빠르고 정확하게 안내해드립니다.</p>
        </div>
        <input type="hidden" name="FileBoard" value="${FileBoard }">
        <div class="board_view_wrap">
            <div class="board_view">
                <div class="title">
                  	${FileBoard.ftitle }
                </div>
                <div class="info">
                    <dl>
                        <dt>번호</dt>
                        <dd>${FileBoard.fno }</dd>
                    </dl>
                    <dl>
                        <dt>글쓴이</dt>
                        <dd>
	                        <c:if test="${not empty FileBoard.sname }">
								[학생님] ${FileBoard.sname }
							</c:if>
							<c:if test="${not empty FileBoard.tname  }">
								[선생님] ${FileBoard.tname }
							</c:if>
						</dd>
                    </dl>
                    <dl>
                    	<dt>파일명</dt>
                    	<dd>
                    		<c:if test="${not empty FileBoard.ffileName }">
                    			<a href="${conPath }/fileBoardUp/${FileBoard.ffileName}" target="_blank">${FileBoard.ffileName}</a>
                    		</c:if>
                    		<c:if test="${empty FileBoard.ffileName }">
                    			첨부파일없음
                    		</c:if>
                    	</dd>
                    </dl>
                    <dl>
                        <dt>작성일</dt>
                        <dd><div class="date"><fmt:formatDate value="${FileBoard.frdate }" type="date"/></div></dd>
                    </dl>
                    <dl>
                        <dt>조회</dt>
                        <dd>${FileBoard.fhit }</dd>
                    </dl>
                </div>
                <div class="cont">
					<c:if test="${not empty FileBoard.ffileName }">
							<a href="${conPath }/fileBoardUp/${FileBoard.ffileName}" target="_blank">${FileBoard.ffileName}</a>
							<br>${FileBoard.fcontent }
					</c:if>
					<c:if test="${empty FileBoard.ffileName }">
						<div>${FileBoard.fcontent }</div>
					</c:if>
                </div>
                </div>
            </div>
            <div class="bt_wrap">
 				<c:if test="${student.sid eq FileBoard.sid or not empty teacher}">
					<button onclick="location='${conPath}/FileBoardModifyView.do?fno=${FileBoard.fno }&pageNum=${param.pageNum }'">수정</button>
				</c:if>
				<c:if test="${student.sid eq FileBoard.sid or not empty teacher}">
					<button onclick="location='${conPath}/FileBoardDelete.do?fgroup=${FileBoard.fgroup }&fstep=${FileBoard.fstep }&findent=${FileBoard.findent }'">삭제</button>
				</c:if>
				<c:if test="${not empty student or teacher}">
				 	<button onclick="location='${conPath}/FileBoardReplyView.do?fno=${FileBoard.fno }&pageNum=${param.pageNum }'">답변</button>
				 </c:if>
				 <button onclick="location='${conPath}/FileBoardList.do?pageNum=${param.pageNum }'">목록</button>
            </div>
        </div>	
</body>
<jsp:include page="../main/footer.jsp"/>
</html>