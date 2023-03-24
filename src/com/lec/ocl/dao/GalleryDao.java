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

public class GalleryDao {
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	private DataSource ds;
	// 싱글톤
	private static GalleryDao instance = new GalleryDao();
	
	public static GalleryDao getInstance() {
		return instance;
	}
	private GalleryDao() {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle11g");
		} catch (NamingException e) {
			System.out.println(e.getMessage());
		}
	}
	// (1) 앨범등록
	public int writeGallery(GalleryDto dto) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO GALLERY(GNO, TID, GTITLE, GCONTENT, GFILENAME, GIP)" + 
				"    VALUES(GALLERY_SEQ.NEXTVAL,?, ?, ?, ?, ?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTid());
			pstmt.setString(2, dto.getGtitle());
			pstmt.setString(3, dto.getGcontent());
			pstmt.setString(4, dto.getGfileName());
			pstmt.setString(5, dto.getGip());
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("원글쓰기 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " 원글쓰기 실패 :");
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
	// (2) 앨범등록 리스트 (top - n)
	public ArrayList<GalleryDto> listGallery(int startRow, int endRow) {
		ArrayList<GalleryDto> dtos = new ArrayList<GalleryDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT G.*," + 
				"    (SELECT SNAME FROM STUDENT WHERE G.SID = SID)SNAME," + 
				"    (SELECT TNAME FROM TEACHER WHERE G.TID = TID)TNAME" + 
				"    FROM (SELECT ROWNUM RN, B.*" + 
				"        FROM (SELECT * FROM GALLERY ORDER BY GRDATE DESC) B)G" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int gno = rs.getInt("gno");
				String sid = rs.getString("sid");
				String tid = rs.getString("tid");
				String tname = rs.getString("tname");
				String gtitle = rs.getString("gtitle");
				String gcontent = rs.getString("gcontent");
				String gfileName = rs.getString("gfileName");
				Timestamp grdate = rs.getTimestamp("grdate");
				int ghit = rs.getInt("ghit");
				String gip = rs.getString("gip");
				dtos.add(new GalleryDto(gno, sid, tid, tname, gtitle, gcontent, gfileName, grdate, ghit, gip));
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " listGallery에서 오류");
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

	// (3) 앨범등록 갯수
	public int getGalleryTotCnt() {
		int totCnt = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM GALLERY";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " getGalleryTotCnt에서 오류");
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
	// (4) 앨범등록 hit 1회 올리기
	private void hitUpGallery(int gno) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE GALLERY SET GHIT = GHIT +1" + 
				"    WHERE GNO = ?";
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
 
	// (5) 앨범등록번호(GNO)로 글 전체 내용 (GalleryDto)가져오기 - 앨범등록정보 상세보기용
	public GalleryDto contentGallery(int gno) {
		GalleryDto dto = null;
		hitUpGallery(gno); // 앨범 상세보기 시 조회수 1 올리기
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT G.*," + 
				"    (SELECT SNAME FROM STUDENT WHERE G.SID = SID)SNAME," + 
				"    (SELECT TNAME FROM TEACHER WHERE G.TID = TID)TNAME" + 
				"    FROM (SELECT ROWNUM RN, B.*" + 
				"        FROM (SELECT * FROM GALLERY ORDER BY GRDATE DESC) B)G" + 
				"    WHERE GNO=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String sid = rs.getString("sid");
				String tid = rs.getString("tid");
				String tname = rs.getString("tname");
				String gtitle = rs.getString("gtitle");
				String gcontent = rs.getString("gcontent");
				String gfileName = rs.getString("gfileName");
				Timestamp grdate = rs.getTimestamp("grdate");
				int ghit = rs.getInt("ghit");
				String gip = rs.getString("gip");
				dto = new GalleryDto(gno, sid, tid, tname, gtitle, gcontent, gfileName, grdate, ghit, gip);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " contentGallery에서 오류");
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

	// (6) 앨범등록번호(GNO)로 글 전체 내용 (GalleryDto)가져오기 - 앨범등록수정VIEW
	public GalleryDto modifyViewGallery(int gno) {
		GalleryDto dto = null;
		hitUpGallery(gno); // 앨범 상세보기 시 조회수 1 올리기
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT G.*," + 
				"    (SELECT SNAME FROM STUDENT WHERE G.SID = SID)SNAME," + 
				"    (SELECT TNAME FROM TEACHER WHERE G.TID = TID)TNAME" + 
				"    FROM (SELECT ROWNUM RN, B.*" + 
				"        FROM (SELECT * FROM GALLERY ORDER BY GRDATE DESC) B)G" + 
				"    WHERE GNO=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String sid = rs.getString("sid");
				String tid = rs.getString("tid");
				String tname = rs.getString("tname");
				String gtitle = rs.getString("gtitle");
				String gcontent = rs.getString("gcontent");
				String gfileName = rs.getString("gfileName");
				Timestamp grdate = rs.getTimestamp("grdate");
				int ghit = rs.getInt("ghit");
				String gip = rs.getString("gip");
				dto = new GalleryDto(gno, sid, tid, tname, gtitle, gcontent, gfileName, grdate, ghit, gip);
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

	// (7) 앨범등록 수정하기
	public int modifyGallery(GalleryDto dto) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE GALLERY " + 
				"    SET GTITLE = ?," + 
				"        GCONTENT = ?," + 
				"        GFILENAME = ?," + 
				"        GIP = ?" + 
				"    WHERE GNO = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getGtitle());
			pstmt.setString(2, dto.getGcontent());
			pstmt.setString(3, dto.getGfileName());
			pstmt.setString(4, dto.getGip());
			pstmt.setInt(5, dto.getGno());
			result = pstmt.executeUpdate();
			System.out.println(result == SUCCESS ? "앨범글수정 성공" : "앨범글번호(gno) 오류");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "앨범글 수정 실패 ");
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
	// (8) 앨범등록 삭제하기
	public int deleteGallery(int gno) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM GALLERY WHERE GNO=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gno);
			result = pstmt.executeUpdate();
			System.out.println(result == SUCCESS ? "앨범글삭제 성공":"앨범글번호(gno) 오류");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + " deleteGallery에서 오류");
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
