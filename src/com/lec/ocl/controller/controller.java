package com.lec.ocl.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.ocl.service.AllViewService;
import com.lec.ocl.service.FileBoardContentService;
import com.lec.ocl.service.FileBoardDeleteService;
import com.lec.ocl.service.FileBoardListService;
import com.lec.ocl.service.FileBoardModifyService;
import com.lec.ocl.service.FileBoardModifyViewService;
import com.lec.ocl.service.FileBoardReplyService;
import com.lec.ocl.service.FileBoardReplyViewService;
import com.lec.ocl.service.FileBoardWriteService;
import com.lec.ocl.service.GalleryContentService;
import com.lec.ocl.service.GalleryDeleteService;
import com.lec.ocl.service.GalleryListService;
import com.lec.ocl.service.GalleryModifyService;
import com.lec.ocl.service.GalleryModifyViewService;
import com.lec.ocl.service.GalleryWriteService;
import com.lec.ocl.service.MainService;
import com.lec.ocl.service.NoticeContentService;
import com.lec.ocl.service.NoticeDeleteService;
import com.lec.ocl.service.NoticeListService;
import com.lec.ocl.service.NoticeModifyService;
import com.lec.ocl.service.NoticeModifyViewService;
import com.lec.ocl.service.NoticeWriteService;
import com.lec.ocl.service.SIDfindService;
import com.lec.ocl.service.SJoinService;
import com.lec.ocl.service.SLoginService;
import com.lec.ocl.service.SLogoutService;
import com.lec.ocl.service.SModifyService;
import com.lec.ocl.service.SPWfindService;
import com.lec.ocl.service.SWithdrawalService;
import com.lec.ocl.service.SemailConfirmService;
import com.lec.ocl.service.Service;
import com.lec.ocl.service.SidConfirmService;
import com.lec.ocl.service.TLoginService;

