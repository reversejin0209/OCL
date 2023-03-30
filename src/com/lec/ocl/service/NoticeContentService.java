package com.lec.ocl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.ocl.dao.NoticeDao;
import com.lec.ocl.dto.NoticeDto;

public class NoticeContentService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int nno = Integer.parseInt(request.getParameter("nno"));
		NoticeDao Ndao = NoticeDao.getInstance();
		NoticeDto NoticeBoard = Ndao.contentNotice(nno);
		request.setAttribute("NoticeBoard", NoticeBoard);
	}
}
