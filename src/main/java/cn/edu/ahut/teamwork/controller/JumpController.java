package cn.edu.ahut.teamwork.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(value="/jump")
public class JumpController {
	
	/**
	 * 登录页面
	 * @return Login.jsp
	 */
	@RequestMapping(value="/login")
	public String Login() {
		return "Login";
	}
	
	@RequestMapping(value="/studentmain")
	public String Studentmain(
			@RequestParam(value="username", required=false) String username,
			@RequestParam(value="password", required=false) String password,
			HttpServletRequest request,HttpServletResponse response) {
		try {
			System.out.println(request.getParameterMap().toString());
			System.out.println("username:"+username);
			System.out.println("password:"+password);
			request.setAttribute("username", username);
			request.setAttribute("password", password);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "StudentMain";
	}
	
	@RequestMapping(value="/studentmain1")
	public String Studentmain1(
			@Param(value="username") String username,
			@Param(value="password") String password,
			HttpServletRequest request,HttpServletResponse response) {
		try {
			System.out.println(request.getParameterMap().toString());
			System.out.println("username:"+username);
			System.out.println("password:"+password);
			request.setAttribute("username", username);
			request.setAttribute("password", password);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "StudentMain1";
	}
	
	/**
	 * 跳转到课程详情页面
	 * @param courseid
	 * @param group
	 * @param request
	 * @param response
	 * @return CourseDetail.jsp
	 */
	@RequestMapping(value="/coursedetail")
	public String CourseDetail(
			@Param(value="courseid") String courseid,
//			@Param(value="group") String group,
			HttpServletRequest request,HttpServletResponse response){
		try {
			System.out.println("打印传来的courseid："+courseid);
			request.setAttribute("courseid", courseid);
//			request.setAttribute("group", group);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "CourseDetail";
	}
	
	/**
	 * 跳转到小组信息页面
	 * @param teamid
	 * @param request
	 * @param response
	 * @return CourseTeam.jsp
	 */
	@RequestMapping(value="/courseteam")
	public String CourseTeam(
			@Param(value="teamid") String teamid,
			HttpServletRequest request,HttpServletResponse response){
		try {
			System.out.println("打印传来的teamid："+teamid);
			request.setAttribute("teamid", teamid);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "CourseTeam";
	}
	
	/**
	 * 跳转到班级学生任务页面
	 * @param courseid
	 * @param studentid
	 * @param request
	 * @param response
	 * @return CourseStudentAssignment.jsp
	 */
	@RequestMapping(value="/coursestudentassignment")
	public String CourseStudentAssignment(
			@Param(value="courseid") String courseid,
			@Param(value="studentid") String studentid,
			HttpServletRequest request,HttpServletResponse response){
		try {
			System.out.println("打印传来的courseid和studentid："+courseid+" "+studentid);
			request.setAttribute("courseid", courseid);
			request.setAttribute("studentid", studentid);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "CourseStudentAssignment";
	}
		
	/**
	 * 跳转到项目内任务信息页面
	 * @param projectid
	 * @param request
	 * @param response
	 * @return ProjectAssignment.jsp
	 */
	@RequestMapping(value="/projectassignment")
	public String ProjectAssignment(
			@Param(value="prodectid") String projectid,
			HttpServletRequest request,HttpServletResponse response){
		try {
			System.out.println("打印传来的projectid："+projectid);
			request.setAttribute("projectid", projectid);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "ProjectAssignment";
	}
	
	/**
	 * 跳转到任务详情页面,从班级内学生任务页面来
	 * @param assignmentid
	 * @param request
	 * @param response
	 * @return AssignmentDetail.jsp
	 */
	@RequestMapping(value="/assignmentdetail")
	public String AssignmentDetail(
			@Param(value="assignmentid") String assignmentid,
			HttpServletRequest request,HttpServletResponse response){
		try {
			System.out.println("打印传来的assignmentid："+assignmentid);
			request.setAttribute("assignmentid", assignmentid);
			request.setAttribute("projectid", "null");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "AssignmentDetail";
	}
	
	/**
	 * 跳转到任务详情页面,从项目内任务信息页面来
	 * @param assignmentid
	 * @param projectid
	 * @param request
	 * @param response
	 * @return AssignmentDetail.jsp
	 */
	@RequestMapping(value="/assignmentdetailt")
	public String AssignmentDetailT(
			@Param(value="assignmentid") String assignmentid,
			@RequestParam(value="projectid", defaultValue="null") String projectid,
			HttpServletRequest request,HttpServletResponse response){
		try {
			System.out.println("打印传来的assignmentid："+assignmentid);
			request.setAttribute("assignmentid", assignmentid);
			request.setAttribute("projectid", projectid);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "AssignmentDetail";
	}
	
	/**
	 * 跳转到学生登录后的页面,课程页面
	 * @param username
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/studentcourse")
	public String StudentCourse(
			@Param(value="username") String username,
			HttpServletRequest request,HttpServletResponse response) {
		try {
			request.setAttribute("username", username);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "StudentCourse";
	}
	
	/**
	 * 学生进入班级内的页面
	 * @param studentid
	 * @param courseid
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/studentcoursedetail")
	public String StudentCourseDetail(
			@Param(value="studentid") String studentid,
			@Param(value="courseid") String courseid,
			HttpServletRequest request,HttpServletResponse response) {
		try {
			request.setAttribute("studentid", studentid);
			request.setAttribute("courseid", courseid);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "StudentCourseDetail";
	}
	
	/**
	 * 转到学生和小组的任务界面
	 * @param studentid
	 * @param projectid
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/studentandteamassignment")
	public String StudentAndTeamAssignment(
			@Param(value="studentid") String studentid,
			@Param(value="projectid") String projectid,
			HttpServletRequest request,HttpServletResponse response) {
		try {
			request.setAttribute("studentid", studentid);
			request.setAttribute("projectid", projectid);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "StudentAndTeamAssignment";
	}
	
	/**
	 * 一个参数是创建任务，两个参数是编辑任务
	 * @param assignmentid
	 * @param projectid
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/createassignment")
	public String CreateAssignment(
			@Param(value="assignmentid") String assignmentid,
			@Param(value="projectid") String projectid,
			HttpServletRequest request,HttpServletResponse response) {
		try {
			request.setAttribute("assignmentid", assignmentid);
			request.setAttribute("projectid", projectid);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "CreateAssignment";
	}
}
