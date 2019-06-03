package cn.edu.ahut.teamwork.entity;

public class Coursestudent {
    private String courseid;

    private String studentid;
    
    private Integer group;
    
    private Float teamscore;
    
    private Float personscore;
    
    private Float score;

    public String getCourseid() {
        return courseid;
    }

    public void setCourseid(String courseid) {
        this.courseid = courseid == null ? null : courseid.trim();
    }

    public String getStudentid() {
        return studentid;
    }

    public void setStudentid(String studentid) {
        this.studentid = studentid == null ? null : studentid.trim();
    }

	public Integer getGroup() {
		return group;
	}

	public void setGroup(Integer group) {
		this.group = group;
	}

	public Float getTeamscore() {
		return teamscore;
	}

	public void setTeamscore(Float teamscore) {
		this.teamscore = teamscore;
	}

	public Float getPersonscore() {
		return personscore;
	}

	public void setPersonscore(Float personscore) {
		this.personscore = personscore;
	}

	public Float getScore() {
		return score;
	}

	public void setScore(Float score) {
		this.score = score;
	}

	@Override
	public String toString() {
		return "Coursestudent [courseid=" + courseid + ", studentid=" + studentid + ", group=" + group + ", teamscore="
				+ teamscore + ", personscore=" + personscore + ", score=" + score + "]";
	}
}