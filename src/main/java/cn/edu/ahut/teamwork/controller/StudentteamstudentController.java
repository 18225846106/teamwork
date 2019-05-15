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

import cn.edu.ahut.teamwork.entity.Studentteamstudent;
import cn.edu.ahut.teamwork.service.ComplexsqlService;

@Controller
@RequestMapping(value="/sts")
public class StudentteamstudentController {

	@Autowired
	ComplexsqlService complexSqlService;
	
	/**
	 * 查询小组成员信息
	 * @param teamid 小组编号(查询条件)
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findstsbyteamid")
	@ResponseBody
	public Map<String, Object> findStsByTeamid(
			@Param(value="teamid") String teamid,
			HttpServletRequest request,HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (teamid == null || teamid == "") {
				map.put("code", "100");
				map.put("info", "小组编号丢失!");
			} else {
				List<Studentteamstudent> studentteamstudents = complexSqlService.findStsByTeamid(teamid);
				if (studentteamstudents != null) {
					map.put("code", "200");
					map.put("info", "查询成功!");
					map.put("studentteamstudents", studentteamstudents);
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
