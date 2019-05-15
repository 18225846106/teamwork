package cn.edu.ahut.teamwork.entity;
/**
 * 小组表
 * @author Administrator
 *
 */
public class Team {
    private String id;
    
    private String code;

    private String name;

    private String courseid;

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
        this.courseid = courseid == null ? null : courseid.trim();
    }

	@Override
	public String toString() {
		return "Team [id=" + id + ", code=" + code + ", name=" + name + ", courseid=" + courseid + "]";
	}
}