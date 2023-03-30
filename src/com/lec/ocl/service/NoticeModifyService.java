package com.lec.ocl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.ocl.dao.NoticeDao;
import com.lec.ocl.dto.NoticeDto;

public class NoticeModifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int nno = Integer.parseInt(request.getParameter("nno"));
		String tid = request.getParameter("tid");
		String ntitle = request.getParameter("ntitle");
		String ncontent = request.getParameter("ncontent");
		String nip = request.getRemoteAddr();
		NoticeDao Ndao = NoticeDao.getInstance();
		NoticeDto dto = new NoticeDto(nno, null, null, tid, null, ntitle, ncontent, null, 0, nip);
		int result = Ndao.modifyNotice(dto);
		if(result == Ndao.SUCCESS) {
			request.setAttribute("NoticeResult", "공지 수정 성공");
		}else {
			request.setAttribute("NoticeResult", "공지 수정 실패");
		}
	}
}
