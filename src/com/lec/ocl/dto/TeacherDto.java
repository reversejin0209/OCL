package com.lec.ocl.dto;

public class TeacherDto {
	private String tid;
	private String tpw;
	private String tname;
	public TeacherDto() {}
	public TeacherDto(String tid, String tpw, String tname) {
		this.tid = tid;
		this.tpw = tpw;
		this.tname = tname;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getTpw() {
		return tpw;
	}
	public void setTpw(String tpw) {
		this.tpw = tpw;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	@Override
	public String toString() {
		return "TeacherDto [tid=" + tid + ", tpw=" + tpw + ", tname=" + tname + "]";
	}
	
}
