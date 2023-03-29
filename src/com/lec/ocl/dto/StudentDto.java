package com.lec.ocl.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class StudentDto {
	private String sid;
	private String spw;
	private String sname;
	private String snumber;
	private Date sbirth;
	private Timestamp srdate;
	private String semail;
	private String sphoto;
	private String sgender;
	private String saddress;
	public StudentDto() {}
	public StudentDto(String sid, String spw, String sname, String snumber, Date sbirth, Timestamp srdate,
			String semail, String sphoto, String sgender, String saddress) {
		this.sid = sid;
		this.spw = spw;
		this.sname = sname;
		this.snumber = snumber;
		this.sbirth = sbirth;
		this.srdate = srdate;
		this.semail = semail;
		this.sphoto = sphoto;
		this.sgender = sgender;
		this.saddress = saddress;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getSpw() {
		return spw;
	}
	public void setSpw(String spw) {
		this.spw = spw;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getSnumber() {
		return snumber;
	}
	public void setSnumber(String snumber) {
		this.snumber = snumber;
	}
	public Date getSbirth() {
		return sbirth;
	}
	public void setSbirth(Date sbirth) {
		this.sbirth = sbirth;
	}
	public Timestamp getSrdate() {
		return srdate;
	}
	public void setSrdate(Timestamp srdate) {
		this.srdate = srdate;
	}
	public String getSemail() {
		return semail;
	}
	public void setSemail(String semail) {
		this.semail = semail;
	}
	public String getSphoto() {
		return sphoto;
	}
	public void setSphoto(String sphoto) {
		this.sphoto = sphoto;
	}
	public String getSgender() {
		return sgender;
	}
	public void setSgender(String sgender) {
		this.sgender = sgender;
	}
	public String getSaddress() {
		return saddress;
	}
	public void setSaddress(String saddress) {
		this.saddress = saddress;
	}
	@Override
	public String toString() {
		return "StudentDto [sid=" + sid + ", spw=" + spw + ", sname=" + sname + ", snumber=" + snumber + ", sbirth="
				+ sbirth + ", srdate=" + srdate + ", semail=" + semail + ", sphoto=" + sphoto + ", sgender=" + sgender
				+ ", saddress=" + saddress + "]";
	}
	
}
