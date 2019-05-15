package cn.edu.ahut.teamwork.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.ahut.teamwork.dao.AssignmentMapper;
import cn.edu.ahut.teamwork.dao.ComplexsqlMapper;
import cn.edu.ahut.teamwork.entity.Assignment;

@Service
public class AssignmentService {

	@Autowired
	AssignmentMapper assignmentMapper;
	
	@Autowired
	ComplexsqlMapper complexsqlMapper;
	
	/**
	 * 根据项目编号查找任务信息
	 * @param projectid
	 * @return
	 */
	public List<Assignment> findAssignmentByProjectid(String projectid){
		List<Assignment> assignments = assignmentMapper.findAssignmentByProjectid(projectid);
		return assignments;
	}
	
	/**
	 * 根据任务id查找任务信息
	 * @param assignmentid
	 * @return
	 */
	public Assignment findAssignmentByid(String assignmentid){
		Assignment assignment = assignmentMapper.findAssignmentByid(assignmentid);
		return assignment;
	}
	
	/**
	 * 根据班级编号和学生编号查找该班级内的该学生的任务信息CourseStudentAssignment
	 * @param courseid
	 * @param studentid
	 * @return assignments
	 */
	public List<Assignment> findAssignmentByCsid(String courseid,String studentid) {
		List<Assignment> assignments = complexsqlMapper.findAssignmentByCsid(courseid, studentid);
		return assignments;
	}
}
