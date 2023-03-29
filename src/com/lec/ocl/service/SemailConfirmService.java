package com.lec.ocl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.ocl.dao.StudentDao;

public class SemailConfirmService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String semail = request.getParameter("semail");
		StudentDao sDao = StudentDao.getInstance();
		int result = sDao.semailConfirm(semail);
		if(result == StudentDao.EXISTENT) {
			request.setAttribute("semailConfirmResult", "<b>사용 불가한 중복된 메일</b>");
		}else{
			request.setAttribute("semailConfirmResult","사용 가능한 메일");
		}
	}

}
