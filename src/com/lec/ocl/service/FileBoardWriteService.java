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
import javax.servlet.http.HttpSession;

import com.lec.ocl.dao.FileBoardDao;
import com.lec.ocl.dto.FileBoardDto;
import com.lec.ocl.dto.StudentDto;
import com.lec.ocl.dto.TeacherDto;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class FileBoardWriteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getRealPath("fileBoardUp");
		int maxSize = 1024*1024*10; // 최대 업로드 사이즈가 10M
		MultipartRequest mRequest = null;
		String ffileName = "";
		try {
			mRequest = new MultipartRequest(request, path, maxSize, "utf-8", new DefaultFileRenamePolicy());
			Enumeration<String> params = mRequest.getFileNames();
			String param = params.nextElement();
			ffileName = mRequest.getFilesystemName(param);
			HttpSession httpSession = request.getSession();
			StudentDto student = (StudentDto) httpSession.getAttribute("student"); // 사용자 로그인 
			TeacherDto teacher = (TeacherDto) httpSession.getAttribute("teacher"); // 관리자 로그인
			if(student!=null) {
				String sid = student.getSid();
				String ftitle = mRequest.getParameter("ftitle");
				String fcontent = mRequest.getParameter("fcontent");
				String fip = request.getRemoteAddr();
				FileBoardDao Fdao = FileBoardDao.getInstance();
				FileBoardDto Fdto = new FileBoardDto(0, sid, null, null, null, ftitle, fcontent, ffileName, null, maxSize, 0, 0, 0, fip);
				int result = Fdao.writeBoardSid(Fdto);
				if(result == FileBoardDao.SUCCESS) {
					request.setAttribute("boardResult", "사용자 글쓰기 성공");
				}else {
					request.setAttribute("boardResult", "사용자 글쓰기 성공");
				}
			}else if(teacher!=null) {
				String tid = teacher.getTid();
				String ftitle = mRequest.getParameter("ftitle");
				String fcontent = mRequest.getParameter("fcontent");
				String fip = request.getRemoteAddr();
				FileBoardDao Fdao = FileBoardDao.getInstance();
				FileBoardDto Fdto = new FileBoardDto(0, null, null, tid, null, ftitle, fcontent, ffileName, null, maxSize, 0, 0, 0, fip);
				int result = Fdao.writeBoardTid(Fdto);
				if(result == FileBoardDao.SUCCESS) {
					request.setAttribute("boardResult", "선생 글쓰기 성공");
				}else {
					request.setAttribute("boardResult", "사용자 글쓰기 성공");
				}
			}
		} catch (IOException e) {
			System.out.println(e.getMessage());
			request.setAttribute("boardResult", " 글쓰기 실패");
	}
	// 서버에 올라간 fileboardUp 파일을 소스폴더에 filecopy
		if(ffileName!=null) {
			InputStream  is = null;
			OutputStream os = null;
			try {
				File serverFile = new File(path+"/"+ffileName);
				is = new FileInputStream(serverFile);
				//os = new FileOutputStream("D:/JINYOONJIN/source/08_1stProject/ocl/WebContent/fileBoardUp/"+ffileName);
				os = new FileOutputStream("C:/webPro/08_1stProject/ocl/WebContent/fileBoardUp/"+ffileName);
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
