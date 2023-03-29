package com.lec.ocl.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.ocl.service.FileBoardContentService;
import com.lec.ocl.service.FileBoardDeleteService;
import com.lec.ocl.service.FileBoardListService;
import com.lec.ocl.service.FileBoardModifyService;
import com.lec.ocl.service.FileBoardModifyViewService;
import com.lec.ocl.service.FileBoardReplyService;
import com.lec.ocl.service.FileBoardReplyViewService;
import com.lec.ocl.service.FileBoardWriteService;
import com.lec.ocl.service.SJoinService;
import com.lec.ocl.service.SLoginService;
import com.lec.ocl.service.SLogoutService;
import com.lec.ocl.service.SModifyService;
import com.lec.ocl.service.SemailConfirmService;
import com.lec.ocl.service.Service;
import com.lec.ocl.service.SidConfirmService;

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
		if(command.equals("/main.do")) { // 첫화면
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
			viewPage = "main/main.jsp";
		}else if(command.equals("/logout.do")) {//로그아웃 - 세션 날리기
			service = new SLogoutService();
			service.execute(request, response);
			viewPage = "main/main.jsp";
		}else if(command.equals("/modifyView.do")) {
			service = new SModifyService();
			service.execute(request, response);
			viewPage = "Student/modify.jsp";	
		}
		/* * * * * * * * * * * * * * * * * * * * * * * * * * * 
		 * * * * * * * * * * FileBoard 관련 요청 * * * * * * * * * 
		 * * * * * * * * * * * * * * * * * * * * * * * * * * */
		else if(command.equals("/FileBoardList.do")) {// 게시판 - 
			service = new FileBoardListService();
			service.execute(request, response);
			viewPage = "fileBoard/FileBoardList.jsp";
		}else if(command.equals("/FileBoardWriteView.do")) {
			viewPage = "fileBoard/FileBoardWrite.jsp";
		}else if(command.equals("/FileBoardWrite.do")) {
			service = new FileBoardWriteService();
			service.execute(request, response);
			viewPage = "FileBoardList.do";
		}else if(command.equals("/FileBoardContent.do")) {
			service = new FileBoardContentService();
			service.execute(request, response);
			viewPage = "fileBoard/FileBoardContent.jsp";
		}else if(command.equals("/FileBoardModifyView.do")) {
			service = new FileBoardModifyViewService();
			service.execute(request, response);
			viewPage = "fileBoard/FileBoardModify.jsp";
		}else if(command.equals("/FileBoardModify.do")) {
			service = new FileBoardModifyService();
			service.execute(request, response);
			viewPage = "FileBoardList.do";
		}else if(command.equals("/FileBoardDelete.do")) {
			service = new FileBoardDeleteService();
			service.execute(request, response);
			viewPage = "FileBoardList.do";
		}else if(command.equals("/FileBoardReplyView.do")) {
			service = new FileBoardReplyViewService();
			service.execute(request, response);
			viewPage = "fileBoard/FileBoardReplyView.jsp";
		}else if(command.equals("/FileBoardReply.do")) {
			service = new FileBoardReplyService();
			service.execute(request, response);
			viewPage = "FileBoardList.do";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		}
	}