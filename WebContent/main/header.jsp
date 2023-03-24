<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	*{padding:0; margin: 0;}
	header { 
		min-width: 900px;
		font-size: 10px;
		width:100%;
		height:350px;
	}
	header a {text-decoration: none; font-weight: bold;}
	header li { list-style: none;}
	header .gnb{
		width: 100%;
		display: flex;
		justify-content: space-between;
		margin: 20px;}
	header .gnb ul {	
		overflow: hidden;
		margin: 20px;
	}
	header .gnb ul li {	float: right;	}
	header .gnb a { 
		color : #ffffff;
		font-size: 0.9em;
		display: block;
		padding-left:15px;
		padding-right:15px;
		height: 50px;
		line-height: 50px;
	}
	header .gnb ul li a:first-child{
		background-color: #158cc4;
		border: 1px;
		}
	header .gnb ul li a:nth-child(2){
		background-color: gray;
	}
	header .lnb {
	  width: 100%; height: 40px;
	  border-top: 3px solid #606060;
		position:relative; /*서브메뉴가 main영역 위로 */
	}
	header .lnb ul{
		overflow: hidden;
		width:750px;
		margin: 0 auto;
	}
	header .lnb ul>li {
		margin: 5px;
		float:left;
		padding:5px 40px;
		line-height: 25px;
	}
	header .lnb li a {color: #003300;}
	header .lnb li {color: #003300;}
	header .lnb ul li .subMenu {display:none;}
	header .lnb ul li:hover .subMenu {display: block; margin: 10px 0 0 0;}
	header #header_nav{
    width: 100%;
    min-width: 900px; /* 최소한의 가로 사이즈 */
    height: 50px;
    line-height: 50px;
    background-color: #2d1152;
    font-size: 0.9em;
    overflow: hidden;
}
</style>
</head>
<body>
<header>
	<c:if test="${empty student and empty teacher}"> <%-- 로그인 전 화면 --%>
		<div class="gnb">
			<img src="../img/selectImageView.png" alt="우리초등학교">
			<nav>
			<ul>
				<li class=""><a href="${conPath }/main.do">홈페이지</a></li>
				<li><a href="${conPath }/joinView.do">회원가입</a></li>
				<li><a href="${conPath }/loginView.do">로그인</a></li>
			</ul>
			</nav>
		</div>
		<div class="lnb">
			<ul>
				<li>학교소개<ol class="subMenu">
							<li><a href="#">학교장인삿말</a></li>
							<li><a href="#">학교연혁</a></li>
							<li><a href="#">학교상징 및 교가</a></li>
						</ol>
				</li>
				<li>교육마당<ol class="subMenu">
							<li><a href="#">메뉴2-1</a></li>
							<li><a href="#">메뉴2-2</a></li>
							<li><a href="#">메뉴2-3</a></li>
						</ol>
				</li>
				<li>학습마당<ol class="subMenu">
							<li><a href="#">메뉴3-1</a></li>
							<li><a href="#">메뉴3-2</a></li>
							<li><a href="#">메뉴3-3</a></li>
						</ol>
				</li>
				<li>열린마당<ol class="subMenu">
							<li><a href="#">메뉴4-1</a></li>
							<li><a href="#">메뉴4-2</a></li>
							<li><a href="#">메뉴4-3</a></li>
						</ol>
				</li>
			</ul>
		</div>
	</c:if>
	<c:if test="${not empty student and empty teacher}"> <%-- 사용자 모드 로그인 화면--%>
		<div class="gnb">
			<ul>
				<li><a href="${conPath }/main.do">홈페이지</a></li>
				<li><a href="${conPath }/logout.do">정보수정</a></li>
				<li><a href="${conPath }/modifyView.do">로그아웃</a></li>
				<li><a>${student.sname }님 &nbsp; ▶</a></li>	
			</ul>
		</div>
		<div class="logo" onclick="location.href='${conPath}/list.do'">
			<img src="../img/selectImageView.png" alt="우리초등학교">
		</div> 
	</c:if>
	<c:if test="${empty member and not empty admin}"> <%-- 관리자 모드 로그인 화면--%>
		<div class="gnb">
			<ul>
				<li><a href="${conPath }/boardList.do">고객센터</a></li>
				<li><a href="${conPath }/logout.do">관리자모드나가기</a></li>
				<li><a>${admin.aname }님 &nbsp; ▶</a></li>	
			</ul>
		</div>
		<div class="logo" onclick="location.href='${conPath}/allView.do'">
			<img src="../img/selectImageView.png" alt="우리초등학교">
		</div>
	</c:if>
</header>
</body>
</html>