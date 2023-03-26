package com.lec.ocl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.ocl.dao.StudentDao;
import com.lec.ocl.dto.StudentDto;

public class SLoginService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("next", request.getParameter("next"));
		String sid = request.getParameter("sid");
		String spw = request.getParameter("spw");
		StudentDao sDao = StudentDao.getInstance();
		int result = sDao.loginCheck(sid, spw);
		if(result==StudentDao.LOGIN_SUCCESS) { // 로그인 성공
			HttpSession session = request.getSession();
			StudentDto student = sDao.getStudent(sid);
			session.setAttribute("student", student);
		}else {
			request.setAttribute("loginErrorMsg", "아이디 또는 비밀번호 오류입니다");
		}
	}

}
