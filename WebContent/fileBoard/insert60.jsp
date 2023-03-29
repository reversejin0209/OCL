<%@page import="com.lec.ocl.dto.FileBoardDto"%>
<%@page import="com.lec.ocl.dao.FileBoardDao"%>
<%@page import="com.lec.ocl.dto.StudentDto"%>
<%@page import="com.lec.ocl.dao.StudentDao"%>
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
	<link href="conPath/css/style.css" rel="stylesheet">
	<style>
		#content_form {
			height:470px;
			margin: 30px auto 0px;
		}
		#content_form table tr { height: 10px;}
	</style>
	<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
	<script>
		$(document).ready(function(){
			
		});
	</script>
</head>
<jsp:include page="../main/header.jsp"/>
<body>
	<%--더미데이터 60개 추가  --%>
	<%
		FileBoardDao dao = FileBoardDao.getInstance();
		FileBoardDto dto = new FileBoardDto();
		for(int i=0 ; i<60 ; i++){
			dto.setFtitle("제목"+i);
			dto.setFcontent(i+"번째 본문");
			dto.setFip("192.168.10."+i);
			if(i%5!=0){ 	  // 5의배수가 아닐경우 학생글 입력 더미데이터
		dto.setSid("aaa");
		dto.setFfileName(null);
		dao.writeBoardSid(dto);
			}else if(i%5==0){ // 5의배수 일경우 선생글 입력 더미데이터
		dto.setTid("dbswls0209");
		dto.setFfileName("a.docx");
		dao.writeBoardTid(dto);
			}
		}
		response.sendRedirect("../FileBoardList.do");
	%>
</body>
<jsp:include page="../main/footer.jsp"/>
</html>