package cn.edu.ahut.teamwork.entity;

import java.util.Date;

public class Project {
    private String id;
    
    private String code;

    private String name;
    
    private String courseid;

    private String tid;

    private Float progress;

    private Date starttime;

    private Date endtime;

    private Date finishtime;

    private Integer state;
    
    private String description;
    
    private Float score;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getCourseid() {
		return courseid;
	}

	public void setCourseid(String courseid) {
		this.courseid = courseid;
	}

	public String getTid() {
        return tid;
    }

    public void setTid(String tid) {
        this.tid = tid == null ? null : tid.trim();
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Float getScore() {
		return score;
	}

	public void setScore(Float score) {
		this.score = score;
	}

	@Override
	public String toString() {
		return "Project [id=" + id + ", code=" + code + ", name=" + name + ", courseid=" + courseid + ", tid=" + tid
				+ ", progress=" + progress + ", starttime=" + starttime + ", endtime=" + endtime + ", finishtime="
				+ finishtime + ", state=" + state + ", description=" + description + ", score=" + score + "]";
	}
}