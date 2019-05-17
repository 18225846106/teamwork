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
	
	/**
	 * 更新teamstudent表信息
	 * @param teamid
	 * @param studentid
	 * @param courseid
	 * @param character
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/updateteamstudent")
	@ResponseBody
	public Map<String, Object> updateTeamstudent(
			@RequestParam(value="teamid",defaultValue="") String teamid,
			@RequestParam(value="studentid",defaultValue="") String studentid,
			@RequestParam(value="courseid",defaultValue="") String courseid,
			@RequestParam(value="character",defaultValue="") String character,
			HttpServletRequest request,HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String info = "";
			Teamstudent teamstudent = new Teamstudent();
			if (teamid == null || teamid.equals("")) {
				info = info + " 未传入teamid!";
			}else {
				teamstudent.setTeamid(teamid);
			}
			if (studentid == null || studentid.equals("")) {
				info = info + " 未传入studentid!";
			} else {
				teamstudent.setStudentid(studentid);
			}
			if (courseid == null || courseid.equals("")) {
				info = info + " 未传入courseid!";
			} else {
				teamstudent.setCourseid(courseid);
			}
			if (character == null || character.equals("")) {
				info = info + " 未传入character!";
			} else {
				teamstudent.setCharacter(character);
			}
			int result = teamstudentService.updateTeamstudent(teamstudent);
			if (result > 0) {
				map.put("code", "200");
				map.put("info", info + " 更新成功!");
				map.put("result", result);
			}
			else {
				map.put("code", "100");
				map.put("info", info + " 更新失败!");
				map.put("result", result);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 删除teamstudent信息
	 * @param teamid
	 * @param studentid
	 * @param courseid
	 * @param character
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/deleteteamstudent")
	@ResponseBody
	public Map<String, Object> deleteTeamstudent(
			@RequestParam(value="teamid",defaultValue="") String teamid,
			@RequestParam(value="studentid",defaultValue="") String studentid,
			@RequestParam(value="courseid",defaultValue="") String courseid,
			@RequestParam(value="character",defaultValue="") String character,
			HttpServletRequest request,HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String info = "";
			Teamstudent teamstudent = new Teamstudent();
			if (teamid == null || teamid.equals("")) {
				info = info + " 未传入teamid!";
			}else {
				teamstudent.setTeamid(teamid);
			}
			if (studentid == null || studentid.equals("")) {
				info = info + " 未传入studentid!";
			} else {
				teamstudent.setStudentid(studentid);
			}
			if (courseid == null || courseid.equals("")) {
				info = info + " 未传入courseid!";
			} else {
				teamstudent.setCourseid(courseid);
			}
			if (character == null || character.equals("")) {
				info = info + " 未传入character!";
			} else {
				teamstudent.setCharacter(character);
			}
			int result = teamstudentService.deleteTeamstudent(teamstudent);
			if (result > 0) {
				map.put("code", "200");
				map.put("info", info+" 删除成功!");
				map.put("result", result);
			}
			else {
				map.put("code", "100");
				map.put("info", info + " 删除失败!");
				map.put("result", result);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
}
