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

import cn.edu.ahut.teamwork.entity.Assignment;
import cn.edu.ahut.teamwork.service.AssignmentService;
import cn.edu.ahut.teamwork.util.TeamWorkUtils;

@Controller
@RequestMapping(value = "/assignment")
public class AssignmentController {

	@Autowired
	AssignmentService assignmentService;
	
	TeamWorkUtils teamWorkUtils = new TeamWorkUtils();

	
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
	
	/**
	 * 全属性插入新建一个任务
	 * @param id
	 * @param pcode
	 * @param name
	 * @param projectid
	 * @param studentid
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
	@RequestMapping(value="/insertassignment")
	@ResponseBody
	public Map<String, Object>insertAssignment(
			@RequestParam(value="id",defaultValue="") String id,
			@RequestParam(value="code",defaultValue="") String pcode,
			@RequestParam(value="name",defaultValue="") String name,
			@RequestParam(value="projectid",defaultValue="") String projectid,
			@RequestParam(value="studentid",defaultValue="") String studentid,
			@RequestParam(value="progress",defaultValue="0") Float progress,
			@RequestParam(value="starttime",defaultValue="") String starttime,
			@RequestParam(value="endtime",defaultValue="") String endtime,
			@RequestParam(value="finishtime",defaultValue="") String finishtime,
			@RequestParam(value="state",defaultValue="1") Integer state,
			@RequestParam(value="studentscore",defaultValue="") String studentscore,
			@RequestParam(value="teacherscore",defaultValue="0") Float teacherscore,
			@RequestParam(value="score",defaultValue="0") Float score,
			@RequestParam(value="description",defaultValue="") String description,
			HttpServletRequest request, HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String code = "200";
			String info = "";
			Assignment assignment = new Assignment();
			//为任务创建一个UUID
			id = UUID.randomUUID().toString().replace("-", "");
			assignment.setId(id);
			//没有指定任务编号则UUID作为任务编号
			if (pcode.equals("") || pcode ==null) {
				pcode = id;
			}
			assignment.setCode(pcode);
			//为任务指定名称
			if (!name.equals("") && name != null) {
				assignment.setName(name);
			}else {
				code = "100";
				info = info + " 任务名称空!";
			}
			//任务所属项目id
			if (!projectid.equals("") && projectid != null) {
				assignment.setProjectid(projectid);
			}else {
				code = "100";
				info = info + " 任务所属项目id空!";
			}
			//任务指派的学生id
			if (!studentid.equals("") && studentid != null) {
				assignment.setStudentid(studentid);
			}
			//任务的进度，新建默认0
			if (progress == null) {
				assignment.setProgress((float)0);
			}
			else {
				assignment.setProgress(progress);
			}
			//任务的开始时间
			if (!starttime.equals("") && starttime != null) {
				assignment.setStarttime(new Date(Long.valueOf(starttime)));
			}
			//任务的截止时间
			if (!endtime.equals("") && endtime != null) {
				assignment.setEndtime(new Date(Long.valueOf(endtime)));
			}
			//任务状态，创建新任务自动1未开始
			if (state == null) {
				assignment.setState(1);
			}else {
				assignment.setState(state);
			}
			//任务描述信息
			if (!description.equals("") && description != null) {
				assignment.setDescription(description);
			}else {
				info = info + " 任务描述是空的!";
			}
			//否可以插入一条数据
			if (code.equals("100")) {
				map.put("code", code);
				map.put("info", info);
			}
			//是可以插入一条数据
			else if (code.equals("200")) {
				int result = assignmentService.insertAssignment(assignment);
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
	 * 根据id修改任务的信息
	 * @param id
	 * @param pcode
	 * @param name
	 * @param projectid
	 * @param studentid
	 * @param progress
	 * @param starttime
	 * @param endtime
	 * @param finishtime
	 * @param state
	 * @param studentscore
	 * @param teacherscore
	 * @param score
	 * @param description
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/updateassignment")
	@ResponseBody
	public Map<String, Object>updateAssignment(
			@RequestParam(value="id",defaultValue="") String id,
			@RequestParam(value="code",defaultValue="") String pcode,
			@RequestParam(value="name",defaultValue="") String name,
			@RequestParam(value="projectid",defaultValue="") String projectid,
			@RequestParam(value="studentid",defaultValue="") String studentid,
			@RequestParam(value="progress",required=false) Float progress,
			@RequestParam(value="starttime",defaultValue="") String starttime,
			@RequestParam(value="endtime",defaultValue="") String endtime,
			@RequestParam(value="finishtime",defaultValue="") String finishtime,
			@RequestParam(value="state",defaultValue="") Integer state,
			@RequestParam(value="studentscore",defaultValue="") String studentscore,
			@RequestParam(value="teacherscore",required=false) Float teacherscore,
			@RequestParam(value="score",required=false) Float score,
			@RequestParam(value="description",defaultValue="") String description,
			HttpServletRequest request, HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String code = "200";
			String info = "";
			Assignment assignment = new Assignment();
			Assignment assignment2 = new Assignment();
			//获取任务id
			if(!id.equals("") && id != null) {
				//根据id取出现有任务信息
				assignment2 = assignmentService.findAssignmentByid(id);
				//任务id
				assignment.setId(id);
				//任务编号
				if (pcode.equals("") || pcode == null) {//创建的任务必然有code
					pcode = id;
					assignment.setCode(pcode);
				}else {
					assignment.setCode(pcode);
				}
				//为任务指定名称
				if (!name.equals("") && name != null) {
					assignment.setName(name);
				}else {
					info = info + " 任务名称空!";
				}
				//任务所属项目id
				if (!projectid.equals("") && projectid != null) {
					assignment.setProjectid(projectid);
				}else {
					info = info + " 任务所属项目id空!";
				}
				//任务指派的学生id
				if (!studentid.equals("") && studentid != null) {
					assignment.setStudentid(studentid);
				}else {
					info = info + " 任务指派的学生id空!";
				}
				//任务的进度，新建默认0,否则插入
				if (progress != null) {
					if (progress < 0) {
						info = info + " 任务进度传入值小于零!";
					}
					else if (progress >= 0) {
						assignment.setProgress(progress);
						if (progress == 100) {//进度等于100是已完成
							assignment.setState(3);
							assignment.setFinishtime(new Date());
						}
					}
				}
				else {
					info = info + " 任务进度传入值空!";
				}
				//任务的开始时间
				if (!starttime.equals("") && starttime != null) {
					assignment.setStarttime(new Date(Long.valueOf(starttime)));
				}
				else {
					info = info + " 任务开始时间空!";
				}
				//任务的截止时间
				if (!endtime.equals("") && endtime != null) {
					assignment.setEndtime(new Date(Long.valueOf(endtime)));
				}
				else {
					info = info + " 任务结束时间空!";
				}
				//任务状态
				if (state != null) {
					assignment.setState(state);
				}else {
					info = info + " 任务状态空!";
				}
				//学生评分(传来一个学号和分数的数据对)studentid=score
				if (studentscore != null && !studentscore.equals("")) {
					//修改分数得知道原来的分数
					
					//学生评分不为空，根据评分的字符串做处理
					if (assignment2.getStudentscore().equals("") || assignment2.getStudentscore() == null) {
						//如果没有评分信息则直接插入studentid=score
						assignment.setStudentscore(studentscore);
					}else {
						//原本有评分信息则交个工具类处理完得到字符串
						assignment.setStudentscore(teamWorkUtils.alterstudentscore(assignment2.getStudentscore(), studentscore));
					}
					//得到了转成map的字符串
				}else {
					info = info + " 学生评分传入空!";
				}
				//教师评分
				if (teacherscore != null) {
					if (teacherscore >= 0) {
						assignment.setTeacherscore(teacherscore);
					}else if (teacherscore < 0) {
						info = info + " 教师传入评分小于零!";
					}else {
						info = info + " 教师评分传入空或无效值!";
					}
				}
				else {
					info = info + " 教师评分传入空!";
				}
				//最终得分
				if (score != null) {
					if (score >= 0) {
						assignment.setScore(score);
					}else if (score < 0) {
						info = info + " 得分传入值小于零!";
					}else {
						info = info + " 得分传入值无效!";
					}
				}
				else {
					info = info + " 得分传入值空!";
				}
				//任务描述信息
				if (!description.equals("") && description != null) {
					assignment.setDescription(description);
				}else {
					info = info + " 任务描述是空的!";
				}
				//否可以插入一条数据
				if (code.equals("100")) {
					map.put("code", code);
					map.put("info", info);
				}
				//是可以更新一条数据
				else if (code.equals("200")) {
					int result = assignmentService.updateAssignment(assignment);
					if (result > 0) {
						map.put("code", code);
						map.put("info", "成功更新!");
						map.put("result", result);
					}else {
						map.put("code", "100");
						map.put("info", "更新失败!");
						map.put("result", result);
					}
				}
			}else {
				map.put("code", "100");
				map.put("info", "任务编号丢失!");
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 删除任务根据id
	 * @param assignmentid
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/deleteassignment")
	@ResponseBody
	public Map<String, Object> deleteAssignment(
			@RequestParam(value="assignmentid",defaultValue="") String assignmentid,
			HttpServletRequest request, HttpServletResponse response,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (assignmentid == null || assignmentid.equals("")) {
				map.put("code", "100");
				map.put("info", "任务编号丢失!");
			} else {
				int result = assignmentService.deleteAssignment(assignmentid);
				if (result > 0) {
					map.put("code", "200");
					map.put("info", "删除成功!");
				}
				else {
					map.put("code", "100");
					map.put("info", "删除失败!");
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 根据项目编号，删除任务
	 * @param projectid
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/deleteassignmentbyprojectid")
	@ResponseBody
	public Map<String, Object> deleteAssignmentByProjectid(
			@RequestParam(value="projectid",defaultValue="") String projectid,
			HttpServletRequest request, HttpServletResponse response,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (projectid == null || projectid.equals("")) {
				map.put("code", "100");
				map.put("info", "项目编号丢失!");
			} else {
				int result = assignmentService.deleteAssignmentByProjectid(projectid);
				if (result > 0) {
					map.put("code", "200");
					map.put("info", "删除成功!");
				}
				else {
					map.put("code", "100");
					map.put("info", "删除失败!");
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 根据学生编号，删除任务
	 * @param studentid
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/deleteassignmentbystudentid")
	@ResponseBody
	public Map<String, Object> deleteAssignmentByStudentid(
			@RequestParam(value="studentid",defaultValue="") String studentid,
			HttpServletRequest request, HttpServletResponse response,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (studentid == null || studentid.equals("")) {
				map.put("code", "100");
				map.put("info", "学生编号丢失!");
			} else {
				int result = assignmentService.deleteAssignmentByStudentid(studentid);
				if (result > 0) {
					map.put("code", "200");
					map.put("info", "删除成功!");
				}
				else {
					map.put("code", "100");
					map.put("info", "删除失败!");
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
}
