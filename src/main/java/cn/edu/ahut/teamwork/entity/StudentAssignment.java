package cn.edu.ahut.teamwork.entity;

import java.util.Date;

public class StudentAssignment {

	private String assignmentid;
	
	private String assignmentname;
	
	private String projectid;
	
	private String studentid;
	
	private Float progress;
	
	private Date starttime;
	
	private Date endtime;
	
	private Date finishtime;
	
	private Integer state;
	
	private String studentname;
	
	private String studentpassword;
	
	private String studentsfzh;
	
	private String studentsex;
	
	private String studentgrade;
	
	private String studentclassid;
	
	private String studentclassname;
	
	public String getAssignmentid() {
		return assignmentid;
	}
	public void setAssignmentid(String assignmentid) {
		this.assignmentid = assignmentid;
	}
	public String getAssignmentname() {
		return assignmentname;
	}
	public void setAssignmentname(String assignmentname) {
		this.assignmentname = assignmentname;
	}
	public String getProjectid() {
		return projectid;
	}
	public void setProjectid(String projectid) {
		this.projectid = projectid;
	}
	public String getStudentid() {
		return studentid;
	}
	public void setStudentid(String studentid) {
		this.studentid = studentid;
	}
	public Float getProgress() {
		return progress;
	}
	public void setProgress(Float progress) {
		this.progress = progress;
	}
	public Date getStarttime() {
		return starttime;
	}
	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}
	public Date getEndtime() {
		return endtime;
	}
	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}
	public Date getFinishtime() {
		return finishtime;
	}
	public void setFinishtime(Date finishtime) {
		this.finishtime = finishtime;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public String getStudentname() {
		return studentname;
	}
	public void setStudentname(String studentname) {
		this.studentname = studentname;
	}
	public String getStudentpassword() {
		return studentpassword;
	}
	public void setStudentpassword(String studentpassword) {
		this.studentpassword = studentpassword;
	}
	public String getStudentsfzh() {
		return studentsfzh;
	}
	public void setStudentsfzh(String studentsfzh) {
		this.studentsfzh = studentsfzh;
	}
	public String getStudentsex() {
		return studentsex;
	}
	public void setStudentsex(String studentsex) {
		this.studentsex = studentsex;
	}
	public String getStudentgrade() {
		return studentgrade;
	}
	public void setStudentgrade(String studentgrade) {
		this.studentgrade = studentgrade;
	}
	public String getStudentclassid() {
		return studentclassid;
	}
	public void setStudentclassid(String studentclassid) {
		this.studentclassid = studentclassid;
	}
	public String getStudentclassname() {
		return studentclassname;
	}
	public void setStudentclassname(String studentclassname) {
		this.studentclassname = studentclassname;
	}
	@Override
	public String toString() {
		return "StudentAssignment [assignmentid=" + assignmentid + ", assignmentname=" + assignmentname + ", projectid="
				+ projectid + ", studentid=" + studentid + ", progress=" + progress + ", starttime=" + starttime
				+ ", endtime=" + endtime + ", finishtime=" + finishtime + ", state=" + state + ", studentname="
				+ studentname + ", studentpassword=" + studentpassword + ", studentsfzh=" + studentsfzh
				+ ", studentsex=" + studentsex + ", studentgrade=" + studentgrade + ", studentclassid=" + studentclassid
				+ ", studentclassname=" + studentclassname + "]";
	}
}
