package com.lec.ocl.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.lec.ocl.dto.StudentDto;

public class StudentDao {
	public static final int EXISTENT    = 0;
	public static final int NONEXISTENT = 1;
	public static final int LOGIN_FAIL    =0;
	public static final int LOGIN_SUCCESS = 1;
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	// 싱글톤
	private static StudentDao instance = new StudentDao();
	public static StudentDao getInstance() {
		return instance;
	}
	private StudentDao() {}
	private Connection getConnection() throws SQLException {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle11g");
			conn = ds.getConnection();
		} catch (NamingException e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}
	// (1) 회원id 중복체크 
	public int sidConfirm(String sid) {
		int result = EXISTENT;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM STUDENT WHERE SID =?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = EXISTENT;
			}else {
				result = NONEXISTENT;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs    != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// (2) 이메일 중복체크
	public int semailConfirm(String semail) {
		int result = EXISTENT;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM STUDENT WHERE SEMAIL = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, semail);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = EXISTENT;
			}else {
				result = NONEXISTENT;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs    != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// (3) 회원가입 
	public int joinStudent(StudentDto Student) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO STUDENT (SID, SPW, SNAME, SNUMBER, SBIRTH, SEMAIL, SPHOTO, SGENDER, SADDRESS)" + 
				"VALUES (?, ?, ?, ?, ?, ?,?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Student.getSid());
			pstmt.setString(2, Student.getSpw());
			pstmt.setString(3, Student.getSname());
			pstmt.setString(4, Student.getSnumber());
			pstmt.setDate(5, Student.getSbirth());
			pstmt.setString(6, Student.getSemail());
			pstmt.setString(7, Student.getSphoto());
			pstmt.setString(8, Student.getSgender());
			pstmt.setString(9, Student.getSaddress());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// (4) 로그인 체크
	public int loginCheck(String sid, String spw) {
		int result = LOGIN_FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM STUDENT WHERE  SID=? AND SPW=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			pstmt.setString(2, spw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = LOGIN_SUCCESS;
			}else {
				result = LOGIN_FAIL;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs    != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// (5) sid로 dto가져오기(로그인 성공시 session에 넣기 위함)
	public StudentDto getStudent(String sid) {
		StudentDto student = null;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM STUDENT WHERE SID=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String spw = rs.getString("spw");
				String sname = rs.getString("sname");
				String snumber = rs.getString("snumber");
				Date sbirth = rs.getDate("sbirth");
				Timestamp srdate = rs.getTimestamp("srdate");
				String semail = rs.getString("semail");
				String sphoto = rs.getString("sphoto");
				String sgender = rs.getString("sgender");
				String saddress=rs.getString("saddress");
				student = new StudentDto(sid, spw, sname, snumber, sbirth, srdate, semail, sphoto, sgender, saddress);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs    != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return student;
	}
	// (6) 회원정보 수정
	public int modifyMember(StudentDto student) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE STUDENT" + 
				"    SET SPW = ?," + 
				"        SNAME = ?," + 
				"        SNUMBER = ?," + 
				"        SBIRTH = ?," + 
				"        SEMAIL = ?, " + 
				"        SPHOTO = ?," + 
				"        SADDRESS = ?" + 
				"    WHERE SID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, student.getSpw());
			pstmt.setString(2, student.getSname());
			pstmt.setString(3, student.getSnumber());
			pstmt.setDate(4, student.getSbirth());
			pstmt.setString(5, student.getSemail());
			pstmt.setString(6, student.getSphoto());
			pstmt.setString(7, student.getSaddress());
			pstmt.setString(8, student.getSid());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// (7) 전체 회원 리스트
	public ArrayList<StudentDto> getStudentlist(int startRow, int endRow) {
		ArrayList<StudentDto> students = new ArrayList<StudentDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT *" + 
				"    FROM (SELECT ROWNUM RN, A.* FROM (SELECT * FROM STUDENT ORDER BY SRDATE DESC)A)" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String sid = rs.getString("sid");
				String spw = rs.getString("spw");
				String sname = rs.getString("sname");
				String snumber = rs.getString("snumber");
				Date sbirth = rs.getDate("sbirth");
				Timestamp srdate = rs.getTimestamp("srdate");
				String semail = rs.getString("semail");
				String sphoto = rs.getString("sphoto");
				String sgender = rs.getString("sgender");
				String saddress=rs.getString("saddress");	
				students.add(new StudentDto(sid, spw, sname, snumber, sbirth, srdate, semail, sphoto, sgender, saddress));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs    != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return students;
	}
	// (8) 전체 회원가입한 회원수
	public int getStudentTotCnt() {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) CNT FROM STUDENT";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totCnt = rs.getInt("cnt");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs    != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return totCnt;
	}
	// (9) 회원탈퇴
	public int withdrawalStudent(String sid) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM STUDENT WHERE SID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
}