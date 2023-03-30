package com.lec.ocl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.ocl.dao.GalleryDao;
import com.lec.ocl.dto.GalleryDto;

public class GalleryModifyViewService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int gno = Integer.parseInt(request.getParameter("gno"));
		GalleryDao Gdao = GalleryDao.getInstance();
		GalleryDto Gallery = Gdao.modifyViewGallery(gno);
		request.setAttribute("Gallery", Gallery);
	}

}
