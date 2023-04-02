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
<style>
header {
	margin: -21px;
	padding: -21px;
	min-width: 900px;
	font-size: 15px;
	width: 100% -4px;
	background-color: #fbf4e5;
}

header a {
	text-decoration: none;
	font-weight: bold;
}

header li {
	list-style: none;
}

header .gnb {     
	width: 100%;
	display: flex;
	justify-content: space-between;
	border-bottom: 3px solid #606060;
}

header .gnb ul {
	overflow: hidden;
	margin: 20px;
}

header .gnb ul li {
	float: right;
	margin-left: 10px;
	width: 90px;
	text-align: center;
}

header .gnb ul li:nth-child(1) {
	background-color: #8e8e8e;
	margin-right: 50px;
}

header .gnb ul li:nth-child(2) {
	background-color: #5a5a5a;
}

header .gnb ul li:nth-child(3) {
	background-color: #0095da;
}

header .gnb ul li:nth-child(4) {
	background-color: #1b2026;
}

header .gnb a {
	color: #ffffff;
	font-size: 0.9em;
	display: block;
	padding-left: 15px;
	padding-right: 15px;
	height: 50px;
	line-height: 50px;
}

header #header_nav {
	width: 100%;
	min-width: 900px; /* 최소한의 가로 사이즈 */
	height: 100px;
	line-height: 100px;
	overflow: hidden;
	margin: 20px;
}

header img {
	margin: 20px 0 20px 30px;
}

header .mainMenu, .subMenu {
	margin: 0;
	padding: 0;
	list-style: none;
}

header .mainMenu>li {
	float: left;
}

header .mainMenu>li>a {
	width: 100px;
	color: black;
	text-align: center;
	text-decoration: none;
	letter-spacing: 0.05em;
	display: block;
	padding: 14px 36px;
	border-right: 1px solid rgba(0, 0, 0, 0.15);
	text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.2);
}

header .lnb {
	width: 100%;
	display: flex;
	justify-content: center;
	position: relative;
}

header .subMenu {
	position: absolute;
	background: #182952;
	opacity: 0.1;
	visibility: hidden;
	transition: all 0.15s ease-in;
	width: 170px;
	text-align: center;
}

header .subMenu>li {
	padding: 16px 28px;
	border-bottom: 1px solid rgba(0, 0, 0, 0.15);
}

header .subMenu>li>a {
	color: rgba(255, 255, 255, 0.6);
	text-decoration: none;
	width: 100px;
}

header .mainMenu>li:hover .subMenu {
	opacity: 1;
	visibility: visible;
}

