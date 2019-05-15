package cn.edu.ahut.teamwork;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.edu.ahut.teamwork.dao.TeacherMapper;
import cn.edu.ahut.teamwork.entity.Teacher;

public class TeacherTest {

	@SuppressWarnings("resource")
	@Test
	public void springMybatisTest() throws Exception {
		String springmybatisbeans = "applicationContext.xml";
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext(springmybatisbeans);
		TeacherMapper teacherMapper = (TeacherMapper) applicationContext.getBean("teacherMapper");
//		List<Teacher> teachers = teacherMapper.findAll();
		List<Teacher> teachers = teacherMapper.selectByExample(null);
		System.out.println(teachers.toString());
	}
}
