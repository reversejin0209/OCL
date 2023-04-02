package com.lec.ocl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.ocl.dao.StudentDao;
import com.lec.ocl.dto.StudentDto;

public class SPWfindService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String sname = request.getParameter("sname");
		String semail = request.getParameter("semail");
		String sid = request.getParameter("sid");
		StudentDao sDao = StudentDao.getInstance();
		int result = sDao.snmicheck(sname, semail, sid);
		if(result == sDao.SUCCESS) {
			HttpSession session = request.getSession();
			StudentDto student = sDao.getStudent(sid);
			session.setAttribute("student", student);
		}
	}
}
