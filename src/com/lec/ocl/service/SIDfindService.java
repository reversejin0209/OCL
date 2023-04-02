package com.lec.ocl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.ocl.dao.StudentDao;
import com.lec.ocl.dto.StudentDto;
import com.sun.xml.internal.ws.api.ha.StickyFeature;

public class SIDfindService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
			String sname = request.getParameter("sname");
			String semail = request.getParameter("semail");
			StudentDao Sdao = StudentDao.getInstance();
			int result = Sdao.snmcheck(sname, semail);
			if(result == Sdao.SUCCESS) {
				HttpSession session = request.getSession();
				StudentDto student = Sdao.getSname(sname);
				session.setAttribute("student", student);
			}
		}
	}
