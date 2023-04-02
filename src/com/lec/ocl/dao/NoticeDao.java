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

import com.lec.ocl.dto.FileBoardDto;
import com.lec.ocl.dto.GalleryDto;
import com.lec.ocl.dto.NoticeDto;

public class NoticeDao {
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	private DataSource ds;
	// 싱글톤
	private static NoticeDao instance = new NoticeDao();
	
	public static NoticeDao getInstance() {
		return instance;
	}
	private NoticeDao() {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle11g");
		} catch (NamingException e) {
			System.out.println(e.getMessage());
		}
	}
	// (1) 공지사항등록
	public int writeNotice(NoticeDto dto) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO NOTICE(NNO, TID, NTITLE, NCONTENT, NIP)" + 
				"    VALUES(NOTICE_SEQ.NEXTVAL, ?, ?, ?, ?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTid());
			pstmt.setString(2, dto.getNtitle());
			pstmt.setString(3, dto.getNcontent());
			pstmt.setString(4, dto.getNip());
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("공지사항쓰기 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "공지사항쓰기 실패 :");
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
	// (2) 공지사항 리스트 (top - n)
	public ArrayList<NoticeDto> listNotice(int startRow, int endRow) {
		ArrayList<NoticeDto> dtos = new ArrayList<NoticeDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT N.*," + 
				"    (SELECT SNAME FROM STUDENT WHERE N.SID = SID)SNAME," + 
				"    (SELECT TNAME FROM TEACHER WHERE N.TID = TID)TNAME" + 
				"    FROM (SELECT ROWNUM RN, B.*" + 
				"        FROM (SELECT * FROM NOTICE ORDER BY NNO DESC) B)N" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int nno = rs.getInt("nno");
				String sid = rs.getString("sid");
				String sname = rs.getString("sname");
				String tid = rs.getString("tid");
				String tname = rs.getString("tname");
				String ntitle = rs.getString("ntitle");
				String ncontent = rs.getString("ncontent");
				Timestamp nrdate = rs.getTimestamp("nrdate");
				int nhit = rs.getInt("nhit");
				String nip = rs.getString("nip");
				dtos.add(new NoticeDto(nno, sid, sname, tid, tname, ntitle, ncontent, nrdate, nhit, nip));
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " listNotice에서 오류");
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

	// (3) 공지사항 갯수
	public int getNoticeTotCnt() {
		int totCnt = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM NOTICE";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " getNoticeTotCnt에서 오류");
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
	// (4) 공지사항 hit 1회 올리기
	private void hitUpNotice(int gno) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE NOTICE SET NHIT = NHIT +1" + 
				"    WHERE NNO = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gno);
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
	
	// (5) 공지사항번호(NNO)로 글 전체 내용 (NoticeDto)가져오기 - 공지사항정보 상세보기용
		public NoticeDto contentNotice(int nno) {
			NoticeDto dto = null;
			hitUpNotice(nno); // 공지 상세보기 시 조회수 1 올리기
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "SELECT N.*," + 
					"    (SELECT SNAME FROM STUDENT WHERE N.SID = SID)SNAME," + 
					"    (SELECT TNAME FROM TEACHER WHERE N.TID = TID)TNAME" + 
					"    FROM (SELECT ROWNUM RN, B.*" + 
					"        FROM (SELECT * FROM NOTICE ORDER BY NRDATE DESC) B)N" + 
					"    WHERE NNO=?";
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, nno);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					String sid = rs.getString("sid");
					String sname = rs.getString("sname");
					String tid = rs.getString("tid");
					String tname = rs.getString("tname");
					String ntitle = rs.getString("ntitle");
					String ncontent = rs.getString("ncontent");
					Timestamp nrdate = rs.getTimestamp("nrdate");
					int nhit = rs.getInt("nhit");
					String nip = rs.getString("nip");
					dto = new NoticeDto(nno, sid, sname, tid, tname, ntitle, ncontent, nrdate, nhit, nip);
				}
			} catch (SQLException e) {	
				System.out.println(e.getMessage() + " modifyViewGallerys에서 오류");
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

	// (6) 공지사항번호(NNO)로 글 전체 내용 (NoticeDto)가져오기 - 공지사항수정VIEW
	public NoticeDto modifyViewNotice(int nno) {
		NoticeDto dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT N.*," + 
				"    (SELECT SNAME FROM STUDENT WHERE N.SID = SID)SNAME," + 
				"    (SELECT TNAME FROM TEACHER WHERE N.TID = TID)TNAME" + 
				"    FROM (SELECT ROWNUM RN, B.*" + 
				"        FROM (SELECT * FROM NOTICE ORDER BY NRDATE DESC) B)N" + 
				"    WHERE NNO=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String sid = rs.getString("sid");
				String sname = rs.getString("sname");
				String tid = rs.getString("tid");
				String tname = rs.getString("tname");
				String ntitle = rs.getString("ntitle");
				String ncontent = rs.getString("ncontent");
				Timestamp nrdate = rs.getTimestamp("nrdate");
				int nhit = rs.getInt("nhit");
				String nip = rs.getString("nip");
				dto = new NoticeDto(nno, sid, sname, tid, tname, ntitle, ncontent, nrdate, nhit, nip);
			}
		} catch (SQLException e) {	
			System.out.println(e.getMessage() + " modifyViewGallerys에서 오류");
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

	// (7) 등록공지 수정하기
	public int modifyNotice(NoticeDto dto) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE NOTICE " + 
				"    SET NTITLE = ?," + 
				"        NCONTENT = ?," + 
				"        NIP = ?" + 
				"    WHERE NNO = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNtitle());
			pstmt.setString(2, dto.getNcontent());
			pstmt.setString(3, dto.getNip());
			pstmt.setInt(4, dto.getNno());
			result = pstmt.executeUpdate();
			System.out.println(result == SUCCESS ? "공지글수정 성공" : "공지글번호(nno) 오류");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "공지글 수정 실패 ");
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
	// (8) 등록공지 삭제하기
	public int deleteNotice(int nno) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM NOTICE WHERE NNO=?";		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nno);
			result = pstmt.executeUpdate();
			System.out.println(result == SUCCESS ? "공지글삭제 성공":"공지글번호(nno) 오류");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " deleteNotice에서 오류");
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

}
