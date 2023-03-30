package com.lec.ocl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.ocl.dao.TeacherDao;
import com.lec.ocl.dto.TeacherDto;

public class TLoginService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String tid = request.getParameter("tid");
		String tpw = request.getParameter("tpw");
		TeacherDao tDao = TeacherDao.getInstance();
		int result = tDao.loginCheck(tid, tpw);
		if(result == TeacherDao.LOGIN_SUCCESS) {
			HttpSession httpSession = request.getSession();
			TeacherDto teacher = tDao.getTeacher(tid);
			httpSession.setAttribute("teacher", teacher);
			request.setAttribute("teacherLoginResult", "관리자계정으로 들어오셨습니다");
		}else {
			request.setAttribute("teacherLoginErrorMsg", "관리자계정 로그인이 실패되었습니다");
		}

	}

}