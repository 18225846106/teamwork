package cn.edu.ahut.teamwork.entity;

/**
 * team team_student
 * 课程详情，学生分组
 * @author Administrator
 *
 */
public class Teamteamstudent {
	
	private String teamid;
	
	private String teamscode;
	
	private String teamname;
	
	private String courseid;
	
	private Float teamscore;
	
	private String studentid;
	
	private String character;

	public String getTeamid() {
		return teamid;
	}

	public void setTeamid(String teamid) {
		this.teamid = teamid;
	}

	public String getTeamscode() {
		return teamscode;
	}

	public void setTeamscode(String teamscode) {
		this.teamscode = teamscode;
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

	public Float getTeamscore() {
		return teamscore;
	}

	public void setTeamscore(Float teamscore) {
		this.teamscore = teamscore;
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
		return "Teamteamstudent [teamid=" + teamid + ", teamscode=" + teamscode + ", teamname=" + teamname
				+ ", courseid=" + courseid + ", teamscore=" + teamscore + ", studentid=" + studentid + ", character="
				+ character + "]";
	}

}
