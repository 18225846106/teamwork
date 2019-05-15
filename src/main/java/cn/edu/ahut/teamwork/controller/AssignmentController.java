package cn.edu.ahut.teamwork.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.edu.ahut.teamwork.entity.Assignment;
import cn.edu.ahut.teamwork.service.AssignmentService;

@Controller
@RequestMapping(value = "/assignment")
public class AssignmentController {

	@Autowired
	AssignmentService assignmentService;

	
	/**
	 * 根据班级编号和学生编号查找该班级内的该学生的任务信息CourseStudentAssignment
	 * @param courseid
	 * @param studentid
	 * @param request
	 * @param response
	 * @param model
	 * @return json
	 */
	@RequestMapping(value = "/findassignmentbycsid")
	@ResponseBody
	public Map<String, Object> findAssignmentByCsid(
			@Param(value = "courseid") String courseid,
			@Param(value = "studentid") String studentid,
			HttpServletRequest request, HttpServletResponse response,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("findassignmentbycsid");
		try {
			if (courseid == null || courseid == "") {
				map.put("code", "100");
				map.put("info", "班级编号丢失!");
			}else if(studentid == null || studentid == ""){
				map.put("code", "100");
				map.put("info", "学生编号丢失!");
			}else {
				List<Assignment> assignments = assignmentService.findAssignmentByCsid(courseid, studentid);
				if (assignments != null) {
					map.put("code", "200");
					map.put("info", "查询成功!");
					map.put("assignments", assignments);
				} else {
					map.put("code", "100");
					map.put("info", "查询失败!");
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 根据项目编号查找任务信息
	 * @param projectid
	 * @param request
	 * @param response
	 * @param model
	 * @return json
	 */
	@RequestMapping(value = "/findassignmentbyprojectid")
	@ResponseBody
	public Map<String, Object> findAssignmentByProjectid(
			@Param(value = "projectid") String projectid,
			HttpServletRequest request, HttpServletResponse response,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("findassignmentbycsid");
		try {
			if (projectid == null || projectid == "") {
				map.put("code", "100");
				map.put("info", "项目编号丢失!");
			}else {
				List<Assignment> assignments = assignmentService.findAssignmentByProjectid(projectid);
				if (assignments != null) {
					map.put("code", "200");
					map.put("info", "查询成功!");
					map.put("assignments", assignments);
				} else {
					map.put("code", "100");
					map.put("info", "查询失败!");
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 根据任务id查找任务信息
	 * @param assignmentid
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/findassignmentbyid")
	@ResponseBody
	public Map<String, Object> findAssignmentByid(
			@Param(value = "assignmentid") String assignmentid,
			HttpServletRequest request, HttpServletResponse response,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("findassignmentbycsid");
		try {
			if (assignmentid == null || assignmentid == "") {
				map.put("code", "100");
				map.put("info", "任务编号丢失!");
			}else {
				Assignment assignment = assignmentService.findAssignmentByid(assignmentid);
				if (assignment != null) {
					map.put("code", "200");
					map.put("info", "查询成功!");
					map.put("assignment", assignment);
				} else {
					map.put("code", "100");
					map.put("info", "查询失败!");
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
}
