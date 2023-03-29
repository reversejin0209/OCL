package com.lec.ocl.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.lec.ocl.dao.FileBoardDao;
import com.lec.ocl.dto.FileBoardDto;

public class FileBoardDao {
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	private DataSource ds;
	// 싱글톤
	private static FileBoardDao instance = new FileBoardDao();

	public static FileBoardDao getInstance() {
		return instance;
	}

	private FileBoardDao() {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle11g");
		} catch (NamingException e) {
			System.out.println(e.getMessage());
		}

	}

	// (1) 게시판 글목록
	public ArrayList<FileBoardDto> listBoard(int startRow, int endRow) {
		ArrayList<FileBoardDto> dtos = new ArrayList<FileBoardDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT F.*," + 
				"    (SELECT SNAME FROM STUDENT WHERE F.SID = SID)SNAME," + 
				"    (SELECT TNAME FROM TEACHER WHERE F.TID = TID)TNAME" + 
				"    FROM (SELECT ROWNUM RN, B.*" + 
				"        FROM (SELECT * FROM FILEBOARD ORDER BY FGROUP DESC, FSTEP) B)F" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int fno = rs.getInt("fno");
				String sid = rs.getString("sid");
				String sname = rs.getString("sname");
				String tid = rs.getString("tid");
				String tname = rs.getString("tname");
				String ftitle = rs.getString("ftitle");
				String fcontent = rs.getString("fcontent");
				String ffileName = rs.getString("ffileName");
				Timestamp frdate = rs.getTimestamp("frdate");
				int fhit = rs.getInt("fhit");
				int fgroup = rs.getInt("fgroup");
				int fstep = rs.getInt("fstep");
				int findent = rs.getInt("findent");
				String fip = rs.getString("fip");
				dtos.add(new FileBoardDto(fno, sid, sname, tid, tname, ftitle, fcontent, ffileName, frdate, fhit,
						fgroup, fstep, findent, fip));
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " listBoard에서 오류");
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return dtos;
	}

	// (2) 게시판 글갯수
	public int getBoardTotCnt() {
		int totCnt = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM FILEBOARD";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " getBoardTotCnt에서 오류");
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return totCnt;
	}

	// (3) 게시판 글쓰기(원글쓰기)
	public int writeBoardTid(FileBoardDto dto) { // 선생
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO FILEBOARD(FNO, TID, FTITLE, FCONTENT, FFILENAME, fGROUP, FSTEP, FINDENT, FIP)"
				+ "    VALUES(FILEBOARD_SEQ.NEXTVAL, ?, ?, ?, ?" + "      , FILEBOARD_SEQ.CURRVAL, 0, 0, ?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTid());
			pstmt.setString(2, dto.getFtitle());
			pstmt.setString(3, dto.getFcontent());
			pstmt.setString(4, dto.getFfileName());
			pstmt.setString(5, dto.getFip());
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("선생 글쓰기 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " 선생 글쓰기 실패 :");
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// (3-1) 게시판 글쓰기(원글쓰기)
	public int writeBoardSid(FileBoardDto dto) { // 학생
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO FILEBOARD(FNO, SID, FTITLE, FCONTENT, FFILENAME, fGROUP, FSTEP, FINDENT, FIP)"
				+ "    VALUES(FILEBOARD_SEQ.NEXTVAL, ?, ?, ?, ?" + "      , FILEBOARD_SEQ.CURRVAL, 0, 0, ?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getSid());
			pstmt.setString(2, dto.getFtitle());
			pstmt.setString(3, dto.getFcontent());
			pstmt.setString(4, dto.getFfileName());
			pstmt.setString(5, dto.getFip());
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("학생 글쓰기 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " 학생 글쓰기 실패 :");
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// (4) 게시판 hit 1회 올리기
	private void hitUpBoard(int fno) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE FILEBOARD SET FHIT = FHIT +1" + 
				"    WHERE FNO = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fno);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " 조회수 up 실패");
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
	}

	// (5) 게시판 글번호(FNO)로 글 전체 내용 (FileBoardDto)가져오기 - 글 상세보기용
	public FileBoardDto contentBoard(int fno) {
		FileBoardDto dto = null;
		hitUpBoard(fno); // 글 상세보기 시 조회수 1 올리기
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT F.*," + 
				"    (SELECT SNAME FROM STUDENT WHERE F.SID = SID)SNAME," + 
				"    (SELECT TNAME FROM TEACHER WHERE F.TID = TID)TNAME" + 
				"    FROM (SELECT ROWNUM RN, B.*" + 
				"        FROM (SELECT * FROM FILEBOARD ORDER BY FRDATE DESC) B)F" + 
				"    WHERE FNO=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String sid = rs.getString("sid");
				String sname = rs.getString("sname");
				String tid = rs.getString("tid");
				String tname = rs.getString("tname");
				String ftitle = rs.getString("ftitle");
				String fcontent = rs.getString("fcontent");
				String ffileName = rs.getString("ffileName");
				Timestamp frdate = rs.getTimestamp("frdate");
				int fhit = rs.getInt("fhit");
				int fgroup = rs.getInt("fgroup");
				int fstep = rs.getInt("fstep");
				int findent = rs.getInt("findent");
				String fip = rs.getString("fip");
				dto = new FileBoardDto(fno, sid, sname, tid, tname, ftitle, fcontent, ffileName, frdate, fhit, fgroup,
						fstep, findent, fip);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " contentBoard에서 오류");
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return dto;
	}

	// (6) 게시판 글번호(FNO)로 글전체 내용(FileBoardDto) 가져오기 - 글수정VIEW, 답변글VIEW 용
	public FileBoardDto modifyViewBoard_replyViewBoard(int fno) {
		FileBoardDto dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT F.*," + "    (SELECT SNAME FROM STUDENT WHERE F.SID = SID)SNAME,"
				+ "    (SELECT TNAME FROM TEACHER WHERE F.TID = TID)TNAME" + "    FROM (SELECT ROWNUM RN, B.*"
				+ "        FROM (SELECT * FROM FILEBOARD ORDER BY FRDATE DESC) B)F" + "    WHERE FNO=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String sid = rs.getString("sid");
				String sname = rs.getString("sname");
				String tid = rs.getString("tid");
				String tname = rs.getString("tname");
				String ftitle = rs.getString("ftitle");
				String fcontent = rs.getString("fcontent");
				String ffileName = rs.getString("ffileName");
				Timestamp frdate = rs.getTimestamp("frdate");
				int fhit = rs.getInt("fhit");
				int fgroup = rs.getInt("fgroup");
				int fstep = rs.getInt("fstep");
				int findent = rs.getInt("findent");
				String fip = rs.getString("fip");
				dto = new FileBoardDto(fno, sid, sname, tid, tname, ftitle, fcontent, ffileName, frdate, fhit, fgroup,
						fstep, findent, fip);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " modifyBoard에서 오류");
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return dto;
	}

	// (7) 글 수정하기(fid, ftitle, fcontent, ffilename, frdate(SYSDATE), fip 수정)
	public int modifyBoard(FileBoardDto dto) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE FILEBOARD " + 
				"    SET FTITLE = ?," + 
				"        FCONTENT = ?," + 
				"        Ffilename = ?," + 
				"        FIP = ?," + 
				"        FRDATE = SYSDATE" + 
				"    WHERE FNO = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getFtitle());
			pstmt.setString(2, dto.getFcontent());
			pstmt.setString(3, dto.getFfileName());
			pstmt.setString(4, dto.getFip());
			pstmt.setInt(5, dto.getFno());
			result = pstmt.executeUpdate();
			System.out.println(result == SUCCESS ? "글수정 성공" : "글번호(fno) 오류");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "글 수정 실패 ");
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}

	// (8) 게시판 글 삭제하기(메인글을 지우면 모든 답변까지 삭제됨)
	public int deleteBoard(int fgroup, int fstep, int findent) {
		int deleteCnt = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM FILEBOARD WHERE FGROUP=? AND (FSTEP>=? AND " + 
				"  FSTEP<(SELECT NVL(MIN(FSTEP),99999) FROM FILEBOARD WHERE FGROUP=? AND FSTEP>? AND FINDENT<=?))";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fgroup);
			pstmt.setInt(2, fstep);
			pstmt.setInt(3, fgroup);
			pstmt.setInt(4, fstep);
			pstmt.setInt(5, findent);
			deleteCnt = pstmt.executeUpdate();
			System.out.println(deleteCnt >= SUCCESS ? deleteCnt + "개 글삭제성공" : "글삭제실패");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " deleteBoard에서 오류");
			System.out.println(e.getMessage());
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return deleteCnt;
	}

	// (9) 게시판 답변글 저장전 작업
	private void preReplyBoardStep(int fgroup, int fstep) {
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE FILEBOARD SET FSTEP = FSTEP + 1 WHERE FGROUP=? AND FSTEP>?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fgroup);
			pstmt.setInt(2, fstep);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " preReplyStep에서 오류");
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			} 
		}
	}
	// (10) 답변글 쓰기
			//  답변글쓴이    : mid, ftitle, fcontent, ffilename
			//  시스템적으로 : fip
			//  원글             : fgroup, fstep, findent
		public int reply(FileBoardDto dto) {
			int result = FAIL;
			preReplyBoardStep(dto.getFgroup(), dto.getFstep());
			Connection        conn  = null;
			PreparedStatement pstmt = null;
			String sql = "INSERT INTO FILEBOARD(FNO, SID, TID, FTITLE, FCONTENT, FFILENAME, FGROUP, FSTEP, FINDENT, FIP)" + 
					"    VALUES(FILEBOARD_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getSid());
				pstmt.setString(2, dto.getTid());
				pstmt.setString(3, dto.getFtitle());
				pstmt.setString(4, dto.getFcontent());
				pstmt.setString(5, dto.getFfileName());
				pstmt.setInt(6, dto.getFgroup());
				pstmt.setInt(7, dto.getFstep() + 1);
				pstmt.setInt(8, dto.getFindent() + 1);
				pstmt.setString(9, dto.getFip());
				pstmt.executeUpdate();
				result = SUCCESS;
				System.out.println("답변글쓰기 성공");
			} catch (SQLException e) {
				System.out.println(e.getMessage() + " 답변글쓰기 실패 ");
			} finally {
				try {
					if(pstmt != null) pstmt.close();
					if(conn  != null) conn.close();
				} catch (SQLException e) {
					System.out.println(e.getMessage());
				} 
			}
			return result;
		}
	// (11) 회원 탈퇴시 발생하는 SID가 쓴 글 모두 삭제
		public int preWithdrawalMemberStep(String sid) {
			int cntBoard = 0;
			Connection        conn  = null;
			PreparedStatement pstmt = null;
			String sql = "DELETE FROM FILEBOARD WHERE SID=?";
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, sid);
				cntBoard = pstmt.executeUpdate();
				System.out.println(cntBoard+"개글 삭제 성공(회원탈퇴전)");
			} catch (SQLException e) {
				System.out.println(e.getMessage() + "탈퇴 전 글 삭제 실패 ");
			} finally {
				try {
					if(pstmt != null) pstmt.close();
					if(conn  != null) conn.close();
				} catch (SQLException e) {
					System.out.println(e.getMessage());
				} 
			}
			return cntBoard;
		}
	}