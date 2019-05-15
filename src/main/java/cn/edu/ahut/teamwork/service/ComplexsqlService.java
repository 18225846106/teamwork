package cn.edu.ahut.teamwork.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.ahut.teamwork.dao.ComplexsqlMapper;
import cn.edu.ahut.teamwork.entity.Assignment;
import cn.edu.ahut.teamwork.entity.Student;
import cn.edu.ahut.teamwork.entity.StudentAssignment;
import cn.edu.ahut.teamwork.entity.Studentteamstudent;
import cn.edu.ahut.teamwork.entity.Teamteamstudent;
import cn.edu.ahut.teamwork.entity.Teamteamstudentstudent;

@Service
public class ComplexsqlService {

	@Autowired
	ComplexsqlMapper complexsqlMapper;
	
	
	/**
	 * 根据courseid查找学生
	 * @param courseid
	 * @return
	 */
	public List<Student> findStudentByCourseid(String courseid) {
		List<Student> students = complexsqlMapper.findStudentByCourseid(courseid);
		return students;
	}
	
	/**
	 * 课程详情页面，各个小组信息
	 * @param courseid
	 * @return
	 */
	public List<Teamteamstudent> findTtsByCourseid(String courseid) {
		List<Teamteamstudent> teamteamstudents = complexsqlMapper.findTtsByCourseid(courseid);
		return teamteamstudents;
	}
	
	/**
	 * 课程详情页面，各个小组信息,包含学生信息
	 * @param courseid
	 * @return
	 */
	public List<Teamteamstudentstudent> findTtssByCourseid(String courseid) {
		List<Teamteamstudentstudent> teamteamstudentstudents = complexsqlMapper.findTtssByCourseid(courseid);
		return teamteamstudentstudents;
	}
	
	/**
	 * 小组信息页面，小组成员信息
	 * @param teamid
	 * @return
	 */
	public List<Studentteamstudent> findStsByTeamid(String teamid) {
		List<Studentteamstudent> studentteamstudents = complexsqlMapper.findStsByTeamid(teamid);
		return studentteamstudents;
	}
	
	/**
	 * 根据班级编号和学生编号查找该班级内的该学生的任务信息CourseStudentAssignment
	 * @param courseid
	 * @param studentid
	 * @return
	 */
	public List<Assignment> findAssignmentByCsid(String courseid, String studentid) {
		List<Assignment> assignments = complexsqlMapper.findAssignmentByCsid(courseid, studentid);
		return assignments;
	}
	/**
	 * 通过项目id筛选学生和项目联合的信息
	 * @param projectid
	 * @return
	 */
	public List<StudentAssignment> findStudentAssignmentByProjectid(String projectid){
		List<StudentAssignment> studentAssignments = complexsqlMapper.findStudentAssignmentByProjectid(projectid);
		return studentAssignments;
	}
	/**
	 * 查找学生信息,按专业升序或降序排列，根据课程编号courseid从课程学生表coursestudent找到所有学生编号
	 * @param courseid
	 * @return
	 */
	public List<Student> findStudentByCourseidOrderByclassid(String courseid){
		List<Student> students = complexsqlMapper.findStudentByCourseidOrderByclassid(courseid);
		return students;
	}
}
