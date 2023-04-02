package com.lec.ocl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.ocl.dao.NoticeDao;

public class NoticeDeleteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int nno = Integer.parseInt(request.getParameter("nno"));
		NoticeDao Ndao = NoticeDao.getInstance();
		int result = Ndao.deleteNotice(nno);
		if(result == Ndao.SUCCESS) {
			request.setAttribute("NoticeResult", "공지사항 삭제성공");
		}else {
			request.setAttribute("NoticeResult", "공지사항 삭제실패");
		}
	}
}