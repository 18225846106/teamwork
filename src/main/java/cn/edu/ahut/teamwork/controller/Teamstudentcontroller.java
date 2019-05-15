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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.annotation.JsonInclude.Value;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.edu.ahut.teamwork.entity.Teamstudent;
import cn.edu.ahut.teamwork.service.TeamstudentService;

@Controller
@RequestMapping(value="/teamstudent")
public class Teamstudentcontroller {

	@Autowired
	TeamstudentService teamstudentService;
	
	/**
	 * 根据课程编号查找所有该课程内的小组信息
	 * @param courseid
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findByCourseid")
	@ResponseBody
	public Map<String, Object> findByCourseid(
			@Param(value="courseid") String courseid,
			HttpServletRequest request,HttpServletResponse response,Model model
			){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (courseid == null || courseid == "") {
				map.put("code", "100");
				map.put("info", "课程编号丢失!");
			} else {
				List<Teamstudent> teamstudents = teamstudentService.findByCourseid(courseid);
				if (teamstudents != null) {
					map.put("code", "200");
					map.put("info", "查询成功");
					map.put("teamstudents", teamstudents);
				} else {
					map.put("code", "100");
					map.put("info", "查询结果为空!");
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 根据课程编号查找所有该课程内的小组信息(分页)
	 * @param courseid
	 * @param pageNum
	 * @param pageSize
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findByCourseidPageHelper")
	@ResponseBody
	public Map<String, Object> findByCourseidPageHelper(
			@Param(value="courseid") String courseid,
			@RequestParam(value="pageNum", defaultValue="1") Integer pageNum,
			@RequestParam(value="pageSize",defaultValue="5") Integer pageSize,
			HttpServletRequest request,HttpServletResponse response,Model model
			){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (courseid == null || courseid == "") {
				map.put("code", "100");
				map.put("info", "课程编号丢失!");
			} else {
				List<Teamstudent> teamstudents = teamstudentService.findByCourseid(courseid);
				if (teamstudents != null) {
					PageHelper.startPage(pageNum, pageSize);
					PageInfo<Teamstudent> pageInfo = new PageInfo<Teamstudent>(teamstudents);
					map.put("code", "200");
					map.put("info", "查询成功");
					map.put("pageInfo", pageInfo);
				} else {
					map.put("code", "100");
					map.put("info", "查询结果为空!");
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
}
