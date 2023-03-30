package com.lec.ocl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.ocl.dao.NoticeDao;
import com.lec.ocl.dto.NoticeDto;

public class NoticeDeleteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		  int nno = Integer.parseInt(request.getParameter("nno").trim());
		  NoticeDao Ndao = NoticeDao.getInstance();
		  int result = Ndao.deleteNotice(nno);
		  if(result == NoticeDao.SUCCESS) {
			  request.setAttribute("NoticeResult", "공지사항 삭제성공");
		  }else {
			  request.setAttribute("NoticeResult", "공지사항 삭제실패");
		  }
	}
}
