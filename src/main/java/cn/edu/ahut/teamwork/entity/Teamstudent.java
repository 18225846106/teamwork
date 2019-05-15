package cn.edu.ahut.teamwork.entity;

/**
 * 小组学生联系表
 * @author Administrator
 *
 */
public class Teamstudent {
    private String teamid;//小组id

    private String studentid;//学生id

    private String courseid;//课程id

    private String character;//学生角色

    public String getTeamid() {
        return teamid;
    }

    public void setTeamid(String teamid) {
        this.teamid = teamid == null ? null : teamid.trim();
    }

    public String getStudentid() {
        return studentid;
    }

    public void setStudentid(String studentid) {
        this.studentid = studentid == null ? null : studentid.trim();
    }

    public String getCourseid() {
        return courseid;
    }

    public void setCourseid(String courseid) {
        this.courseid = courseid == null ? null : courseid.trim();
    }

    public String getCharacter() {
        return character;
    }

    public void setCharacter(String character) {
        this.character = character == null ? null : character.trim();
    }

	@Override
	public String toString() {
		return "Teamstudent [teamid=" + teamid + ", studentid=" + studentid + ", courseid=" + courseid + ", character="
				+ character + "]";
	}
}