package com.lec.ocl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.ocl.dao.FileBoardDao;
import com.lec.ocl.dto.FileBoardDto;

public class FileBoardReplyViewService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int fno = Integer.parseInt(request.getParameter("fno"));
		FileBoardDao Fdao = FileBoardDao.getInstance();
		FileBoardDto originBoard = Fdao.modifyViewBoard_replyViewBoard(fno);
		request.setAttribute("originBoard", originBoard); // 답변글을 달려는 글의 원글정보    
	}

}
