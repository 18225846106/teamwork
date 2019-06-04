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

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.edu.ahut.teamwork.entity.Student;
import cn.edu.ahut.teamwork.entity.Teacher;
import cn.edu.ahut.teamwork.service.StudentService;
import cn.edu.ahut.teamwork.service.TeacherService;

@Controller
@RequestMapping(value="/testcontroller")
public class TestController {
	
	@Autowired
	StudentService studentService;
	
	@Autowired
	TeacherService teacherService;
	
	/*
	 * 测试springmvc的效果，controller注解的扫描
	 */
	@RequestMapping(value="/test1")
	public String test1() {
		return "TestSpringMvc";
	}
	
	@RequestMapping(value="/login")
	public String Login() {
		return "Login";
	}
	
	@RequestMapping(value="/studentmain")
	public String Studentmain() {
		return "StudentMain";
	}
	
	@RequestMapping(value="/test2")
	@ResponseBody
	public Map<String, Object> test2(){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map.put("test", "test2's value");
			map.put("success", true);
			map.put("he", "1111");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
	
	@RequestMapping(value="/test3")
	@ResponseBody
	public Map<String, Object> test3(){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			List<Teacher> teachers = teacherService.getAll();
			map.put("teachers", teachers);
			map.put("test", "this is test3");
			map.put("success", true);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;
	}
	
	@RequestMapping(value="/pagehelper")
	public String PageHelper(@RequestParam(value="pag", defaultValue="1") Integer pag,
			HttpServletRequest request,HttpServletResponse response,Model model) {
		try {
			PageHelper.startPage(pag, 5);
			List<Student> students = studentService.findAll();
			PageInfo<Student> pageInfo = new PageInfo<Student>(students);
			request.setAttribute("pageInfo", pageInfo);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		
		return "pagehelper";
	}

}
