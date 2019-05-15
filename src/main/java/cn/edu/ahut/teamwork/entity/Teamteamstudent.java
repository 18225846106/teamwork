package cn.edu.ahut.teamwork.entity;

/**
 * 课程详情，学生分组
 * @author Administrator
 *
 */
public class Teamteamstudent {
	
	private String teamid;
	
	private String teamname;
	
	private String courseid;
	
	private String studentid;
	
	private String character;

	public String getTeamid() {
		return teamid;
	}

	public void setTeamid(String teamid) {
		this.teamid = teamid;
	}

	public String getTeamname() {
		return teamname;
	}

	public void setTeamname(String teamname) {
		this.teamname = teamname;
	}

	public String getCourseid() {
		return courseid;
	}

	public void setCourseid(String courseid) {
		this.courseid = courseid;
	}

	public String getStudentid() {
		return studentid;
	}

	public void setStudentid(String studentid) {
		this.studentid = studentid;
	}

	public String getCharacter() {
		return character;
	}

	public void setCharacter(String character) {
		this.character = character;
	}

	@Override
	public String toString() {
		return "Teamteamstudent [teamid=" + teamid + ", teamname=" + teamname + ", courseid=" + courseid
				+ ", studentid=" + studentid + ", character=" + character + "]";
	}

}
