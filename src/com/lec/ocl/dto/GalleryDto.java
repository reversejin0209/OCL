package com.lec.ocl.dto;

import java.sql.Timestamp;

public class GalleryDto {
	private int gno;
	private String sid;
	private String tid;
	private String tname;
	private String gtitle;
	private String gcontent;
	private String gfileName;
	private Timestamp grdate;
	private int ghit;
	private String gip;
	public GalleryDto() {}
	public GalleryDto(int gno, String sid, String tid, String tname, String gtitle, String gcontent, String gfileName,
			Timestamp grdate, int ghit, String gip) {
		this.gno = gno;
		this.sid = sid;
		this.tid = tid;
		this.tname = tname;
		this.gtitle = gtitle;
		this.gcontent = gcontent;
		this.gfileName = gfileName;
		this.grdate = grdate;
		this.ghit = ghit;
		this.gip = gip;
	}
	public int getGno() {
		return gno;
	}
	public void setGno(int gno) {
		this.gno = gno;
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
	public String getGtitle() {
		return gtitle;
	}
	public void setGtitle(String gtitle) {
		this.gtitle = gtitle;
	}
	public String getGcontent() {
		return gcontent;
	}
	public void setGcontent(String gcontent) {
		this.gcontent = gcontent;
	}
	public String getGfileName() {
		return gfileName;
	}
	public void setGfileName(String gfileName) {
		this.gfileName = gfileName;
	}
	public Timestamp getGrdate() {
		return grdate;
	}
	public void setGrdate(Timestamp grdate) {
		this.grdate = grdate;
	}
	public int getGhit() {
		return ghit;
	}
	public void setGhit(int ghit) {
		this.ghit = ghit;
	}
	public String getGip() {
		return gip;
	}
	public void setGip(String gip) {
		this.gip = gip;
	}
	@Override
	public String toString() {
		return "GalleryDto [gno=" + gno + ", sid=" + sid + ", tid=" + tid + ", tname=" + tname + ", gtitle=" + gtitle
				+ ", gcontent=" + gcontent + ", gfileName=" + gfileName + ", grdate=" + grdate + ", ghit=" + ghit
				+ ", gip=" + gip + "]";
	}
	
}
