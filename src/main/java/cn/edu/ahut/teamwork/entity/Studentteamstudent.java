package cn.edu.ahut.teamwork.entity;

/**
 * 学生表 小组学生表
 * @author Administrator
 *
 */
public class Studentteamstudent {

	private String teamid;
	
	private String studentid;
	
	private String courseid;
	
	private String character;
	
	private String studentname;
	
	private String studentsex;
	
	private String studentgrade;
	
	private String studentclassid;

	private String studentclassname;

	public String getTeamid() {
		return teamid;
	}

	public void setTeamid(String teamid) {
		this.teamid = teamid;
	}

	public String getStudentid() {
		return studentid;
	}

	public void setStudentid(String studentid) {
		this.studentid = studentid;
	}

	public String getCourseid() {
		return courseid;
	}

	public void setCourseid(String courseid) {
		this.courseid = courseid;
	}

	public String getCharacter() {
		return character;
	}

	public void setCharacter(String character) {
		this.character = character;
	}

	public String getStudentname() {
		return studentname;
	}

	public void setStudentname(String studentname) {
		this.studentname = studentname;
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
		return "Studentteamstudent [teamid=" + teamid + ", studentid=" + studentid + ", courseid=" + courseid
				+ ", character=" + character + ", studentname=" + studentname + ", studentsex=" + studentsex
				+ ", studentgrade=" + studentgrade + ", studentclassid=" + studentclassid + ", studentclassname="
				+ studentclassname + "]";
	}
	
}
