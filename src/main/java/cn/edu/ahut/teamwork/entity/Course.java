package cn.edu.ahut.teamwork.entity;

/**
 * 课程实体
 * @author Administrator
 *
 */
public class Course {
    private String id;//课程id
    
    private String code;//课程编号

    private String name;//课程名称

    private String tid;//代课教师id

    private String time;//上课时间

    private String addr;//上课地点
    
    private int group;//分组状态(1:未分组;2:已分组;3:曾经分过组)

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

    public String getTid() {
        return tid;
    }

    public void setTid(String tid) {
        this.tid = tid == null ? null : tid.trim();
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time == null ? null : time.trim();
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr == null ? null : addr.trim();
    }

	public int getGroup() {
		return group;
	}

	public void setGroup(int group) {
		this.group = group;
	}

	@Override
	public String toString() {
		return "Course [id=" + id + ", code=" + code + ", name=" + name + ", tid=" + tid + ", time=" + time + ", addr="
				+ addr + ", group=" + group + "]";
	}
}