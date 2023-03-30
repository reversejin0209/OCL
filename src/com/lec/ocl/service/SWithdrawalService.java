package com.lec.ocl.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.ocl.dao.FileBoardDao;
import com.lec.ocl.dao.StudentDao;
import com.lec.ocl.dto.StudentDto;

public class SWithdrawalService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String sid = null;
		StudentDto sessionStudent = (StudentDto) session.getAttribute("student");
		if(sessionStudent!=null) {
			sid = sessionStudent.getSid();
		}
		FileBoardDao FDao = FileBoardDao.getInstance();
		int cnt = FDao.preWithdrawalStudentStep(sid); // 탈퇴할 회원의 글 모두 삭제
		StudentDao sDao = StudentDao.getInstance();
		int result = sDao.withdrawalStudent(sid); // 회원탈퇴
		session.invalidate(); // 세션 삭제
		if(result == StudentDao.SUCCESS) {
			request.setAttribute("withdrawalResult", "회원 탈퇴가 완료되었습니다. 그 동안 작성하신 게시물" + cnt+" 개가 모두 삭제되었습니다.");
		}else {
			request.setAttribute("withdrawalResult", "로그인이 되어 있지 않습니다");
		}
	}
}






