package com.lec.ocl.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.ocl.dao.GalleryDao;
import com.lec.ocl.dto.GalleryDto;

public class GalleryListService implements Service {

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
			int currentPage = Integer.parseInt(pageNum);
			final int PAGESIZE = 10, BLOCKSIZE=10;
			int startRow = (currentPage-1) * PAGESIZE +1;
			int endRow = startRow + PAGESIZE -1;
			GalleryDao Gdao = GalleryDao.getInstance();
			ArrayList<GalleryDto> Gallery = Gdao.listGallery(startRow, endRow);
			request.setAttribute("Gallery", Gallery);
			int totCnt = Gdao.getGalleryTotCnt(); // (글갯수)
			int pageCnt = (int) Math.ceil((double)totCnt/PAGESIZE); // 페이지갯수
			int startPage = ((currentPage-1)/BLOCKSIZE)*BLOCKSIZE+1;
			int endPage = startPage + BLOCKSIZE -1;
			if(endPage>pageCnt) {
				endPage = pageCnt;
			}
			request.setAttribute("BLOCKSIZE", BLOCKSIZE);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("pageCnt", pageCnt);
			request.setAttribute("totCnt", totCnt);
			request.setAttribute("pageNum", currentPage);
		}
	}
