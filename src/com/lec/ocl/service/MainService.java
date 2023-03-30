package com.lec.ocl.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.ocl.dao.FileBoardDao;
import com.lec.ocl.dao.NoticeDao;
import com.lec.ocl.dto.FileBoardDto;
import com.lec.ocl.dto.NoticeDto;

public class MainService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) {
			if(request.getAttribute("pageNum")!=null) {
				pageNum = (String) request.getAttribute("pageNum");
			}else {
				pageNum = "1";
			}
		}
		request.setAttribute("pageNum", pageNum);
		// 공지사항 리스트 가져와서 setAttribute
		NoticeDao noticeDao = NoticeDao.getInstance();
		ArrayList<NoticeDto> noticeMain = noticeDao.listNotice(1, 6);
		request.setAttribute("noticeMain", noticeMain);
		// 게시판 리스트 가져와서 setAttribute 
		FileBoardDao Fdao= FileBoardDao.getInstance();
		ArrayList<FileBoardDto> FileBoardMain = Fdao.listBoard(1, 6);
		request.setAttribute("FileBoardMain", FileBoardMain);
	}

}
