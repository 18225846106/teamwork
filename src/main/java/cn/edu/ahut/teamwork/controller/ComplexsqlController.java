package cn.edu.ahut.teamwork.controller;

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

import cn.edu.ahut.teamwork.dao.ComplexsqlMapper;
import cn.edu.ahut.teamwork.entity.Course;
import cn.edu.ahut.teamwork.entity.Student;
import cn.edu.ahut.teamwork.entity.StudentAssignment;
import cn.edu.ahut.teamwork.entity.TeacherCourse;
import cn.edu.ahut.teamwork.entity.Team;
import cn.edu.ahut.teamwork.entity.Teamstudent;
import cn.edu.ahut.teamwork.entity.Teamteamstudentstudent;
import cn.edu.ahut.teamwork.service.ComplexsqlService;
import cn.edu.ahut.teamwork.service.CourseService;
import cn.edu.ahut.teamwork.service.TeamService;
import cn.edu.ahut.teamwork.service.TeamstudentService;
import cn.edu.ahut.teamwork.util.TeamWorkUtils;

@Controller
public class ComplexsqlController {
	
	TeamWorkUtils teamWorkUtils = new TeamWorkUtils();

	@Autowired
	ComplexsqlMapper complexsqlMapper;
	
	@Autowired
	CourseService courseService;
	
	@Autowired
	TeamService teamService;
	
	@Autowired
	TeamstudentService teamstudentService;
	
	@Autowired
	ComplexsqlService complexsqlService;
	
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
	
