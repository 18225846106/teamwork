package cn.edu.ahut.teamwork.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.edu.ahut.teamwork.dao.StudentMapper;
import cn.edu.ahut.teamwork.dao.TeacherMapper;
import cn.edu.ahut.teamwork.entity.Student;
import cn.edu.ahut.teamwork.entity.Teacher;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class TestSpring {

	@Autowired
	StudentMapper studentMapper;
	
	@Autowired
	TeacherMapper teacherMapper;
	
	@Test
	public void autowiredTeacherMapper() {
		System.out.println(teacherMapper);
//		List<Teacher> teachers = teacherMapper.findAll();
		List<Teacher> teachers = teacherMapper.selectByExample(null);
		System.out.println(teachers);
	}
	
	@Test
	public void findById() {
		Student student = studentMapper.findById("159074016");
		System.out.println(student);
	}
}
