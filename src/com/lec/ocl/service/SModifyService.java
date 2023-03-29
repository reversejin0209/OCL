package com.lec.ocl.service;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
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
public class SModifyService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getRealPath("studentPhotoUp");
		int    maxSize = 1024 * 1024; // 최대 업로드 사이즈 1M
		String sphoto = ""; // 첨부 파일 이름이 저장될 변수
		int result = StudentDao.FAIL;
		try {
			// mRequest 객체 생성(서버에 업로드된 파일 저장) 후, 파일 이름 받아오기
			MultipartRequest mRequest = new MultipartRequest(request, path, maxSize, 
										"utf-8", new DefaultFileRenamePolicy());
			Enumeration<String> params = mRequest.getFileNames();
			//while(params.hasMoreElements()) {
				String param = params.nextElement(); // param이 "mphoto"
				sphoto = mRequest.getFilesystemName(param);
			//}
			// 파라미터 받아 DB에 수정 적용
			String dbSpw = mRequest.getParameter("dbSpw");
			String dbSphoto = mRequest.getParameter("dbSphoto");
			// hidden으로 넘어온 dbMpw, dbMphoto가 없을 경우
//			HttpSession session = request.getSession();
//			String sessionMpw=null, sessionMphoto=null;
//			MemberDto sesionMember = (MemberDto)session.getAttribute("member");
//			if(member!=null) {
//				sessionMpw = sesionMember.getMpw();
//				sessionMphoto = sesionMember.getMphoto();
//			}
			String sid      = mRequest.getParameter("sid");
			// oldMpw는 modify.jsp에서 함
//			String oldMpw   = mRequest.getParameter("oldMpw");
//			if(!oldMpw.equals(dbMpw)) {
//				request.setAttribute("modifyErrorMsg", "현비밀번호를 확인하세요");
//				return;
//			}
			String spw = mRequest.getParameter("spw");
			if(spw.equals("")) { // 정보 수정시 새비밀번호를 입력하지 않을 경우, 현비밀번호(dbMpw)로 
				spw = dbSpw;
			}
			String sname = mRequest.getParameter("sname");
			String snumber = mRequest.getParameter("snumber");
			Date sbirth = null;
			String sbirthStr = mRequest.getParameter("sbirth");
			if(!sbirthStr.equals("")) {
				sbirth = Date.valueOf(sbirthStr);
			}
			String semail = mRequest.getParameter("semail");
			// 정보 수정시 사진첨부 안 하면, 기존의 사진(dbMphoto)으로
			sphoto = sphoto==null? dbSphoto : sphoto;
			String sgender = mRequest.getParameter("sgender");
			String saddress = mRequest.getParameter("saddress");
			// 회원정보 수정
			StudentDao sDao = StudentDao.getInstance();
			StudentDto student = new StudentDto(sid, spw, sname, snumber, sbirth, null, semail, dbSphoto, sgender, saddress);
			result = sDao.modifyMember(student);
			if(result == sDao.SUCCESS) { // 수정 성공시 세션도 수정
				HttpSession session = request.getSession();
				session.setAttribute("student", student);
				request.setAttribute("modifyResult", "회원정보 수정 성공");
			}else { // 수정 실패시
				request.setAttribute("modifyErrorMsg", "회원정보 수정 실패");
			}
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
		//서버에 저장된 파일을 소스 폴더로 복사(파일명이 NOIMG.JPG거나 result가 FAIL이 아닐 경우) 
		File serverFile = new File(path+"/"+sphoto);
		if(!sphoto.equals("NOIMG.JPG") && result==StudentDao.SUCCESS) {
			InputStream is = null;
			OutputStream os = null;
			try {
				is = new FileInputStream(serverFile);
				//os = new FileOutputStream("D:/webPro/source/07_jQuery/model2ex/WebContent/studentPhotoUp/"+sphoto);
				os = new FileOutputStream("D:/JINYOONJIN/source/08_1stProject/ocl/WebContent/studentPhotoUp/"+sphoto);
				byte[] bs = new byte[(int)serverFile.length()];
				while(true) {
					int readByteCnt = is.read(bs);
					if(readByteCnt==-1) break;
					os.write(bs, 0, readByteCnt);
				}
				System.out.println("첨부된 파일("+sphoto+") 복사 완료");
			} catch (IOException e) {
				System.out.println(e.getMessage());
			} finally {
				try {
					if(os!=null) os.close();
					if(is!=null) is.close();
				}catch (IOException e) {
					System.out.println(e.getMessage()+"파일 업로드 실패");
				}
			}// try-catch-finally
		}//if-파일 복사
	}// execute()
}
