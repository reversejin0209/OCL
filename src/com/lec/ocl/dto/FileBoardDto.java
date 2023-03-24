package com.lec.ocl.dto;

import java.sql.Timestamp;

public class FileBoardDto {
	private int fno;
	private String sid;
	private String sname;
	private String tid;
	private String tname;
	private String ftitle;
	private String fcontent;
	private String ffileName;
	private Timestamp frdate;
	private int fhit;
	private int fgroup;
	private int fstep;
	private int findent;
	private String fip;
	public FileBoardDto() {}
	public FileBoardDto(int fno, String sid, String sname, String tid, String tname, String ftitle, String fcontent,
			String ffileName, Timestamp frdate, int fhit, int fgroup, int fstep, int findent, String fip) {
		this.fno = fno;
		this.sid = sid;
		this.sname = sname;
		this.tid = tid;
		this.tname = tname;
		this.ftitle = ftitle;
		this.fcontent = fcontent;
		this.ffileName = ffileName;
		this.frdate = frdate;
		this.fhit = fhit;
		this.fgroup = fgroup;
		this.fstep = fstep;
		this.findent = findent;
		this.fip = fip;
	}
	public int getFno() {
		return fno;
	}
	public void setFno(int fno) {
		this.fno = fno;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
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
	public String getFtitle() {
		return ftitle;
	}
	public void setFtitle(String ftitle) {
		this.ftitle = ftitle;
	}
	public String getFcontent() {
		return fcontent;
	}
	public void setFcontent(String fcontent) {
		this.fcontent = fcontent;
	}
	public String getFfileName() {
		return ffileName;
	}
	public void setFfileName(String ffileName) {
		this.ffileName = ffileName;
	}
	public Timestamp getFrdate() {
		return frdate;
	}
	public void setFrdate(Timestamp frdate) {
		this.frdate = frdate;
	}
	public int getFhit() {
		return fhit;
	}
	public void setFhit(int fhit) {
		this.fhit = fhit;
	}
	public int getFgroup() {
		return fgroup;
	}
	public void setFgroup(int fgroup) {
		this.fgroup = fgroup;
	}
	public int getFstep() {
		return fstep;
	}
	public void setFstep(int fstep) {
		this.fstep = fstep;
	}
	public int getFindent() {
		return findent;
	}
	public void setFindent(int findent) {
		this.findent = findent;
	}
	public String getFip() {
		return fip;
	}
	public void setFip(String fip) {
		this.fip = fip;
	}
	@Override
	public String toString() {
		return "FileBoardDto [fno=" + fno + ", sid=" + sid + ", sname=" + sname + ", tid=" + tid + ", tname=" + tname
				+ ", ftitle=" + ftitle + ", fcontent=" + fcontent + ", ffileName=" + ffileName + ", frdate=" + frdate
				+ ", fhit=" + fhit + ", fgroup=" + fgroup + ", fstep=" + fstep + ", findent=" + findent + ", fip=" + fip
				+ "]";
	}
	
}
