package com.lec.ocl.dto;

import java.sql.Timestamp;

public class NoticeDto {
	private int nno;
	private String sid;
	private String tid;
	private String tname;
	private String ntitle;
	private String ncontent;
	private Timestamp nrdate;
	private int nhit;
	private String nip;
	public NoticeDto() {}
	public NoticeDto(int nno, String sid, String tid, String tname, String ntitle, String ncontent, Timestamp nrdate,
			int nhit, String nip) {
		this.nno = nno;
		this.sid = sid;
		this.tid = tid;
		this.tname = tname;
		this.ntitle = ntitle;
		this.ncontent = ncontent;
		this.nrdate = nrdate;
		this.nhit = nhit;
		this.nip = nip;
	}
	public int getNno() {
		return nno;
	}
	public void setNno(int nno) {
		this.nno = nno;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public String getNtitle() {
		return ntitle;
	}
	public void setNtitle(String ntitle) {
		this.ntitle = ntitle;
	}
	public String getNcontent() {
		return ncontent;
	}
	public void setNcontent(String ncontent) {
		this.ncontent = ncontent;
	}
	public Timestamp getNrdate() {
		return nrdate;
	}
	public void setNrdate(Timestamp nrdate) {
		this.nrdate = nrdate;
	}
	public int getNhit() {
		return nhit;
	}
	public void setNhit(int nhit) {
		this.nhit = nhit;
	}
	public String getNip() {
		return nip;
	}
	public void setNip(String nip) {
		this.nip = nip;
	}
	@Override
	public String toString() {
		return "NoticeDto [nno=" + nno + ", sid=" + sid + ", tid=" + tid + ", tname=" + tname + ", ntitle=" + ntitle
				+ ", ncontent=" + ncontent + ", nrdate=" + nrdate + ", nhit=" + nhit + ", nip=" + nip + "]";
	}
	
}
