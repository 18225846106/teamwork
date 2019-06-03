package cn.edu.ahut.teamwork.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.edu.ahut.teamwork.entity.Team;
import cn.edu.ahut.teamwork.service.TeamService;

@Controller
@RequestMapping(value="/team")
public class TeamController {

	@Autowired
	TeamService teamService;
	
	/**
	 * 根据班级id找到小组
	 * @param courseid
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findteambycourseid")
	@ResponseBody
	public Map<String, Object> findTeamByCourseid(
			@RequestParam(value="courseid",defaultValue="") String courseid,
			HttpServletRequest request, HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (courseid == null || courseid.equals("")) {
				map.put("code", "100");
				map.put("info", "班级编号丢失!");
			}else {
				List<Team> teams = teamService.findTeamByCourseid(courseid);
				if (teams != null) {
					map.put("code", "200");
					map.put("info", "查询成功!");
					map.put("teams", teams);
				}else {
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
	 * 根据小组id找到小组
	 * @param teamid
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findteambyteamid")
	@ResponseBody
	public Map<String, Object> findTeamByteamid(
			@RequestParam(value="teamid",defaultValue="") String teamid,
			HttpServletRequest request, HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (teamid == null || teamid.equals("")) {
				map.put("code", "100");
				map.put("info", "小组编号丢失!");
			}else {
				Team team = teamService.findTeamByTeamid(teamid);
				if (team != null) {
					map.put("code", "200");
					map.put("info", "查询成功!");
					map.put("team", team);
				}else {
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
	 * 更新小组名称
	 * @param teamid
	 * @param teamname
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/updateteamnamebyid")
	@ResponseBody
	public Map<String, Object> updateTeamnameById(
			@RequestParam(value="teamid",defaultValue="") String teamid,
			@RequestParam(value="teamname",defaultValue="") String teamname,
			HttpServletRequest request, HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Team team = new Team();
			if (teamid == null || teamid.equals("")) {
				map.put("code", "100");
				map.put("info", "小组编号丢失!");
			}else if (teamname == null || teamname.equals("")) {
				map.put("code", "100");
				map.put("info", "小组名称丢失!");
			}
			else {
				team.setId(teamid);
				team.setName(teamname);
				int result = teamService.updateTeamById(team);
				if (result > 0) {
					map.put("code", "200");
					map.put("info", "查询成功!");
					map.put("result", result);
				}else {
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
