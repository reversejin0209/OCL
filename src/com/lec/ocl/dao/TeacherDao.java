package com.lec.ocl.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.lec.ocl.dto.TeacherDto;

public class TeacherDao {
	public static final int LOGIN_FAIL    = 0;
	public static final int LOGIN_SUCCESS = 1;
	private DataSource ds;
	private TeacherDao() {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle11g");
		} catch (NamingException e) {
			System.out.println(e.getMessage());
		}
	}
	private static TeacherDao instance = new TeacherDao();
	public static TeacherDao getInstance() {
		return instance;
	}
	// (1) Teacher loginCheck
	public int loginCheck(String tid, String tpw) {
		int result = LOGIN_FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM TEACHER WHERE TID=? AND TPW=?";
		try {
			conn = ds.getConnection();
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, tid);
			pstmt.setString(2, tpw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = LOGIN_SUCCESS;
			}			
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs   !=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (Exception e) {System.out.println(e.getMessage());}
		}
		return result;
	}
	// (2) 로그인 후 세션에 넣을 용도 : admin aid로 dto 가져오기
	public TeacherDto getAdmin(String tid) {
		TeacherDto Teacher = null;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM TEACHER WHERE TID=?";
		try {
			conn = ds.getConnection();
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, tid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Teacher = new TeacherDto();
				Teacher.setTid(rs.getString("tid"));
				Teacher.setTpw(rs.getString("tpw"));
				Teacher.setTname(rs.getString("tname"));
			}			
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs   !=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (Exception e) {System.out.println(e.getMessage());}
		}
		return Teacher;
	}
}