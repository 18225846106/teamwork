package cn.edu.ahut.teamwork.entity;

import java.util.Date;

public class Assignment {
    private String id;

    private String name;
    
    private String code;

    private String projectid;

    private String studentid;

    private Float progress;

    private Date starttime;

    private Date endtime;

    private Date finishtime;

    private Integer state;
    
    private String studentscore;
    
    private Float teacherscore;
    
    private Float score;
    
    private String description;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getProjectid() {
        return projectid;
    }

    public void setProjectid(String projectid) {
        this.projectid = projectid == null ? null : projectid.trim();
    }

    public String getStudentid() {
        return studentid;
    }

    public void setStudentid(String studentid) {
        this.studentid = studentid == null ? null : studentid.trim();
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

	public String getStudentscore() {
		return studentscore;
	}

	public void setStudentscore(String studentscore) {
		this.studentscore = studentscore;
	}

	public Float getTeacherscore() {
		return teacherscore;
	}

	public void setTeacherscore(Float teacherscore) {
		this.teacherscore = teacherscore;
	}

	public Float getScore() {
		return score;
	}

	public void setScore(Float score) {
		this.score = score;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Override
	public String toString() {
		return "Assignment [id=" + id + ", name=" + name + ", code=" + code + ", projectid=" + projectid
				+ ", studentid=" + studentid + ", progress=" + progress + ", starttime=" + starttime + ", endtime="
				+ endtime + ", finishtime=" + finishtime + ", state=" + state + ", studentscore=" + studentscore
				+ ", teacherscore=" + teacherscore + ", score=" + score + ", description=" + description + "]";
	}
}