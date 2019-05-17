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

import cn.edu.ahut.teamwork.entity.Course;
import cn.edu.ahut.teamwork.service.CourseService;

/**
 * 课程控制层
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="/course")
public class CourseController {

	@Autowired
	CourseService courseService;
	
	/**
	 * @author laq
	 * @time 2019
	 * @param username 教师id，用来查询教师所带的课程
	 * @param pageNum 第几页开始
	 * @param pageSize 每页多少条
	 * @param request
	 * @param response
	 * @param model
	 * @return 跳转到课程详情页面
	 */
	@RequestMapping(value="/findbyteacherid")
	public String findByTeacherId(
			@Param(value="username") String username,
			@RequestParam(value="pageNum", defaultValue="1") Integer pageNum,
			@RequestParam(value="pageSize",defaultValue="5") Integer pageSize,
			HttpServletRequest request,HttpServletResponse response,Model model) {
		try {
			PageHelper.startPage(pageNum, pageSize);
			List<Course> courses = courseService.findByTeacherId(username);
			PageInfo<Course> pageInfo = new PageInfo<Course>(courses);
			request.setAttribute("pageInfo", pageInfo);
			request.setAttribute("pageInfoA", pageInfo);
			model.addAttribute("pageInfoB", pageInfo);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "TeacherCourse";
	}
	
	/**
	 * 
	 * @param username
	 * @param pageNum
	 * @param pageSize
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findcoursesbyteacheridpagehelper")
	@ResponseBody
	public Map<String, Object> findCoursesByTeacherIdPageHelper(
			@Param(value="username") String username,
			@RequestParam(value="pageNum", defaultValue="1") Integer pageNum,
			@RequestParam(value="pageSize",defaultValue="5") Integer pageSize,
			HttpServletRequest request,HttpServletResponse response,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (username == null || username == "") {
				map.put("code", "100");
				map.put("info", "用户名丢失!");
			} else {
				List<Course> courses = courseService.findByTeacherId(username);
				if (courses == null) {
					map.put("code", "100");
					map.put("info", "查询结果丢失!");
				} else {
					PageHelper.startPage(pageNum, pageSize);
					PageInfo<Course> pageInfo = new PageInfo<Course>(courses);
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
	 * 通过课程id查找课程
	 * @param courseid
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findcoursebycourseid")
	@ResponseBody
	public Map<String, Object> findCourseByCourseid(
			@RequestParam(value="courseid",defaultValue="") String courseid,
			HttpServletRequest request,HttpServletResponse response,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (courseid == null || courseid.equals("")) {
				map.put("code", "100");
				map.put("info", "此课程编号丢失!");
			}else {
				Course course = courseService.findCourseByCourseid(courseid);
				if (course == null) {
					map.put("code", "100");
					map.put("info", "查询失败!");
				}else {
					map.put("code", "200");
					map.put("info", "查询成功!");
					map.put("course", course);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return map;
	}
}