header .subMenu>li>a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>
	<header>
		<c:if test="${empty student and empty teacher}">
			<%-- 로그인 전 화면 --%>
			<div class="gnb">
				<a href="${conPath }/main.do"><img src="${conPath }/img/nomalocl.png" alt="OCL마크" width="200px;" height="70px;"></a>
				<nav class="header_nav">
					<ul>
						<li><a href="${conPath }/main.do">홈페이지</a></li>
						<li><a href="${conPath }/joinView.do">회원가입</a></li>
						<li><a href="${conPath }/loginView.do">로그인</a></li>
					</ul>
				</nav>
			</div>
			<div class="lnb">
				<ul class="mainMenu">
					<li><a href="#">학교소개
							<ul class="subMenu">
								<li><a href="#">학교장인삿말</a></li>
								<li><a href="#">학교연혁</a></li>
								<li><a href="#">학교상징 및 교가</a></li>
							</ul>
					</a></li>
					<li><a href="#">학교정보
							<ul class="subMenu">
								<li><a href="https://map.naver.com/v5/search/%EC%96%91%EC%84%9C%EC%A4%91%ED%95%99%EA%B5%90?c=15,0,0,0,dh" target="_blank">찾아오시는 길</a></li>
				                <li><a href="https://copy112.kcopa.or.kr/"target="_blank">저작권신고</a></li>
				                <li><a href="https://yangseo.sen.ms.kr/dggb/module/policy/selectPolicyDetail.do?policyTypeCode=PLC003&menuNo=74145" target="_blank">서비스이용약관</a></li>
				                <li><a href="https://www.moe.go.kr/sub/infoRenew.do?m=070102&page=070102&s=moe" target="_blank">개인정보처리방침</a></li>
							</ul>
					</a></li>
					<li><a href="#">학습마당
							<ul class="subMenu">
								<li><a href="#">수학 게시판</a></li>
								<li><a href="#">국어 게시판</a></li>
								<li><a href="#">영어 게시판</a></li>
							</ul>
					</a></li>
					<li><a href="#">열린마당
							<ul class="subMenu">
								<li><a href="${conPath }/NoticeList.do">알림장</a></li>
								<li><a href="${conPath }/FileBoardList.do">학급게시판</a></li>
								<li><a href="${conPath }/GalleryList.do">학급앨범</a></li>
							</ul>
					</a></li>
				</ul>
			</div>
		</c:if>
		<c:if test="${not empty student and empty teacher}">
			<%-- 사용자 모드 로그인 화면--%>
			<div class="gnb">
				<a href="${conPath }/main.do"><img src="${conPath }/img/nomalocl.png" alt="OCL마크" width="200px;" height="70px;"></a>
				<nav class="header_nav">
					<ul>
						<li><a href="${conPath }/main.do">홈페이지</a></li>
						<li><a href="${conPath }/modifyView.do">정보수정</a></li>
						<li><a href="${conPath }/logout.do">로그아웃</a></li>
						<li><a> ${student.sname }님 <br> 환영합니다!
						</a></li>
					</ul>
				</nav>
			</div>
			<div class="lnb">
				<ul class="mainMenu">
					<li><a href="#">학교소개
							<ul class="subMenu">
								<li><a href="#">학교장인삿말</a></li>
								<li><a href="#">학교연혁</a></li>
								<li><a href="#">학교상징 및 교가</a></li>
							</ul>
					</a></li>
					<li><a href="#">학교정보
							<ul class="subMenu">
								<li><a href="https://map.naver.com/v5/search/%EC%96%91%EC%84%9C%EC%A4%91%ED%95%99%EA%B5%90?c=15,0,0,0,dh" target="_blank">찾아오시는 길</a></li>
				                <li><a href="https://copy112.kcopa.or.kr/"target="_blank">저작권신고</a></li>
				                <li><a href="https://yangseo.sen.ms.kr/dggb/module/policy/selectPolicyDetail.do?policyTypeCode=PLC003&menuNo=74145" target="_blank">서비스이용약관</a></li>
				                <li><a href="https://www.moe.go.kr/sub/infoRenew.do?m=070102&page=070102&s=moe" target="_blank">개인정보처리방침</a></li>
							</ul>
					</a></li>
					<li><a href="#">학습마당
							<ul class="subMenu">
								<li><a href="#">수학 게시판</a></li>
								<li><a href="#">국어 게시판</a></li>
								<li><a href="#">영어 게시판</a></li>
							</ul>
					</a></li>
					<li><a href="#">열린마당
							<ul class="subMenu">
								<li><a href="${conPath }/NoticeList.do">알림장</a></li>
								<li><a href="${conPath }/FileBoardList.do">학급게시판</a></li>
								<li><a href="${conPath }/GalleryList.do">학급앨범</a></li>
							</ul>
					</a></li>
				</ul>
			</div>
		</c:if>
		<c:if test="${empty student and not empty teacher}">
			<%-- 관리자 모드 로그인 화면--%>
			<div class="gnb">
				<a href="${conPath }/main.do"><img src="${conPath }/img/nomalocl.png" alt="OCL마크" width="200px;" height="70px;"></a>
				<nav class="header_nav">
					<ul>
						<li><a href="${conPath }/main.do">홈페이지</a></li>
						<li><a href="${conPath }/AllView.do">전체회원조회</a></li>
						<li><a href="${conPath }/logout.do">로그아웃</a></li>
						<li><a>${teacher.tname }님 &nbsp;</a></li>
					</ul>
				</nav>
			</div>
			<div class="lnb">
				<ul class="mainMenu">
					<li><a href="#">학교소개
							<ul class="subMenu">
								<li><a href="#">학교장인삿말</a></li>
								<li><a href="#">학교연혁</a></li>
								<li><a href="#">학교상징 및 교가</a></li>
							</ul>
					</a></li>
					<li><a href="#">학교정보
							<ul class="subMenu">
								<li><a href="https://map.naver.com/v5/search/%EC%96%91%EC%84%9C%EC%A4%91%ED%95%99%EA%B5%90?c=15,0,0,0,dh" target="_blank">찾아오시는 길</a></li>
				                <li><a href="https://copy112.kcopa.or.kr/"target="_blank">저작권신고</a></li>
				                <li><a href="https://yangseo.sen.ms.kr/dggb/module/policy/selectPolicyDetail.do?policyTypeCode=PLC003&menuNo=74145" target="_blank">서비스이용약관</a></li>
				                <li><a href="https://www.moe.go.kr/sub/infoRenew.do?m=070102&page=070102&s=moe" target="_blank">개인정보처리방침</a></li>
							</ul>
					</a></li>
					<li><a href="#">학습마당
							<ul class="subMenu">
								<li><a href="#">수학 게시판</a></li>
								<li><a href="#">국어 게시판</a></li>
								<li><a href="#">영어 게시판</a></li>
							</ul>
					</a></li>
					<li><a href="#">열린마당
							<ul class="subMenu">
								<li><a href="${conPath }/NoticeList.do">알림장</a></li>
								<li><a href="${conPath }/FileBoardList.do">학급게시판</a></li>
								<li><a href="${conPath }/GalleryList.do">학급앨범</a></li>
							</ul>
					</a></li>
				</ul>
			</div>
		</c:if>
	</header>
</body>
</html>