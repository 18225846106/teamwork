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
import cn.edu.ahut.teamwork.entity.Teamteamstudent;

@Controller
@RequestMapping(value="/tts")
public class TeamteamstudentController {

	@Autowired
	ComplexsqlMapper complexsqlMapper;
	
	/**
	 * 根据课程编号查找小组表Team和小组学生表Teamstudent的联合信息
	 * @param courseid 班级编号
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findttsbycourseid")
	@ResponseBody
	public Map<String, Object> findTtsByCourseid(
			@Param(value="courseid") String courseid,
			HttpServletRequest request,HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (courseid == null || courseid == "") {
				map.put("code", "100");
				map.put("info", "班级编号丢失!");
			} else {
				List<Teamteamstudent> teamteamstudents = complexsqlMapper.findTtsByCourseid(courseid);
				if (teamteamstudents != null) {
					map.put("code", "200");
					map.put("info", "查询成功!");
					map.put("tts", teamteamstudents);
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
