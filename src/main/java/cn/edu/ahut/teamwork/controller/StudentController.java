package cn.edu.ahut.teamwork.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.junit.runners.Parameterized.Parameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.edu.ahut.teamwork.entity.Student;
import cn.edu.ahut.teamwork.service.ComplexsqlService;
import cn.edu.ahut.teamwork.service.StudentService;

@Controller
@RequestMapping(value="/student")
public class StudentController {
	
	@Autowired
	StudentService studentService;
	
	@Autowired
	ComplexsqlService complexSqlService;
	
	@RequestMapping(value="/findall")
	@ResponseBody
	public Map<String, Object> findall(){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			List<Student> students = studentService.findAll();
			map.put("students", students);
			map.put("success", true);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return map;
	}
	
	@RequestMapping(value="/loginout")
	public String LoginOut(HttpSession session) {
		session.removeAttribute("LOGIN");
		return "Login";
	}
	
	@RequestMapping(value="/login")
	@ResponseBody
	public Map<String, Object> login(
			@RequestParam(value="username",required=false)String username,
			@RequestParam(value="password",required=false)String password,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session,Model model
			){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (username == "" || username == null) {
				map.put("success", false);
				map.put("info", "用户名不应为空");
				map.put("type", 3);
			}else if (password == "" || password == null) {
				map.put("success", false);
				map.put("info", "用户密码不应为空");
				map.put("type", 4);
			}else {
				//查询用户是否存在
				Student student = studentService.findById(username);
				System.out.println("student syso: "+student);
				if (student == null) {
					map.put("success", false);
					map.put("info", "用户名错误");
					map.put("username", false);
					map.put("type", 1);
				}
				else if (!student.getPassword().equals(password)) {
					map.put("success", false);
					map.put("info", "密码错误");
					map.put("password", false);
					map.put("type", 2);
				}
				else if (student.getPassword().equals(password)) {
					map.put("success", true);
					map.put("info", "登录成功");
					map.put("type", 0);
					session.setAttribute("LOGIN", username);
					session.setAttribute("username", username);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	@RequestMapping(value="/login1")
	//@ResponseBody
	//	public Map<String, Object> login1(
	public String login1(
			@Param(value="username")String username,
			@Param(value="password")String password,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session,Model model
			){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (username == "" || username == null) {
				map.put("success", false);
				map.put("info", "用户名不应为空");
				map.put("type", 3);
			}else if (password == "" || password == null) {
				map.put("success", false);
				map.put("info", "用户密码不应为空");
				map.put("type", 4);
			}else {
				//查询用户是否存在
				Student student = studentService.findById(username);
				System.out.println(student);
				if (student == null) {
					map.put("success", false);
					map.put("info", "用户名错误");
					map.put("username", false);
					map.put("type", 1);
				}
				else if (!student.getPassword().equals(password)) {
					map.put("success", false);
					map.put("info", "密码错误");
					map.put("password", false);
					map.put("type", 2);
				}
				else if (student.getPassword().equals(password)) {
					map.put("success", true);
					map.put("info", "登录成功");
					map.put("type", 0);
					//测试拦截器
					session.setAttribute("LOGIN", username);
					//测试向页面传参数
					request.setAttribute("username", username);
					request.setAttribute("username1", "1111111");
					//model.addAttribute("username1", username);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		//return map;
		return "StudentMain1";
	}
	
	/**
	 * 根据学生编号查找学生
	 * @param studentid
	 * @param request
	 * @param response
	 * @param model
	 * @return json
	 */
	@RequestMapping(value="/findstudentbyid")
	@ResponseBody
	public Map<String, Object> findStudentById(
			@Param(value="studentid") String studentid,
			HttpServletRequest request,HttpServletResponse response,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (studentid == ""  || studentid == null) {
				map.put("code", "100");
				map.put("info", "学生编号丢失!");
			}
			else {
				Student student = studentService.findById(studentid);
				if (student != null) {
					map.put("code", "200");
					map.put("info", "查询成功!");
					map.put("student", student);
				} else {
					map.put("code", "100");
					map.put("info", "查找失败!");
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * @descript 根据课程id找到该课程内的学生，分页版
	 * @author laq
	 * @param courseid
	 * @param pageNum
	 * @param pageSize
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findStudentByCourseidPageHelper")
	@ResponseBody
	public Map<String, Object> findStudentByCourseidPageHelper(
			@Param(value="courseid") String courseid,
			@RequestParam(value="pageNum", defaultValue="1") Integer pageNum,
			@RequestParam(value="pageSize",defaultValue="5") Integer pageSize,
			HttpServletRequest request,HttpServletResponse response,Model model){
		
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (courseid == null || courseid == "") {
				map.put("code", "100");
				map.put("info", "课程编号丢失!");
			} else {
				PageHelper.startPage(pageNum, pageSize);
				List<Student> students = complexSqlService.findStudentByCourseid(courseid);
				if (students == null) {
					map.put("code", "100");
					map.put("info", "未查询到结果!");
				} else {
					PageInfo<Student> pageInfo = new PageInfo<Student>(students);
					map.put("code", "200");
					map.put("info", "查询成功!");
					map.put("pageInfo", pageInfo);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * @descript 根据课程id找到该课程内的学生
	 * @author laq
	 * @param courseid
	 * @param pageNum
	 * @param pageSize
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findStudentByCourseid")
	@ResponseBody
	public Map<String, Object> findStudentByCourseid(
			@Param(value="courseid") String courseid,
			//@RequestParam(value="pageNum", defaultValue="1") Integer pageNum,
			//@RequestParam(value="pageSize",defaultValue="5") Integer pageSize,
			HttpServletRequest request,HttpServletResponse response,Model model){
		
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (courseid == null || courseid == "") {
				map.put("code", "100");
				map.put("info", "课程编号丢失!");
			} else {
				List<Student> students = complexSqlService.findStudentByCourseid(courseid);
				if (students == null) {
					map.put("code", "100");
					map.put("info", "未查询到结果!");
				} else {
					map.put("code", "200");
					map.put("info", "查询成功!");
					map.put("students", students);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	

}