	/**
	 * 教师对学生分组
	 * @param courseid
	 * @param count
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/creatnewgroup")
	@ResponseBody
	public Map<String, Object> CreatNewGroup(
			@RequestParam(value="courseid",defaultValue="") String courseid,
			@RequestParam(value="count",defaultValue="") Integer count,
			HttpServletRequest request,HttpServletResponse response,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String code = "";
			String info = "";
			if (courseid == null || courseid.equals("")) {
//				map.put("code", "100");
//				map.put("info", "课程编号丢失!");
				code = "100";
				info = "课程编号丢失!";
			} else {
				List<Student> students = complexsqlService.findStudentByCourseidOrderByclassid(courseid);
				if (students == null) {
//					map.put("code", "100");
//					map.put("info", "查询失败!");
					code = "100";
					info = "查询失败!";
				} else {
					//调用排序函数对列表重新排序
					Map<String, Object> resultmap = teamWorkUtils.sortStudentsm(count,students);
					List<Student> sList = (List<Student>) resultmap.get("students");
					List<Integer> index = (List<Integer>) resultmap.get("index");
					//切换id时用到的下标
					int num = 0;
					//插入的返回结果
					int resultteam = 0;
					int resultteamstudent = 0;
					int resultcourse = 0;
					//所有存储结果是否都成功的判断
					boolean flag = true;
					//存储每次待存的实体
					Team team = new Team();
					Teamstudent teamstudent = new Teamstudent();
					//向表中插入
					String uuid = UUID.randomUUID().toString().replace("-", "");
					for(int i =0;i < sList.size();i++) {
						if (index.get(num) == i || i == 0) {//换一个组时，更换id
							if (i > 0) {
								num++;
							}
							uuid = UUID.randomUUID().toString().replace("-", "");//换组换id
//							System.out.println(index);
//							System.out.println(i);
//							System.out.println(uuid);
							team.setId(uuid);
							team.setCourseid(courseid);
							resultteam = teamService.insertTeam(team);
						}
						teamstudent.setTeamid(uuid);
						teamstudent.setStudentid(sList.get(i).getId());
						teamstudent.setCourseid(courseid);
						resultteamstudent = teamstudentService.insertTeamstudent(teamstudent);
						//应该有失败再次尝试，失败删除已分组
						if (resultteam <= 0 || resultteamstudent <= 0) {
							System.out.println("resultteam:    "+resultteam);
							System.out.println("resultteamstudent:   "+resultteamstudent);
//							map.put("code", "100");
//							map.put("info", "出现失败创建!");
							code = "100";
							info = "出现失败创建!";
							//修改全部创建判断状态的状态值
							flag = false;
							//将已经插入的删除
//							teamService.deleteTeamByCourseid(courseid);
//							teamstudentService.deleteTeamstudentByCourseid(courseid);
//							System.out.println(teamService.deleteTeamByCourseid(courseid));
//							System.out.println(teamstudentService.deleteTeamstudentByCourseid(courseid));
							//跳出循环
							break;
						}
						//如果全部创建成功，修改班级的分组状态
						if (flag) {
							Course course = new Course();
							course.setId(courseid);
							course.setGroup(2);
							resultcourse = courseService.updateCourse(course);
							if (resultcourse > 0) {
								flag = true;
								code = "200";
								info = "创建完成，修改班级的分组状态!";
							}else {
								flag = false;
								code = "100";
								info = "创建完成，修改班级的分组状态失败!";
								teamService.deleteTeamByCourseid(courseid);
								teamstudentService.deleteTeamstudentByCourseid(courseid);
							}
						}else {//出现失败删除已经插入
							code = "100";
							info = "创建失败!";
							teamService.deleteTeamByCourseid(courseid);
							teamstudentService.deleteTeamstudentByCourseid(courseid);
						}
					}
				}
			}
			map.put("code", code);
			map.put("info", info);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 查找，项目 所在小组的成员id，team_student
	 * @param projectid
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/teamstudent/findteamstudentbyprojectid")
	@ResponseBody
	public Map<String, Object> findTeamstudentByProjectid(
			@RequestParam(value="projectid",defaultValue="") String projectid,
			HttpServletRequest request,HttpServletResponse response,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (projectid == null || projectid.equals("")) {
				map.put("code", "100");
				map.put("info", "项目id丢失!");
			} else {
				List<Teamstudent> teamstudents = complexsqlService.findTeamstudentByProjectid(projectid);
				if (teamstudents == null) {
					map.put("code", "100");
					map.put("info", "查找失败!");
				} else {
					map.put("code", "200");
					map.put("info", "查找成功!");
					map.put("teamstudents", teamstudents);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 插入小组分数，通过teamid，到team-student找到studentid，courseid，到course-student表修改teamscore
	 * @param teamid
	 * @param score
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/setteamscore")
	@ResponseBody
	public Map<String, Object> setTeamScore(
			@RequestParam(value="teamid",defaultValue="") String teamid,
			@RequestParam(value="score",defaultValue="") String score,
			HttpServletRequest request,HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String code = "200";
			String info = "";
			if (teamid == null || teamid.equals("")) {
				code = "100";
				info = info + " 小组id空!";
			}
			if (score == null || score.equals("") || Float.valueOf(score) < 0) {
				code = "100";
				info = info + " 小组分数空或无效值!";
			}
			if (code.equals("100")) {
				//
			} else if(code.equals("200")){
				//
				Team team = new Team();
				team.setId(teamid);
				team.setScore(Float.valueOf(score));
				//更新team表的分数
				int result1 = teamService.updateTeamById(team);
				//更新班级学生表的分数
				int result2 = complexsqlService.updateCoursestudentTeamscoreByTeam(team);
				if (result1 > 0) {
					info = info + " 小组分数成功更新!";
				}
				else {
					code = "100";
					info = info + " 小组分数更新失败!";
				}
				if (result2 > 0) {
					info = info + " 班级学生表小组成绩更新成功!";
				}
				else {
					code = "100";
					info = info + " 班级学生表小组成绩更新失败!";
				}
			}
			map.put("code", code);
			map.put("info", info);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 同时设置小组分数和个人分数
	 * 两个的值使用相同的
	 * 插入小组分数同时个人分等同于小祖分，通过teamid，到team-student找到studentid，courseid，到course-student表修改teamscore和personscore
	 * @param teamid
	 * @param score
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/setteampersonscore")
	@ResponseBody
	public Map<String, Object> setTeamPersonScore(
			@RequestParam(value="teamid",defaultValue="") String teamid,
			@RequestParam(value="score",defaultValue="") String score,
			HttpServletRequest request,HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String code = "200";
			String info = "";
			if (teamid == null || teamid.equals("")) {
				code = "100";
				info = info + " 小组id空!";
			}
			if (score == null || score.equals("") || Float.valueOf(score) < 0) {
				code = "100";
				info = info + " 小组分数空或无效值!";
			}
			if (code.equals("100")) {
				//
			} else if(code.equals("200")){
				//
				Team team = new Team();
				team.setId(teamid);
				team.setScore(Float.valueOf(score));
				//更新team表的分数
				int result1 = teamService.updateTeam(team);
				//更新班级学生表的分数,同时修改个人分数
				int result2 = complexsqlService.updateCoursestudentTpscoreByTeam(team);
				if (result1 > 0) {
					info = info + " 小组分数成功更新!";
				}
				else {
					code = "100";
					info = info + " 小组分数更新失败!";
				}
				if (result2 > 0) {
					info = info + " 班级学生表小组成绩个人成绩更新成功!";
				}
				else {
					code = "100";
					info = info + " 班级学生表小组成绩个人成绩更新失败!";
				}
			}
			map.put("code", code);
			map.put("info", info);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 查询学生的所有课程和老师信息
	 * @param studentid
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findteachercoursebystudentid")
	@ResponseBody
	public Map<String, Object> temp(
			@RequestParam(value="studentid",defaultValue="") String studentid,
			HttpServletRequest request, HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String code = "200";//初始是成功
			String info = "";//提示信息初始是空字符串
			if (studentid == null || studentid.equals("")) {
				code = "100";
				info = info + " 学号空!";
			} else {
				List<TeacherCourse> teacherCourses = complexsqlService.findTeachercourseByStudentid(studentid);
				if (teacherCourses == null) {
					code = "100";
					info = info + " 查询失败!";
				} else {
					code = "200";
					info = info + " 查询成功!";
					map.put("teachercourses", teacherCourses);
				}
			}
			map.put("code", code);
			map.put("info", info);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
}
