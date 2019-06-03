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
	
	//全属性插入新建一个任务
	public int insertAssignment(Assignment assignment) {
		int result = assignmentMapper.insertAssignment(assignment);
		return result;
	}
	
	//根据id修改任务的信息
	public int updateAssignment(Assignment assignment) {
		int result = assignmentMapper.updateAssignment(assignment);
		return result;
	}
	
	//删除任务根据id
	public int deleteAssignment(String assignmentid) {
		int result = assignmentMapper.deleteAssignment(assignmentid);
		return result;
	}
	
	//根据项目编号，删除任务
	public int deleteAssignmentByProjectid(String projectid) {
		int result = assignmentMapper.deleteAssignmentByProjectid(projectid);
		return result;
	}
	
	//根据学生编号，删除任务
	public int deleteAssignmentByStudentid(String studentid) {
		int result = assignmentMapper.deleteAssignmentByStudentid(studentid);
		return result;
	}
}
