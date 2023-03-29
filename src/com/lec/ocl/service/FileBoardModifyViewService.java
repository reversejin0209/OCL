package com.lec.ocl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.ocl.dao.FileBoardDao;
import com.lec.ocl.dao.StudentDao;
import com.lec.ocl.dto.FileBoardDto;

public class FileBoardModifyViewService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int fno = Integer.parseInt(request.getParameter("fno"));
		FileBoardDao Fdao = FileBoardDao.getInstance();
		FileBoardDto FileBoard = Fdao.modifyViewBoard_replyViewBoard(fno);
		request.setAttribute("FileBoard", FileBoard);
	}

}
