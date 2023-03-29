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
	footer {
		margin :-18px; 
		padding:-21px;
		width:100%-4px;
		}
	footer #footer_conts, footer #footer_conts a {
		font-weight: blod;
		font-size:0.9em;
		text-align: center;
	}
	footer #footer_menu {
		background-color: #606060;
		height: 80px;
		line-height: 80px;
		min-width: 900px;
	}
	footer #footer_conts {
		background-color: #f2f2f2;
		height:250px;
		min-width: 1000px;
	}
	footer a:link, a:visited, a:hover, a:active {
		text-decoration: none;
		color:#f0f7fd;
	}
	footer ul li{
		float:left;
		min-width:80px;
		text-align: center;
	}
	footer ul li a{
		margin: 20px;
	}
	footer p {padding: 20px; border-right: 1px solid gray;}
</style>
</head>
<body>
<footer>
  		<div id="footer_menu">
            <ul style="list-style: none;" >
                <li><a href="https://map.naver.com/v5/search/%EC%96%91%EC%84%9C%EC%A4%91%ED%95%99%EA%B5%90?c=15,0,0,0,dh" target="_blank">찾아오시는 길</a></li>
                <li><a href="https://copy112.kcopa.or.kr/"target="_blank">저작권신고</a></li>
                <li><a href="https://yangseo.sen.ms.kr/dggb/module/policy/selectPolicyDetail.do?policyTypeCode=PLC003&menuNo=74145" target="_blank">서비스이용약관</a></li>
                <li><a href="https://www.moe.go.kr/sub/infoRenew.do?m=070102&page=070102&s=moe" target="_blank">개인정보처리방침</a></li>
            </ul>
   		</div>
		<div id="footer_conts">
				<br>
				<address>
				<p>
					(우) 07912 서울특별시 양천구 남부순환로 380(신월동)<br/>
    				교무실 (08:20~16:20) 062-958-5200 / 행정실 (08:00~16:20) 062-958-5252 / 팩스 062-958-5299 / 야간당직실 (평일 야간,휴일) 062-958-5259
    			</p>
    			</address>
				Copyright© 2023 by 우리초등학교. Allrights Reserved<br><br>
				<b><img src="${conPath }/img/selectImageView.png" alt="우리초등학교"></b>
		</div>
</footer>
</body>
</html>