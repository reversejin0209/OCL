package com.lec.ocl.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.ocl.dao.StudentDao;
import com.lec.ocl.dto.StudentDto;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class SJoinService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getRealPath("fileBoardUp");
		int maxSize = 1024*1024*10; // 사진 업로드 제한 용량 : 10M
		String sphoto = ""; // 첨부된 파일이 저장된 파일 이름
		// mRequest 객체 생성 후 sPhoto 파일이름 얻어옴
		MultipartRequest mRequest = null;
		int result = 0; // 회원가입 결과를 저장할 변수(가입성공시 1, 실패시 0저장)
		try {
			// 첨부된 파일을 서버에 저장하고, 파일이름(sphoto) 가져오기
			mRequest = new MultipartRequest(request, path, maxSize,
								"utf-8", new DefaultFileRenamePolicy());
			Enumeration<String> params = mRequest.getFileNames();
			//while(params.hasMoreElements()) {
				String param = params.nextElement();
				sphoto = mRequest.getFilesystemName(param);
			//}
			// mRequest을 이용하여 파라미터 받아와서 DB 저장
			String sid = mRequest.getParameter("sid");
			String spw = mRequest.getParameter("spw");
			String sname = mRequest.getParameter("sname");
			String snumber = mRequest.getParameter("snumber");
			String sbirthStr = mRequest.getParameter("sbirth");
			Date sbirth = null;
			if(!sbirthStr.equals("")) {
				sbirth = Date.valueOf(sbirthStr);
			}
			String semail = mRequest.getParameter("semail");
			sphoto = sphoto==null ? "NOIMG.JPG" : sphoto;
			String sgender = mRequest.getParameter("sgender");
			String saddress = mRequest.getParameter("saddress");
			StudentDao sDao = StudentDao.getInstance();
			// sid 중복 체크
			result = sDao.sidConfirm(sid);
			if(result == StudentDao.NONEXISTENT) { // 가입 가능한 sID니까 회원가입
				StudentDto student = new StudentDto(sid, spw, sname, snumber, sbirth, null, semail, sphoto, sgender, saddress);
				// 회원가입
				result = sDao.joinStudent(student);
				if(result == StudentDao.SUCCESS) {
					HttpSession session = request.getSession(); // 세션은 request로 부터
					session.setAttribute("sid", sid);
					request.setAttribute("joinResult", "회원가입이 완료되었습니다");
				}else {
					request.setAttribute("joinErrorMsg", "정보가 너무 길어서 회원가입 실패");
				}
			}else {
				request.setAttribute("joinErrorMsg", "중복된 ID는 회원가입이 불가합니다");
			}
		} catch (IOException e) {
			System.out.println(e.getMessage());
			request.setAttribute("joinErrorMsg", "첨부 파일의 용량이 너무 큽니다. 1M가 이내로 업로드 해 주세요");
		}
		
		// 서버에 업로드된 파일을 소스 폴더로 복사
		File serverFile = new File(path + "/" + sphoto);
		if(serverFile.exists() && !sphoto.equals("NOIMG.JPG") && result==StudentDao.SUCCESS) {
			InputStream is = null;
			OutputStream os = null;
			try {
				is = new FileInputStream(serverFile);
				os = new FileOutputStream("D:/JINYOONJIN/source/08_1stProject/ch08_1stProject/WebContent/fileBoardUp/"+sphoto);
				byte[] bs = new byte[(int) serverFile.length()];
				while(true) {
					int readByteCnt = is.read(bs);
					if(readByteCnt==-1) break;
					os.write(bs, 0, readByteCnt);
				}
			} catch (IOException e) {
				System.out.println(e.getMessage());
			}finally {
				try {
					if(os!=null) os.close();
					if(is!=null) is.close();
				} catch (IOException e) {
					System.out.println(e.getMessage());
				}
			}
		}// if - 파일 복사 
	}
}