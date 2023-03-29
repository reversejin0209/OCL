package com.lec.ocl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.ocl.dao.StudentDao;

public class SidConfirmService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String sid = request.getParameter("sid");
		StudentDao Sdao = StudentDao.getInstance();
		int result = Sdao.sidConfirm(sid);
		if(result == StudentDao.EXISTENT) {
			request.setAttribute("sidConfirmResult", "<b>중복된 ID</b>");
		}else {
			request.setAttribute("sidConfirmResult", "사용 가능한 ID");
		}
	}

}
