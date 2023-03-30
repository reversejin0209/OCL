package com.lec.ocl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.ocl.dao.FileBoardDao;
import com.lec.ocl.dao.GalleryDao;
import com.lec.ocl.dto.FileBoardDto;
import com.lec.ocl.dto.GalleryDto;

public class GalleryContentService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int gno = Integer.parseInt(request.getParameter("gno"));
		GalleryDao Gdao = GalleryDao.getInstance();
		GalleryDto GalleryCt = Gdao.contentGallery(gno);
		request.setAttribute("GalleryCt", GalleryCt);
	}

}
