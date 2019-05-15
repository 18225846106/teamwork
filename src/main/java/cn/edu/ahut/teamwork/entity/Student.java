package cn.edu.ahut.teamwork.entity;

public class Student {
    private String id;

    private String name;

    private String password;

    private String sfzh;

    private String sex;

    private String grade;

    private String classid;

    private String classname;

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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getSfzh() {
        return sfzh;
    }

    public void setSfzh(String sfzh) {
        this.sfzh = sfzh == null ? null : sfzh.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade == null ? null : grade.trim();
    }

    public String getClassid() {
        return classid;
    }

    public void setClassid(String classid) {
        this.classid = classid == null ? null : classid.trim();
    }

    public String getClassname() {
        return classname;
    }

    public void setClassname(String classname) {
        this.classname = classname == null ? null : classname.trim();
    }

	@Override
	public String toString() {
		return "Student [id=" + id + ", name=" + name + ", password=" + password + ", sfzh=" + sfzh + ", sex=" + sex
				+ ", grade=" + grade + ", classid=" + classid + ", classname=" + classname + "]";
	}
}