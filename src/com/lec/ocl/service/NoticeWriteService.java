package com.lec.ocl.service;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.ocl.dao.NoticeDao;
import com.lec.ocl.dto.NoticeDto;
import com.lec.ocl.dto.TeacherDto;


public class NoticeWriteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession httpSession = request.getSession();
		TeacherDto teacher = (TeacherDto) httpSession.getAttribute("teacher"); // 선생로그인
		if (teacher != null) {
			String tid = teacher.getTid();
			String ntitle = request.getParameter("ntitle");
			String ncontent = request.getParameter("ncontent");
			String nip = request.getRemoteAddr();
			NoticeDao Ndao = NoticeDao.getInstance();
			NoticeDto dto = new NoticeDto(0, null, null, tid, null, ntitle, ncontent, null, 0, nip);
			int result = Ndao.writeNotice(dto);
			if (result == NoticeDao.SUCCESS) {
				request.setAttribute("NoticeResult", "공지가 등록되었습니다");
			} else {
				request.setAttribute("NoticeResult", "공지 등록에 실패하였습니다");
			}
		}
	}
}
