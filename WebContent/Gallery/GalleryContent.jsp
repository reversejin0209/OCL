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
	<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
	<script>
		$(document).ready(function(){
			
		});
	</script>
</head>
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
	<c:if test="${ empty student and empty teacher}">
	<script>
		alert('해당 페이지의 권한이 없습니다');
		location.href='${conPath}/main.do';
	</script>
</c:if>
</head>
<jsp:include page="../main/header.jsp"/>
<body>
    <div class="board_wrap">
        <div class="board_title">
            <strong>학급앨범</strong>
        </div>
        <div class="board_view_wrap">
            <div class="board_view">
                <div class="title">
                  	${GalleryCt.gtitle }
                </div>
                <div class="info">
                    <dl>
                        <dt>번호</dt>
                        <dd>${GalleryCt.gno }</dd>
                    </dl>
                    <dl>
                        <dt>글쓴이</dt>
                        <dd>
	                        <c:if test="${not empty GalleryCt.sname }">
								[학생님] ${GalleryCt.sname }
							</c:if>
							<c:if test="${not empty GalleryCt.tname  }">
								[선생님] ${GalleryCt.tname }
							</c:if>
						</dd>
                    </dl>
                    <dl>
                    	<dt>파일명</dt>
                    	<dd>
                    		<c:if test="${not empty GalleryCt.gfileName }">
                    			<a href="${conPath }/GalleryBoardUp/${GalleryCt.gfileName}" target="_blank">${GalleryCt.gfileName}</a>
                    		</c:if>
                    		<c:if test="${empty GalleryCt.gfileName }">
                    			첨부파일없음
                    		</c:if>
                    	</dd>
                    </dl>
                    <dl>
                        <dt>작성일</dt>
                        <dd><div class="date"><fmt:formatDate value="${GalleryCt.grdate }" type="date"/></div></dd>
                    </dl>
                    <dl>
                        <dt>조회</dt>
                        <dd>${GalleryCt.ghit }</dd>
                    </dl>
                </div>
                <div class="cont">
					<c:if test="${not empty GalleryCt.gfileName }">
							<a href="${conPath }/GalleryBoardUp/${GalleryCt.gfileName}" target="_blank">${GalleryCt.gfileName}</a>
							<br>${GalleryCt.gcontent }
					</c:if>
					<c:if test="${empty GalleryCt.gfileName }">
						<div>${GalleryCt.gcontent }</div>
					</c:if>
                </div>
                </div>
            </div>
            <div class="bt_wrap">
 				<c:if test="${not empty teacher and empty student}">
					<button onclick="location='${conPath}/GalleryModifyView.do?gno=${GalleryCt.gno }&pageNum=${param.pageNum }'">수정</button>
				</c:if>
				<c:if test="${not empty teacher and empty student}">
					<button onclick="location='${conPath}/GalleryDelete.do?gno=${GalleryCt.gno }&pageNum=${param.pageNum }'">삭제</button>
				</c:if>
				 <button onclick="location='${conPath}/GalleryList.do?pageNum=${param.pageNum }'">목록</button>
            </div>
        </div>	
</body>
<jsp:include page="../main/footer.jsp"/>
</html>