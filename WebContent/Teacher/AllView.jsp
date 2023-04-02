<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="conPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${conPath }/css/css.css" rel="stylesheet">
<style>
	body {
		background-color: #fbf4e5;
	}
	.board_list .email, .board_list .address {
	    width: 20%;
	}
	.board_list .photo, .board_list .name, .board_list .num {
		width: 10%;
	}
	.board_list .date {
	    width: 7%;
	}
	.board_list .gender {
		width: 3%
	}
	.board_list .id {
		width: 12%;
	}
</style>
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
<script>
	$(document).ready(function() {

	});
</script>
</head>
<jsp:include page="../main/header.jsp" />
<!-- <style>
	div {text-align: center;}
</style> -->
<body>
	<c:if test="${not empty teacherLoginResult }">
		<script>
			alert('${teacherLoginResult}');
		</script>
	</c:if>
	<c:if test="${not empty teacherErrorMsg }">
		<script>
			alert('${teacherErrorMsg}');
			history.back();
		</script>
	</c:if>
	   <div class="board_wrap">
        <div class="board_title">
            <strong>전체회원조회</strong>
            <p> 전체 회원은 <b>${totCnt}</b>명</p>
        </div>
        <div class="board_list_wrap">
            <div class="board_list">
                <div class="top">
                    <div class="date">가입일</div>
                    <div class="id">ID</div>
                    <div class="name">이름</div>
                    <div class="num">번호</div>
                    <div class="date">생일</div>
                    <div class="email">이메일</div>
                    <div class="photo">사진</div>
                    <div class="gender">성별</div>
                    <div class="address">주소</div>
                </div>
                <c:if test="${totCnt==0 }"></c:if>
                <c:if test="${totCnt!=0 }">
                <div>
					<c:forEach var="student" items="${students }" >
						<div class="date"><fmt:formatDate value="${student.srdate }" type="date" dateStyle="short"/></div>
						<div class="id"><a href="${conPath}/withdrawal.do">${student.sid}</a></div>
	                    <div class="name">${student.sname} [학생]</div>
	                    <div class="num">${student.snumber}</div>
	                    <div class="date"><fmt:formatDate value="${student.sbirth }" type="date" dateStyle="short"/></div>
	                    <div class="email">${student.semail}</div>
	                    <div class="photo">${student.sphoto}</div>
	                    <div class="gender">${student.sgender}</div>
	                    <div class="address">${student.saddress}</div>
					</c:forEach>
                </div>
                </c:if>
            </div>
            <div class="paging">
            <c:if test="${startPage > BLOCKSIZE }">
                <a href="${conPath }/AllView.do?pageNum=${startPage-1}" class="bt">이전</a>
            </c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage }">
				<c:if test="${i == pageNum }">
					<a class="num on">  ${i }  </a>
				</c:if>
				<c:if test="${i != pageNum }">
					[ <a href="${conPath }/AllView.do?pageNum=${i}" class="num"> ${i } </a> ]
				</c:if>
			</c:forEach>
			<c:if test="${endPage<pageCnt }">
			   <a href="${conPath }/AllView.do?pageNum=${endPage+1}" class="bt">다음</a>
			</c:if>
            </div>
        </div>
    </div>
</body>
<jsp:include page="../main/footer.jsp" />
</html>