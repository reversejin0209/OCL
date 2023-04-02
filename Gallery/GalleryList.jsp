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
<c:if test= "${empty pageNum}">
	<script>
		location.href='${conPath}/Gallery/GalleryList.jsp';
	</script>
</c:if>
<c:if test="${ empty student and empty teacher}">
	<script>
		alert('해당 페이지의 권한이 없습니다');
		location.href='${conPath}/main.do';
	</script>
</c:if>
<jsp:include page="../main/header.jsp"/>
<body>
	<c:if test="${not empty GalleryResult }">
		<script>alert('${GalleryResult}');</script>
	</c:if>
<div class="board_wrap">
        <div class="board_title">
            <strong>학급앨범</strong>
        </div>
        <div class="board_list_wrap">
            <div class="board_list">
                <div class="top">
                    <div class="num">번호</div>
                    <div class="title">제목</div>
                    <div class="writer">글쓴이</div>
                    <div class="date">작성일</div>
                    <div class="count">조회</div>
                </div>
                <c:if test="${totCnt==0 }"></c:if>
                <c:if test="${totCnt!=0 }">
                <div>
					<c:forEach items="${Gallery }" var="Gallery">
						<div class="num">${Gallery.gno }</div>
						<div class="title" id="left">
							<a href="${conPath}/GalleryContent.do?gno=${Gallery.gno }&pageNum=${pageNum}">${Gallery.gtitle }</a>
						</div>
	                    <div class="writer">${Gallery.tname}</div>
	                    <div class="date"><fmt:formatDate value="${Gallery.grdate }" type="date" /></div>
	                    <div class="count">${Gallery.ghit }</div>
					</c:forEach>
                </div>
                </c:if>
            </div>
            <div class="paging">
            <c:if test="${startPage > BLOCKSIZE }">
                <a href="${conPath }/GalleryList.do?pageNum=${startPage-1}" class="bt">이전</a>
            </c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage }">
				<c:if test="${i == pageNum }">
					<a class="num on">  ${i }  </a>
				</c:if>
				<c:if test="${i != pageNum }">
					[ <a href="${conPath }/GalleryList.do?pageNum=${i}" class="num"> ${i } </a> ]
				</c:if>
			</c:forEach>
			<c:if test="${endPage<pageCnt }">
			   <a href="${conPath }/GalleryList.do?pageNum=${endPage+1}" class="bt">다음</a>
			</c:if>
            <c:if test="${not empty teacher }">
            <div class="bt_wrap">
                <a href="${conPath }/GalleryWriteView.do" class="on">글쓰기</a>
                <!--<a href="#">수정</a>-->
            </div>
            </c:if>
        </div>
    </div>
</div>
</body>
<jsp:include page="../main/footer.jsp"/>
</html>