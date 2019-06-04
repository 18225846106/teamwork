package cn.edu.ahut.teamwork.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.ahut.teamwork.dao.StudentMapper;
import cn.edu.ahut.teamwork.entity.Student;

@Service
public class StudentService {
	
	@Autowired
	StudentMapper studentMapper;
	
	//增加学生
	public int insertStudent(Student student) {
		int result = studentMapper.insertStudent(student);
		return result;
	}
		
	//根据id删除学生
	public int deleteStudentById(String id) {
		int result = studentMapper.deleteStudentById(id);
		return result;
	}
	
	//删除学生
	public int deleteStudent(Student student) {
		int result = studentMapper.deleteStudent(student);
		return result;
	}
		
	//更新学生信息
	public int updateStudent(Student student) {
		int result = studentMapper.updateStudent(student);
		return result;
	}
	
	public List<Student> findAll(){
		List<Student> students = studentMapper.findAll();
		return students;
	}
	
	public Student findById(String id) {
		Student student = studentMapper.findById(id);
		return student;
	}
	
	public List<Student> findByName(String name){
		List<Student> students = studentMapper.findByName(name);
		return students;
	}

}