@WebServlet("*.do")
public class controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actiondo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		actiondo(request, response);
	}

	private void actiondo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		String uri = request.getRequestURI();
		String conPath = request.getContextPath();
		String command = uri.substring(conPath.length());
		String viewPage = null;
		Service service = null;
		if(command.equals("/main.jsp"))
			viewPage = "main.do";
		if(command.equals("/main.do")) { // 첫화면 실행시 알림장, 게시판, 학급앨범등 db에서 호출
			service = new MainService();
			service.execute(request, response);
			viewPage = "main/main.jsp";
		/* * * * * * * * * * * * * * * * * * * * * * * * * * * 
		 * * * * * * * * * * student 관련 요청 * * * * * * * * * *
		 * * * * * * * * * * * * * * * * * * * * * * * * * * */
		}else if(command.equals("/joinView.do")) {
			viewPage = "Student/join.jsp";
		}else if(command.equals("/sidConfirm.do")) {
			service = new SidConfirmService();
			service.execute(request, response);
			viewPage = "Student/sidConfirm.jsp";
		}else if(command.equals("/semailConfirm.do")) {
			service = new SemailConfirmService();
			service.execute(request, response);
			viewPage = "Student/semailConfirm.jsp";
		}else if(command.equals("/join.do")) { // 회원가입 DB 처리
			service = new SJoinService(); // execute메소드 : mId중복체크 후 회원가입
			service.execute(request, response);
			viewPage = "Student/login.jsp";
		}else if(command.equals("/loginView.do")) { // 로그인 화면
			viewPage = "Student/login.jsp";
		}else if(command.equals("/login.do")) { // 로그인 DB 및 세션 처리
			service = new SLoginService();
			service.execute(request, response);
			viewPage = "main.do";
		}else if(command.equals("/logout.do")) {//로그아웃 - 세션 날리기
			service = new SLogoutService();
			service.execute(request, response);
			viewPage = "main.do";
		}else if(command.equals("/modifyView.do")) { // 정보 수정하기 위한 view 
			viewPage = "Student/modify.jsp";	
		}else if(command.equals("/modify.do")) { // db정보 수정
			service = new SModifyService();
			service.execute(request, response);
			viewPage = "main.do";
		}else if(command.equals("/withdrawal.do")) { // 회원탈퇴
			service = new SWithdrawalService();
			service.execute(request, response);
			viewPage = "main.do";
		}else if(command.equals("/findView.do")) {
			viewPage = "Student/Findview.jsp";
		}else if(command.equals("/findID.do")){
			service = new SIDfindService();
			service.execute(request, response);
			viewPage = "findView.do";
		}else if(command.equals("/findPW.do")) { 
			service = new SPWfindService();
			service.execute(request, response); 
			viewPage = "Student/FindPW.jsp";
		/* * * * * * * * * * * * * * * * * * * * * * * * * * * 
		 * * * * * * * * * * FileBoard 관련 요청 * * * * * * * * * 
		 * * * * * * * * * * * * * * * * * * * * * * * * * * */
		}else if(command.equals("/FileBoardList.do")) {// 게시판 - 리스트
			service = new FileBoardListService();
			service.execute(request, response);
			viewPage = "fileBoard/FileBoardList.jsp";
		}else if(command.equals("/FileBoardWriteView.do")) { // 게시판 - 글쓰기 뷰
			viewPage = "fileBoard/FileBoardWrite.jsp";
		}else if(command.equals("/FileBoardWrite.do")) { // 게시판 - 글쓰기
			service = new FileBoardWriteService();
			service.execute(request, response);
			viewPage = "FileBoardList.do";
		}else if(command.equals("/FileBoardContent.do")) { // 게시판 - 상세보기
			service = new FileBoardContentService();
			service.execute(request, response);
			viewPage = "fileBoard/FileBoardContent.jsp";
		}else if(command.equals("/FileBoardModifyView.do")) { // 게시판 글정보 수정 뷰
			service = new FileBoardModifyViewService();
			service.execute(request, response);
			viewPage = "fileBoard/FileBoardModify.jsp";
		}else if(command.equals("/FileBoardModify.do")) { // 게시판 글정보 수정
			service = new FileBoardModifyService();
			service.execute(request, response);
			viewPage = "FileBoardList.do";
		}else if(command.equals("/FileBoardDelete.do")) { // 게시판 글삭제
			service = new FileBoardDeleteService();
			service.execute(request, response);
			viewPage = "FileBoardList.do";
		}else if(command.equals("/FileBoardReplyView.do")) { // 게시판 답변글 달기 뷰
			service = new FileBoardReplyViewService();
			service.execute(request, response);
			viewPage = "fileBoard/FileBoardReplyView.jsp";
		}else if(command.equals("/FileBoardReply.do")) { // 게시판  답변글 작성
			service = new FileBoardReplyService();
			service.execute(request, response);
			viewPage = "FileBoardList.do";
			/* * * * * * * * * * * * * * * * * * * * * * * * * * * 
			 * * * * * * * * * * teacher 관련 요청 * * * * * * * * * *
			 * * * * * * * * * * * * * * * * * * * * * * * * * * */
		}else if(command.equals("/teacherLoginView.do")) {
			viewPage = "Teacher/Tlogin.jsp";
		}else if(command.equals("/teacherLogin.do")) {
			service = new TLoginService();
			service.execute(request, response);
			viewPage = "main.do";
		}else if(command.equals("/AllView.do")) {
			service = new AllViewService();
			service.execute(request, response);
			viewPage = "Teacher/AllView.jsp";
		/* * * * * * * * * * * * * * * * * * * * * * * * * * * 
		 * * * * * * * * * * * Notice 관련 요청 * * * * * * * * * 
		 * * * * * * * * * * * * * * * * * * * * * * * * * * */
		}else if(command.equals("/NoticeList.do")) { // 알림장 - 리스트
			service = new NoticeListService();
			service.execute(request, response);
			viewPage = "Notice/NoticeList.jsp";
			
		}else if(command.equals("/NoticeWriteView.do")) { // 알림장 - 글 작성 뷰
			viewPage = "Notice/NoticeWrite.jsp";
			
		}else if(command.equals("/NoticeWrite.do")) { // 알림장 - 글쓰기
			service = new NoticeWriteService();
			service.execute(request, response);
			viewPage = "NoticeList.do";
			
		}else if(command.equals("/NoticeContent.do")) { // 알림장 - 상세보기 
			service = new NoticeContentService();
			service.execute(request, response);
			viewPage = "Notice/NoticeContent.jsp";
			
		}else if(command.equals("/NoticeModifyView.do")) { // 알림작 - 글정보 수정 뷰
			service = new NoticeModifyViewService();
			service.execute(request, response);
			viewPage = "Notice/NoticeModify.jsp";
			
		}else if(command.equals("/NoticeModify.do")) { // 알림장 - 글정보 수정
			service = new NoticeModifyService();
			service.execute(request, response);
			viewPage = "NoticeList.do";
			
		}else if(command.equals("/NoticeDelete.do")) {
			service = new NoticeDeleteService();
			service.execute(request, response);
			viewPage = "NoticeList.do";
		/* * * * * * * * * * * * * * * * * * * * * * * * * * * 
		 * * * * * * * * * * * Gallery 관련 요청 * * * * * * * * * 
		 * * * * * * * * * * * * * * * * * * * * * * * * * * */
		}else if(command.equals("/GalleryList.do")) {
			service = new GalleryListService();
			service.execute(request, response);
			viewPage = "Gallery/GalleryList.jsp";
		}else if(command.equals("/GalleryWriteView.do")){
			viewPage = "Gallery/GalleryWrite.jsp";
		}else if(command.equals("/GalleryWrite.do")) {
			service = new GalleryWriteService();
			service.execute(request, response);
			viewPage = "GalleryList.do";
		}else if(command.equals("/GalleryContent.do")) {
			service = new GalleryContentService();
			service.execute(request, response);
			viewPage = "Gallery/GalleryContent.jsp";
		}else if(command.equals("/GalleryModifyView.do")) {
			service = new GalleryModifyViewService();
			service.execute(request, response);
			viewPage = "Gallery/GalleryModify.jsp";
		}else if(command.equals("/GalleryModify.do")) {
			service = new GalleryModifyService();
			service.execute(request, response);
			viewPage = "GalleryList.do";
		}else if(command.equals("/GalleryDelete.do")) {
			service = new GalleryDeleteService();
			service.execute(request, response);
			viewPage = "GalleryList.do";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}