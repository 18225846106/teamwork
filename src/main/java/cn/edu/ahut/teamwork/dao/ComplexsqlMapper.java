package cn.edu.ahut.teamwork.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.edu.ahut.teamwork.entity.Assignment;
import cn.edu.ahut.teamwork.entity.Student;
import cn.edu.ahut.teamwork.entity.StudentAssignment;
import cn.edu.ahut.teamwork.entity.Studentteamstudent;
import cn.edu.ahut.teamwork.entity.Teamteamstudent;
import cn.edu.ahut.teamwork.entity.Teamteamstudentstudent;

public interface ComplexsqlMapper {
	
	//根据courseid查找学生
	List<Student> findStudentByCourseid(@Param("courseid") String courseid);
	
	//课程详情页面，各个小组信息CourseDetail
	List<Teamteamstudent> findTtsByCourseid(@Param("courseid") String courseid);
	
	//在findTtsByCourseid基础上加上学生信息
	List<Teamteamstudentstudent> findTtssByCourseid(@Param("courseid") String courseid);
	
	//小组信息页面，小组成员信息CourseTeam
	List<Studentteamstudent> findStsByTeamid(@Param("teamid") String teamid);
	
	//根据班级编号和学生编号查找该班级内的该学生的任务信息CourseStudentAssignment
	List<Assignment> findAssignmentByCsid(@Param("courseid") String courseid,@Param("studentid") String studentid);
	
	//通过项目id筛选学生和项目联合的信息
	List<StudentAssignment> findStudentAssignmentByProjectid(@Param("projectid") String projectid);
	
	//查找学生信息,按专业升序或降序排列，根据课程编号courseid从课程学生表coursestudent找到所有学生编号
	List<Student> findStudentByCourseidOrderByclassid(@Param("courseid") String courseid);

}
