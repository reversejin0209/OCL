package com.lec.ocl.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.ocl.dao.GalleryDao;
import com.lec.ocl.dto.GalleryDto;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class GalleryModifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// 파일첨부 로직 + 파라미터들 받아 DB에 join
		String path = request.getRealPath("GalleryBoardUp");
		int maxSize = 1024*1024*10; // 최대업로드 사이즈는 10M
		String gfileName = "", dbGfileName = null;
		try {
			MultipartRequest mRequest = new MultipartRequest(request, path, maxSize, "utf-8", new DefaultFileRenamePolicy());
			Enumeration<String> params = mRequest.getFileNames();
			String param = params.nextElement();
			gfileName = mRequest.getFilesystemName(param);
			dbGfileName = mRequest.getParameter("dbGfileName");
			if(gfileName==null) {
				gfileName = dbGfileName;
			}
			int gno = Integer.parseInt(mRequest.getParameter("gno"));
			String gtitle = mRequest.getParameter("gtitle");
			String gcontent = mRequest.getParameter("gcontent");
			String gip = request.getRemoteAddr();
			GalleryDao Gdao = GalleryDao.getInstance();
			GalleryDto dto = new GalleryDto(gno, null, null, null, null, gtitle, gcontent, dbGfileName, null, 0, gip);
			int result = Gdao.modifyGallery(dto);
			if(result == Gdao.SUCCESS) { 
				request.setAttribute("GalleryResult", "앨범수정 성공");
			}else {
				request.setAttribute("GalleryResult", "앨범수정 실패");
			}
			// mRequest에서 넘어온 pageNum(mRequest를 사용하면 request의 파라미터들이 다 null이 됨)을 request에 set
			request.setAttribute("pageNum", mRequest.getParameter("pageNum"));
		} catch (IOException e) {
			System.out.println(e.getMessage());
			request.setAttribute("boardResult", "글수정 실패");
		}
		// 서버에 올라간 fileboardUp 파일을 소스폴더에 filecopy (파일 수정을 안 했거나, 예외가 떨어질 경우 복사 안 함)
		if(dbGfileName!=null && !gfileName.equals(dbGfileName)) { 
			InputStream  is = null;
			OutputStream os = null;
			try {
				File serverFile = new File(path+"/"+gfileName);
				is = new FileInputStream(serverFile);
				//os = new FileOutputStream("D:/JINYOONJIN/source/08_1stProject/ocl/WebContent/fileBoardUp/"+gfileName);
				 os = new FileOutputStream("C:/webPro/08_1stProject/ocl/WebContent/GalleryBoardUp/"+gfileName);
				 
				byte[] bs = new byte[(int)serverFile.length()];
				while(true) {
					int nByteCnt = is.read(bs);
					if(nByteCnt==-1) break;
				}
			} catch (Exception e) {
				System.out.println(e.getMessage());
			} finally {
				try {
					if(os!=null) os.close();
					if(is!=null) is.close();
				} catch (Exception e) {
					System.out.println(e.getMessage());
				}
			} // try
		}// 파일 복사 if	}
	}
}


