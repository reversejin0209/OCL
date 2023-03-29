package com.lec.ocl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.ocl.dao.FileBoardDao;

public class FileBoardDeleteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// 삭제하고자 하는 글과 답변글 모두 삭제 
		int fgroup = Integer.parseInt(request.getParameter("fgroup"));
		int fstep = Integer.parseInt(request.getParameter("fstep"));
		int findent = Integer.parseInt(request.getParameter("findent"));
		FileBoardDao Fdao = FileBoardDao.getInstance();
		int deleteCnt = Fdao.deleteBoard(fgroup, fstep, findent);
		if(deleteCnt >= FileBoardDao.SUCCESS) {
			request.setAttribute("boardResult", "글(답변글 포함 "+deleteCnt+"개 글)이 삭제되었습니다");
		}else {
			request.setAttribute("boardResult", "글(답변글도 모두) 삭제 안 됨");
		}
	}
}