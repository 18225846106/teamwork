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

import cn.edu.ahut.teamwork.dao.ComplexsqlMapper;
import cn.edu.ahut.teamwork.entity.StudentAssignment;
import cn.edu.ahut.teamwork.entity.Teamteamstudentstudent;

@Controller
//@RequestMapping(value="/ttss")
public class ComplexsqlController {

	@Autowired
	ComplexsqlMapper complexsqlMapper;
	
	/**
	 * 根据课程编号查找小组表Team和小组学生表Teamstudent和学生表student的联合信息
	 * @param courseid 班级编号
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/ttss/findttssbycourseid")
	@ResponseBody
	public Map<String, Object> findTtssByCourseid(
			@Param(value="courseid") String courseid,
			HttpServletRequest request,HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (courseid == null || courseid == "") {
				map.put("code", "100");
				map.put("info", "班级编号丢失!");
			} else {
				List<Teamteamstudentstudent> teamteamstudentstudents = complexsqlMapper.findTtssByCourseid(courseid);
				if (teamteamstudentstudents != null) {
					map.put("code", "200");
					map.put("info", "查询成功!");
					map.put("ttss", teamteamstudentstudents);
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
	 * 通过项目id筛选学生和项目联合的信息
	 * @param projectid
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/sa/findstudentassignmentbyprojectid")
	@ResponseBody
	public Map<String, Object> findStudentAssignmentByProjectid(
			@Param(value="projectid") String projectid,
			HttpServletRequest request,HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (projectid == null || projectid == "") {
				map.put("code", "100");
				map.put("info", "项目编号丢失!");
			} else {
				List<StudentAssignment> studentAssignments = complexsqlMapper.findStudentAssignmentByProjectid(projectid);
				if (studentAssignments != null) {
					map.put("code", "200");
					map.put("info", "查询成功!");
					map.put("studentassignments", studentAssignments);
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
