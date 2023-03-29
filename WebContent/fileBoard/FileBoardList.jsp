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
		#content_form {
			height:470px;
			margin: 30px auto 0px;
		}
		#content_form table tr { height: 10px;}
	</style> 
	
	<style>	
	.inform_bg{width:700px; border: 1px solid #606060; margin: 0 auto; 
	margin-top: 50px;}	
	.inform_bg ul.noticeLine {min-height:60px; white-space: normal;}
	.inform_bg ul {display:block; font-size:12px; color:#5e5e5e; font-family:NGNormal; line-height:18px; padding: 15px 10px 10px 20px;}
	.inform_bg ul li span { color:#eb2915;}
	.inform_bg ul li strong { color:#eb2915; }
	.inform_bg ul.noticeLine { font-size: 14px; line-height: 150%; }
	.inform_bg ul.noticeLine li:nth-child(2) { margin-bottom: 10px; }
	.inform_bg ul li.privacy strong { color: #00539f; }
	body {background-color: #fbf4e5;}
	
	</style>
	<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
<!--  	<script>
		$(document).ready(function(){
			$('div').click(function(){
				var fno = Number($(this).children().eq(0).text()); // 0번째 div안의 있는 text;
				//alert(fno);
				if(!isNaN(fno)){
					location.href = '${conPath}/FileBoardContent.do?fno='+fno+'&pageNum=${pageNum}';
				}
			});
		});
	</script>  -->
</head>
<c:if test="${ empty student and empty teacher}">
	<script>
		alert('해당 페이지의 권한이 없습니다');
		location.href='${conPath}/main/main.jsp';
	</script>
</c:if>
<c:if test="${not empty boardResult }">
	<script>alert('${boardResult}');</script>
</c:if>
<jsp:include page="../main/header.jsp"/>
<body>
	<div class='inform_bg'>
	<ul class="noticeLine">
		<li>학교 수업을 위한 저작물(사진, 글, 그림, 영상 등)은 본 홈페이지에서만 이용 가능하며, <u>이 외의 공간에서 저작물을 공유 또는 게시하는 행위는 <strong>저작권법 위반</strong>에 해당</u>될 수 있습니다.</li>
		<li><u>폰트(글꼴), 이미지, 화면 캡처, 인쇄물 스캔본  등 <strong>저작권 위반 관련 소송 발생</strong></u> 사례가 있으니 자료 탑재 시 유의하시기 바랍니다.</li>
		<li class="privacy">게시되는 글의 본문이나 첨부파일에 <strong>개인정보</strong>(주민등록번호, 휴대폰번호, 주소, 은행계좌번호, 신용카드번호 등 개인을 식별할 수 있는 모든 정보)를 포함시키지 않도록 주의하시기 바랍니다.</li>
		<li class="privacy"><strong>개인정보</strong>가 게시되어 노출 될 경우 해당 게시물 작성자가 <strong>관련 법령에 따라 처분</strong>을 받을 수 있으니 유의하시기 바랍니다.</li>
	</ul>
</div>
	<c:if test="${not empty boardResult }">
		<script>alert($(BoardResult));</script>
	</c:if>
	   <div class="board_wrap">
        <div class="board_title">
            <strong>학급게시판</strong>
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
					<c:forEach items="${board }" var="board">
						<div class="num">${board.fno }</div>
						<div class="title" id="left">
							<c:forEach var="i" begin="1" end="${board.findent }">
								<c:if test="${i==board.findent }">└─</c:if>
								<c:if test="${i!=board.findent }"> &nbsp; &nbsp;</c:if>
							</c:forEach>
							<%--${board.ftitle } <!-- 글제목에 a태그를 걸지 말고 query로 tr을 클릭하면 상세보기 페이지로 가기 --> --%>
							<a href="${conPath}/FileBoardContent.do?fno=${board.fno }&pageNum=${pageNum}">${board.ftitle }</a>
							<c:if test="${not empty board.ffileName }">
								<img src="https://cdn-icons-png.flaticon.com/512/5088/5088374.png" width="10">
							</c:if>
						</div>
	                    <div class="writer">${board.sname}${board.tname }</div>
	                    <div class="date"><fmt:formatDate value="${board.frdate }" type="date" dateStyle="short"/></div>
	                    <div class="count">${board.fhit }</div>
					</c:forEach>
                </div>
                </c:if>
            </div>
            <div class="paging">
            <c:if test="${startPage > BLOCKSIZE }">
                <a href="${conPath }/FileBoardList.do?pageNum=${startPage-1}" class="bt">이전</a>
            </c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage }">
				<c:if test="${i == pageNum }">
					<a class="num on">  ${i }  </a>
				</c:if>
				<c:if test="${i != pageNum }">
					[ <a href="${conPath }/FileBoardList.do?pageNum=${i}" class="num"> ${i } </a> ]
				</c:if>
			</c:forEach>
			<c:if test="${endPage<pageCnt }">
			   <a href="${conPath }/FileBoardList.do?pageNum=${endPage+1}" class="bt">다음</a>
			</c:if>
            <c:if test="${not empty student or teacher }">
            <div class="bt_wrap">
                <a href="${conPath }/FileBoardWriteView.do" class="on">글쓰기</a>
                <!--<a href="#">수정</a>-->
            </div>
            </c:if>
            </div>
            <c:if test="${empty student or teacher }">
            <div class="bt_wrap">
                <a href="${conPath }/loginView.do" class="on">해당 기능에 대한 권한이 없습니다</a>
                <!--<a href="#">수정</a>-->
            </div>
            </c:if>
        </div>
    </div>
</body>
<jsp:include page="../main/footer.jsp"/>
</html>