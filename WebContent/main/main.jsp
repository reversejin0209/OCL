<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="conPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${conPath }/css/main.css" rel="stylesheet">
</head>
<jsp:include page="../main/header.jsp" />
<c:if test="${not empty next }">
	<script>
		location.href = '${conPath}/${next}';
	</script>
</c:if>
<c:if test="${not empty loginErrorMsg }">
	<script>
		alert('${loginErrorMsg}');
		history.back();
	</script>
</c:if>
<c:if test="${not empty modifyResult }">
	<script>
		alert('${modifyResult}');
	</script>
</c:if>
<c:if test="${not empty withdrawalResult }">
	<script>
		alert('${withdrawalResult}');
	</script>
</c:if>
<body>
	<div id="main_Page">
		<div id="container">
			<!-- id : container -->
			<div class="main_content">
				<!-- class : main_content -->
				<h1>
					<a href="#">서울우리초등학교 : 4학년 3반</a>
				</h1>
				<div class="cont_1">
					<div class="main_visual">
						<p>
							<a href=""></a><img src="${conPath }/img/mainImage.png" alt="우리초등학교"
								width="703px" height="193px">
							<%-- 									<img src="${conpath }/img/main.jpg" width="703px"
										height="193px" alt="메인 이미지"> --%>
						</p>
					</div>
					<!--우리반시간표 -->
					<div class="schedule">
						<h2>우리반시간표</h2>
						<div class="inner">
							<table>
								<caption>시간표</caption>
								<colgroup>
									<col style="width:">
									<col style="width: 18%">
									<col style="width: 18%">
									<col style="width: 18%">
									<col style="width: 18%">
									<col style="width: 18%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">&nbsp;</th>
										<th scope="col">월</th>
										<th scope="col">화</th>
										<th scope="col">수</th>
										<th scope="col">목</th>
										<th scope="col">금</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>도덕</td>
										<td>사회</td>
										<td>수학</td>
										<td>국어</td>
										<td>과학</td>
									</tr>
									<tr>
										<td>2</td>
										<td>영어</td>
										<td>사회</td>
										<td>영어</td>
										<td>국어</td>
										<td>음악</td>
									</tr>
									<tr>
										<td>3</td>
										<td>수학</td>
										<td>컴퓨터</td>
										<td>체육</td>
										<td>사회</td>
										<td>미술</td>
									</tr>
									<tr>
										<td>4</td>
										<td>체육</td>
										<td>국어</td>
										<td>실과</td>
										<td>음악</td>
										<td>미술</td>
									</tr>
									<tr>
										<td>5</td>
										<td>국어</td>
										<td>과학</td>
										<td>실과</td>
										<td>영어</td>
										<td>수학</td>
									</tr>
									<tr>
										<td>6</td>
										<td>국어</td>
										<td>과학</td>
										<td>실과</td>
										<td>체육</td>
										<td>자율</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!--//우리반시간표-->
						<!-- 알림장 -->
					<div class="notice_area">
						<div class="notice m_noti01">
							<h2>알림장</h2>
							<ul class="list_box">
								<c:forEach var="Nmain" items="${noticeMain }">
									<li>
										<span class= "text"> 
											<a	href="${conPath }/xxx.do/nno=${Nmain.nno}&pageNum=${pageNum}">
												${Nmain.ntitle } 
											</a>
										</span> 
										<span class="date">
											<fmt:formatDate value="${Nmain.nrdate }" pattern="yyyy.MM.dd"/>
											
										</span></li>
								</c:forEach>
							</ul>
							<a href="${conPath }/NoticeList.do" class="btn_more"
								title="더보기">더보기</a> <c:if test=""></c:if>
						</div>
						<!-- 알림장 -->
						<!-- 학급게시판 -->
						<div class="notice m_noti02">
							<h2>학급게시판</h2>
							<ul class="list_box">
<%-- 								<c:forEach var="board" items="${FileBoardList }">
									<li><span class="text">${FileBoardList.ftitle }</span></li>
								</c:forEach> --%>
 								<c:forEach var="Fmain" items="${FileBoardMain }">
									<li>
										<span class= "text"> 
											<a	href="${conPath }/FileBoardContent.do?fno=${Fmain.fno }&pageNum=${pageNum}">
												${Fmain.ftitle } 
											</a>
										</span> 
										<span class="date">
											<fmt:formatDate value="${Fmain.frdate }" pattern="yyyy.MM.dd"/>
											<%-- <a href="${conPath}/FileBoardContent.do?fno=${board.fno }&pageNum=${pageNum}">${board.ftitle }</a> --%>
										</span></li>
								</c:forEach> 
							</ul>
							<a href="${conPath }/FileBoardList.do" class="btn_more"
								title="더보기">더보기</a>
						</div>
						<!-- 게시판 -->
					</div>
					<!-- 학급앨범 -->
					<div class="gallery">
						<h2>학급앨범</h2>
						<!-- <table>
									<tr>
										tr
										<th>th</th>
										<td>td</td>
										<td>td</td>
										<td>td</td>
										<td>td</td>
									</tr>
								</table> -->
						<a href="${conPath }/GalleryList.do" class="btn_more"
							title="더보기">더보기</a>
					</div>
					<!-- 학급앨범 -->
				</div>
				<!-- cont_1 -->
				<div class="cont_2">
					<!-- class : cont_2 -->
					<div class="category">
						<!-- 카테고리 -->
						<h2>카테고리</h2>
						<ul>
							<li><a href="#">알림장</a></li>
							<li><a href="#">학급공지사항</a></li>
							<li><a href="#">학급게시판</a></li>
							<li><a href="#">학급앨범</a></li>
							<li><a href="#">국어 자료실</a></li>
							<li><a href="#">영어 자료실</a></li>
							<li><a href="#">수학 자료실</a></li>
							<li><a href="#">학사일정</a></li>
							<li><a href="#">가정학습 신청 게시판</a></li>
							<li><a href="#">식단표</a></li>
						</ul>
					</div>
					<!-- //카테고리 -->
				</div>
				<!-- class : cont_2 -->
			</div>
			<!-- class : main_content -->
		</div>
		<!-- id : container -->
	</div>
</body>
<jsp:include page="../main/footer.jsp" />
</html>