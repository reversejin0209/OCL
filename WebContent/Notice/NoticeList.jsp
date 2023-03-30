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
<c:if test="${ empty student and empty teacher}">
	<script>
		alert('해당 페이지의 권한이 없습니다');
		location.href='${conPath}/main.do';
	</script>
</c:if>
<c:if test= "${empty pageNum}">
	<script>
		location.href='${conPath}/Notice/NoticeList.jsp';
	</script>
</c:if>
<jsp:include page="../main/header.jsp"/>
<body>
<c:if test="${not empty NoticeResult }">
	<script>alert('${NoticeResult}');</script>
</c:if>
	   <div class="board_wrap">
        <div class="board_title">
            <strong>알림장</strong>
            <p> 전체 <b>${totCnt}</b> 건</p>
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
					<c:forEach items="${Noticelist }" var="Notice">
						<div class="num">${Notice.nno }</div>
						<div class="title" id="left">
<%-- 							<c:forEach var="i" begin="1" end="${board.findent }">
								<c:if test="${i==Notice.findent }">└─</c:if>
								<c:if test="${i!=Notice.findent }"> &nbsp; &nbsp;</c:if>
							</c:forEach> --%>
							<%--${board.ftitle } <!-- 글제목에 a태그를 걸지 말고 query로 tr을 클릭하면 상세보기 페이지로 가기 --> --%>
							<a href="${conPath}/NoticeContent.do?nno=${Notice.nno }&pageNum=${pageNum}">${Notice.ntitle }</a>
						</div>
	                    <div class="writer">${Notice.tname} [선생님]</div>
	                    <div class="date"><fmt:formatDate value="${Notice.nrdate }" type="date" dateStyle="short"/></div>
	                    <div class="count">${Notice.nhit }</div>
					</c:forEach>
                </div>
                </c:if>
            </div>
            <div class="paging">
            <c:if test="${startPage > BLOCKSIZE }">
                <a href="${conPath }/NoticeList.do?pageNum=${startPage-1}" class="bt">이전</a>
            </c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage }">
				<c:if test="${i == pageNum }">
					<a class="num on">  ${i }  </a>
				</c:if>
				<c:if test="${i != pageNum }">
					[ <a href="${conPath }/NoticeList.do?pageNum=${i}" class="num"> ${i } </a> ]
				</c:if>
			</c:forEach>
			<c:if test="${endPage<pageCnt }">
			   <a href="${conPath }/NoticeList.do?pageNum=${endPage+1}" class="bt">다음</a>
			</c:if>
            <c:if test="${not empty teacher and empty student }">
            <div class="bt_wrap">
                <a href="${conPath }/NoticeWriteView.do" class="on">공지등록</a>
                <!--<a href="#">수정</a>-->
            </div>
            </c:if>
            </div>
        </div>
    </div>
</body>
<jsp:include page="../main/footer.jsp"/>
</html>