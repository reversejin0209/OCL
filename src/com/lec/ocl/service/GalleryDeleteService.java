package com.lec.ocl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.ocl.dao.GalleryDao;

public class GalleryDeleteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int gno = Integer.parseInt(request.getParameter("gno"));
		GalleryDao Gdao = GalleryDao.getInstance();
		int result = Gdao.deleteGallery(gno);
		if(result == Gdao.SUCCESS) {
			request.setAttribute("GalleryResult", "앨범 글삭제 성공");
		}else {
			request.setAttribute("GalleryResult", "앨범 글삭제 실패");
		}
	}
}