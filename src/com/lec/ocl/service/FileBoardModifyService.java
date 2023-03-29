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

import com.lec.ocl.dao.FileBoardDao;
import com.lec.ocl.dto.FileBoardDto;
import com.lec.ocl.dto.StudentDto;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class FileBoardModifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// 파일첨부 로직 + 파라미터들 받아 DB에 join
		String path = request.getRealPath("fileBoardUp");
		int maxSize = 1024*1024*10; // 최대업로드 사이즈는 10M
		String ffileName = "", dbFileName = null;
		try {
			MultipartRequest mRequest = new MultipartRequest(request, path, maxSize, "utf-8", new DefaultFileRenamePolicy());
			Enumeration<String> params = mRequest.getFileNames();
			String param = params.nextElement();
			ffileName = mRequest.getFilesystemName(param);
			dbFileName = mRequest.getParameter("dbFileName");
			if(ffileName==null) {
				ffileName = dbFileName;
			}
			// mId, fTitle, fContent,  fileName, fIp
			int fno = Integer.parseInt(mRequest.getParameter("fno"));
			String ftitle = mRequest.getParameter("ftitle");
			String fcontent = mRequest.getParameter("fcontent");
			String fip = request.getRemoteAddr();
			FileBoardDao Fdao = FileBoardDao.getInstance();
			FileBoardDto dto = new FileBoardDto(fno, null, null, null, null, ftitle, fcontent, ffileName, null, 0, 0, 0, 0, fip);
			int result = Fdao.modifyBoard(dto);
			if(result == Fdao.SUCCESS) { 
				request.setAttribute("boardResult", "글수정 성공");
			}else {
				request.setAttribute("boardResult", "글수정 실패");
			}
			// mRequest에서 넘어온 pageNum(mRequest를 사용하면 request의 파라미터들이 다 null이 됨)을 request에 set
			request.setAttribute("pageNum", mRequest.getParameter("pageNum"));
		} catch (IOException e) {
			System.out.println(e.getMessage());
			request.setAttribute("boardResult", "글수정 실패");
		}
		// 서버에 올라간 fileboardUp 파일을 소스폴더에 filecopy (파일 수정을 안 했거나, 예외가 떨어질 경우 복사 안 함)
		if(dbFileName!=null && !ffileName.equals(dbFileName)) { 
			InputStream  is = null;
			OutputStream os = null;
			try {
				File serverFile = new File(path+"/"+ffileName);
				is = new FileInputStream(serverFile);
				//os = new FileOutputStream("D:/webPro/source/07_jQuery/model2ex/WebContent/fileBoardUp/"+ffileName);
				os = new FileOutputStream("D:/JINYOONJIN/source/08_1stProject/ocl/WebContent/fileBoardUp/"+ffileName);
				byte[] bs = new byte[(int)serverFile.length()];
				while(true) {
					int nByteCnt = is.read(bs);
					if(nByteCnt==-1) break;
					os.write(bs, 0, nByteCnt);
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
		}// 파일 복사 if
	}
}