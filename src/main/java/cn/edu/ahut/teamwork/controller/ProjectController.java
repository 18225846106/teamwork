package cn.edu.ahut.teamwork.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.edu.ahut.teamwork.entity.Project;
import cn.edu.ahut.teamwork.entity.Team;
import cn.edu.ahut.teamwork.service.ProjectService;
import cn.edu.ahut.teamwork.service.TeamService;

@Controller
@RequestMapping(value="/project")
public class ProjectController {

	@Autowired
	ProjectService projectService;
	
	@Autowired
	TeamService teamService;
	
	/**
	 * 通过项目属性查询项目信息
	 * @param id
	 * @param code
	 * @param name
	 * @param courseid
	 * @param tid
	 * @param state
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findprojectbyproject")
	@ResponseBody
	public Map<String, Object> findProjectByProject(
			@RequestParam(value="id",defaultValue="") String id,
			@RequestParam(value="code",defaultValue="") String code,
			@RequestParam(value="name",defaultValue="") String name,
			@RequestParam(value="courseid",defaultValue="") String courseid,
			@RequestParam(value="tid",defaultValue="") String tid,
			@RequestParam(value="state") Integer state,
			HttpServletRequest request, HttpServletResponse response,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		Project project = new Project();
		String info = "";
		try {
			if (id != "" && id != null) {
				project.setId(id);
			}else {
				info=info+"没有项目id!";
			}
			if (code != "" && code != null) {
				project.setCode(code);
			}else {
				info = info + "没有项目编号!";
			}
			if (name != "" && name != null) {
				project.setName(name);
			}else {
				info = info + "没有项目名称!";
			}
			if (courseid != "" && courseid != null) {
				project.setCourseid(courseid);
			}else {
				info = info + "没有班级编号!";
			}
			if (tid != "" && tid != null) {
				project.setTid(tid);
			}else {
				info = info + "没有小组编号!";
			}
			if (state != null) {
				project.setState(state);
			}else {
				info = info + "没有项目状态!";
			}
			
			List<Project> projects = projectService.findProjectByProject(project);
			if (projects != null) {
				map.put("code", "200");
				map.put("info", "查询成功!"+info);
				map.put("projects", projects);
			} else {
				map.put("code", "100");
				map.put("info", "查询失败!"+info);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 查询小组内的所有项目
	 * @param teamid
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findprojectbyteamid")
	@ResponseBody
	public Map<String, Object> findProjectByTeamid(
			@Param(value = "teamid") String teamid,
			HttpServletRequest request, HttpServletResponse response,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (teamid == null || teamid == "") {
				map.put("code", "100");
				map.put("info", "小组编号丢失!");
			}
			else {
				List<Project> projects = projectService.findProjectByTeamid(teamid);
				if (projects != null) {
					map.put("code", "200");
					map.put("info", "查询成功!");
					map.put("projects", projects);
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
	 * 通过id查找项目信息
	 * @param id
	 * @param request
	 * @param response
	 * @param model
	 * @return json
	 */
	@RequestMapping(value="/findprojectbyid")
	@ResponseBody
	public Map<String, Object> findProjectById(
			@Param(value = "id") String id,
			HttpServletRequest request, HttpServletResponse response,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (id == null || id.equals("")) {
				map.put("code", "100");
				map.put("info", "项目编号丢失!");
			}
			else {
				Project project = projectService.findProjectById(id);
				if (project != null) {
					map.put("code", "200");
					map.put("info", "查询成功!");
					map.put("project", project);
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
	
	@RequestMapping(value="/findprojectbycourseid")
	@ResponseBody
	public Map<String, Object> findProjectByCourseid(
			@Param(value = "courseid") String courseid,
			HttpServletRequest request, HttpServletResponse response,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (courseid == null || courseid == "") {
				map.put("code", "100");
				map.put("info", "课程编号丢失!");
			}
			else {
				List<Project> projects = projectService.findProjectByCourseid(courseid);
				if (projects != null) {
					map.put("code", "200");
					map.put("info", "查询成功!");
					map.put("projects", projects);
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
	 * 创建一个新的项目
	 * @param id 项目id
	 * @param code 项目编号
	 * @param name 项目名称
	 * @param courseid 编辑编号
	 * @param tid 指派到的小组id
	 * @param progress 项目进程
	 * @param starttime 项目开始时间
	 * @param endtime 项目截止时间
	 * @param finishtime 项目完成时间
	 * @param state 项目状态
	 * @param description 项目描述信息
	 * @param request 页面请求
	 * @param response 页面回馈
	 * @param model 页面模型
	 * @return json/map
	 */
	@RequestMapping(value="/insertproject")
	@ResponseBody
	public Map<String, Object>insertProject(
			@RequestParam(value="id",defaultValue="") String id,
			@RequestParam(value="code",defaultValue="") String pcode,
			@RequestParam(value="name",defaultValue="") String name,
			@RequestParam(value="courseid",defaultValue="") String courseid,
			@RequestParam(value="tid",defaultValue="") String tid,
			@RequestParam(value="progress",defaultValue="0") Float progress,
			@RequestParam(value="starttime",defaultValue="") String starttime,
			@RequestParam(value="endtime",defaultValue="") String endtime,
			@RequestParam(value="finishtime",defaultValue="") String finishtime,
			@RequestParam(value="state",defaultValue="1") Integer state,
			@RequestParam(value="description",defaultValue="") String description,
			@RequestParam(value="score",defaultValue="0") Float score,
			HttpServletRequest request, HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String code = "200";
			String info = "";
			Project project = new Project();
			//为项目创建一个UUID
			id = UUID.randomUUID().toString().replace("-", "");
			project.setId(id);
			//没有指定项目编号则UUID作为项目编号
			if (pcode.equals("") || pcode == null) {
				pcode = id;
			}
			project.setCode(pcode);
			//为项目指定名称
			if (!name.equals("") && name != null) {
				project.setName(name);
			}else {
				code = "100";
				info = info + " 项目名称空!";
			}
			//项目所属课程id
			if (!courseid.equals("") && courseid != null) {
				project.setCourseid(courseid);
			}else {
				code = "100";
				info = info + " 项目所属课程id空!";
			}
			//项目指派的小组id
			if (!tid.equals("") && tid != null) {
				project.setTid(tid);
			}else {
				info = info + " 项目所属小组id空!";
			}
			//项目的进度，新建默认0
			if (progress == null) {
				project.setProgress((float)0);
			}
			else {
				project.setProgress(progress);
			}
			//项目的开始时间
			if (!starttime.equals("") && starttime != null) {
				project.setStarttime(new Date(Long.valueOf(starttime)));
			}
			//项目的截止时间
			if (!endtime.equals("") && endtime != null) {
				project.setEndtime(new Date(Long.valueOf(endtime)));
			}
			//项目状态，创建新项目自动1未开始
			if (state == null) {
				project.setState(1);
			}else {
				project.setState(state);
			}
			//项目描述信息
			if (!description.equals("") && description != null) {
				project.setDescription(description);
			}else {
				info = info + " 项目描述是空的!";
			}
			//否可以插入一条数据
			if (code == "100") {
				map.put("code", code);
				map.put("info", info);
			}
			//是可以插入一条数据
			else if (code == "200") {
				int result = projectService.insertProject(project);
				if (result > 0) {
					map.put("code", code);
					map.put("info", "成功插入!");
					map.put("result", result);
				}else {
					map.put("code", "100");
					map.put("info", "插入失败!");
					map.put("result", result);
				}
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 创建一个每个小组都要完成新的项目
	 * @param id 项目id
	 * @param code 项目编号
	 * @param name 项目名称
	 * @param courseid 编辑编号
	 * @param tid 指派到的小组id
	 * @param progress 项目进程
	 * @param starttime 项目开始时间
	 * @param endtime 项目截止时间
	 * @param finishtime 项目完成时间
	 * @param state 项目状态
	 * @param description 项目描述信息
	 * @param request 页面请求
	 * @param response 页面回馈
	 * @param model 页面模型
	 * @return json/map
	 */
	@RequestMapping(value="/insertprojectforallteam")
	@ResponseBody
	public Map<String, Object>insertProjectForAllTeam(
			@RequestParam(value="id",defaultValue="") String id,
			@RequestParam(value="code",defaultValue="") String pcode,
			@RequestParam(value="name",defaultValue="") String name,
			@RequestParam(value="courseid",defaultValue="") String courseid,
			//@RequestParam(value="tid",defaultValue="") String tid,
			@RequestParam(value="progress",defaultValue="0") Float progress,
			@RequestParam(value="starttime",defaultValue="") String starttime,
			@RequestParam(value="endtime",defaultValue="") String endtime,
			@RequestParam(value="finishtime",defaultValue="") String finishtime,
			@RequestParam(value="state",defaultValue="1") Integer state,
			@RequestParam(value="description",defaultValue="") String description,
			@RequestParam(value="score",defaultValue="0") Float score,
			HttpServletRequest request, HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String code = "200";
			String info = "";
			int num = 0;
			Project project = new Project();
			//找到所有小组
			List<Team> teams = teamService.findTeamByCourseid(courseid);
			if (teams == null) {
				info = info + " 未查到班级内分组!";
				code = "100";
			}else {
				//没有指定项目编号则UUID作为项目编号
				if (pcode.equals("") || pcode == null) {
					pcode = UUID.randomUUID().toString().replace("-", "");;
				}
				project.setCode(pcode);
				//为项目指定名称
				if (!name.equals("") && name != null) {
					project.setName(name);
				}else {
					code = "100";
					info = info + " 项目名称空!";
				}
				//项目所属课程id
				if (!courseid.equals("") && courseid != null) {
					project.setCourseid(courseid);
				}else {
					code = "100";
					info = info + " 项目所属课程id空!";
				}
				//项目的进度，新建默认0
				if (progress == null) {
					project.setProgress((float)0);
				}
				else {
					project.setProgress(progress);
				}
				//项目的开始时间
				if (!starttime.equals("") && starttime != null) {
					project.setStarttime(new Date(Long.valueOf(starttime)));
				}
				//项目的截止时间
				if (!endtime.equals("") && endtime != null) {
					project.setEndtime(new Date(Long.valueOf(endtime)));
				}
				//项目状态，创建新项目自动1未开始
				if (state == null) {
					project.setState(1);
				}else {
					project.setState(state);
				}
				//项目描述信息
				if (!description.equals("") && description != null) {
					project.setDescription(description);
				}else {
					info = info + " 项目描述是空的!";
				}
				//满足插入条件
				if (code.equals("200")) {
					//循环为所有组创建该项目
					for (int i = 0; i < teams.size(); i++) {
						//为项目创建一个UUID
						id = UUID.randomUUID().toString().replace("-", "");
						project.setId(id);
						//项目指派的小组id
						project.setTid(teams.get(i).getId());
						
						//是可以插入一条数据
						int result = projectService.insertProject(project);
						if (result > 0) {
							num++;
						}else {
							code = "100";
							info = info + " 插入失败!";
							//map.put("result", result);
						}
						if (code.equals("100")) {
							break;
						}
					}
				}
			}
			map.put("code", code);
			map.put("info", info);
			map.put("num", num);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 根据id修改项目的信息
	 * @param id
	 * @param pcode
	 * @param name
	 * @param courseid
	 * @param tid
	 * @param progress
	 * @param starttime
	 * @param endtime
	 * @param finishtime
	 * @param state
	 * @param description
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/updateproject")
	@ResponseBody
	public Map<String, Object> updateProject(
			@RequestParam(value="id",defaultValue="") String id,
			@RequestParam(value="code",defaultValue="") String pcode,
			@RequestParam(value="name",defaultValue="") String name,
			@RequestParam(value="courseid",defaultValue="") String courseid,
			@RequestParam(value="tid",defaultValue="") String tid,
			@RequestParam(value="progress",defaultValue="") String  progress,
//			@Param(value="progress") Float progress,
			@RequestParam(value="starttime",defaultValue="") String starttime,
			@RequestParam(value="endtime",defaultValue="") String endtime,
			@RequestParam(value="finishtime",defaultValue="") String finishtime,
			@RequestParam(value="state",defaultValue="") String state,
//			@Param(value="state") Integer state,
			@RequestParam(value="description",defaultValue="") String description,
			@RequestParam(value="score",defaultValue="") String  score,
			HttpServletRequest request, HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String code = "200";
			String info = "";
			System.out.println(" id "+id+" pcode "+pcode+" name  "+name+" courseid  "+courseid+" tid  "+tid+" progress  "+progress+" starttime "+starttime+" endtime "+endtime+" finishtime "+finishtime+"  state "+state+" description "+description);
			Project project = new Project();
			if (id != null && !id.equals("")) {
				//更新时项目id不为空才可以进行下一步操作
				project.setId(id);
				if (pcode != null && !pcode.equals("")) {
					project.setCode(pcode);
				}
				if (name != null && !name.equals("")) {
					project.setName(name);
				}else {
					info = info + " 项目名空!";
				}
				if (courseid != null && !courseid.equals("")) {
					project.setCourseid(courseid);
				}
				else {
					info = info + " 班级编号空!";
				}
				if (tid != null && !tid.equals("")) {
					project.setTid(tid);
				}else {
					info = info + " 小组编号空!";
				}
				if (progress != null && !progress.equals("") && Float.valueOf(progress) >= 0) {
					project.setProgress(Float.valueOf(progress));
				}else {
					info = info + " 项目进度有误!";
				}
				if (starttime != null && !starttime.equals("")) {
					project.setStarttime(new Date(Long.valueOf(starttime)));
				}else {
					info = info + " 开始时间空!";
				}
				if (endtime != null && !endtime.equals("")) {
					project.setEndtime(new Date(Long.valueOf(endtime)));
				}else {
					info = info + " 截止时间空!";
				}
				if (finishtime != null  && !finishtime.equals("")) {
					project.setFinishtime(new Date(Long.valueOf(finishtime)));
				}else {
					info = info + " 完成时间空!";
				}
				if (state != null && !state.equals("")) {
					project.setState(Integer.parseInt(state));
				}else {
					info = info + " 完成状态空!";
				}
				if (description != null  && description != "") {
					project.setDescription(description);
				}else {
					info = info + " 项目描述空!";
				}
				if (score != null && !score.equals("") && Float.valueOf(score) >= 0) {
					project.setScore(Float.valueOf(score));
				} else {
					info = info + " 项目分数空!";
				}
				int result = projectService.updateProject(project);
				if (result > 0) {
					map.put("code", "200");
					map.put("info", "更新成功!");
				}
				else {
					map.put("code", "100");
					map.put("info", "更新失败!");
				}
			}
			else {
				code = "100";
				info = info + " 项目编号空!";
				map.put("code", code);
				map.put("info", info);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	/**
	 * 根据项目id删除项目
	 * @param projectid
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/deleteproject")
	@ResponseBody
	public Map<String, Object> deleteProject(
			@RequestParam(value="projectid",defaultValue="") String projectid,
			HttpServletRequest request, HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (projectid == null || projectid.equals("")) {
				map.put("code", "100");
				map.put("info", "项目id丢失!");
			}
			else {
				int result = projectService.deleteProject(projectid);
				if (result > 0) {
					map.put("code", "200");
					map.put("info", "删除成功!");
					map.put("result", result);
				} else {
					map.put("code", "100");
					map.put("info", "删除失败!");
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return map;
	}
}
