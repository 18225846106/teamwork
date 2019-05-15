package cn.edu.ahut.teamwork;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.edu.ahut.teamwork.dao.TeacherMapper;
import cn.edu.ahut.teamwork.entity.Teacher;

public class TestMapper {
	
	@Test
	public void mapper() {
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
		TeacherMapper teacherMapper = applicationContext.getBean(TeacherMapper.class);
//		List<Teacher> teachers = teacherMapper.findAll();
		List<Teacher> teachers = teacherMapper.selectByExample(null);
		Teacher teacher = teachers.get(0);
		System.out.println(teacher.toString());
		System.out.println(teachers);
	}
	
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
