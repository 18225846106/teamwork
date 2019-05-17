package cn.edu.ahut.teamwork.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.ahut.teamwork.dao.CourseMapper;
import cn.edu.ahut.teamwork.entity.Course;

/**
 * 课程服务层
 * @author Administrator
 *
 */
@Service
public class CourseService {

	@Autowired
	CourseMapper courseMapper;
	
	/**
	 * 根据教师id查找课程
	 * @param tid
	 * @return
	 */
	public List<Course> findByTeacherId(String tid) {
		List<Course> courses = courseMapper.findByTeacherId(tid);
		return courses;
	}
	
	/**
	 * 根据课程id查找课程
	 * @param courseid
	 * @return
	 */
	public Course findCourseByCourseid(String courseid) {
		Course course = courseMapper.findCourseByCourseid(courseid);
		return course;
	}
	
	/**
	 * 修改课程信息
	 * @param course
	 * @return
	 */
	public int updateCourse(Course course) {
		int result = courseMapper.updateCourse(course);
		return result;
	}
}
