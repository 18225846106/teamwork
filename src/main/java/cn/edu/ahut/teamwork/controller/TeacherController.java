package cn.edu.ahut.teamwork.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.edu.ahut.teamwork.entity.Teacher;
import cn.edu.ahut.teamwork.service.TeacherService;

@Controller
@RequestMapping(value="/teacher")
public class TeacherController {
	
	@Autowired
	TeacherService teacherService;

	@RequestMapping(value="/loginout")
	public String LoginOut(HttpSession session) {
		session.removeAttribute("LOGIN");
		session.removeAttribute("username");
		session.removeAttribute("loginname");
		session.removeAttribute("role");
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
			if (username.equals("") || username == null) {
				map.put("success", false);
				map.put("code", "100");
				map.put("info", "用户名不应为空");
				map.put("type", 3);
			}else if (password == "" || password == null) {
				map.put("success", false);
				map.put("code", "100");
				map.put("info", "用户密码不应为空");
				map.put("type", 4);
			}else {
				//查询用户是否存在
				Teacher teacher = teacherService.findById(username);
				System.out.println("student syso: "+teacher);
				if (teacher == null) {
					map.put("success", false);
					map.put("code", "100");
					map.put("info", "用户名错误");
					map.put("username", false);
					map.put("type", 1);
				}
				else if (!teacher.getPassword().equals(password)) {
					map.put("success", false);
					map.put("code", "100");
					map.put("info", "密码错误");
					map.put("password", false);
					map.put("type", 2);
				}
				else if (teacher.getPassword().equals(password)) {
					map.put("success", true);
					map.put("info", "登录成功");
					map.put("type", 0);
					session.setAttribute("LOGIN", username);
					session.setAttribute("username", username);
					session.setAttribute("loginname", teacher.getName());
					session.setAttribute("role", "teacher");
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
//	@RequestMapping(value="/springtest")
//	public String goSpringTest(Model model,
//			@RequestParam(value="page",defaultValue="1") Integer page) {
//		
//		PageHelper.startPage(page, 10);
//		List<Teacher> list = teacherService.getAll();
//		PageInfo<Teacher> pageInfo = new PageInfo<Teacher>(list);
//		model.addAttribute("pageInfo", pageInfo);
//		return "springtest";
//	}
	
	@RequestMapping(value="/findall")
	@ResponseBody
	public Map<String, Object> findAll(){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
//			List<Teacher> teachers = teacherMapper.findAll();
			List<Teacher> teachers = teacherService.getAll();
			map.put("teachers", teachers);
			map.put("success", true);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return map;
	}

}
