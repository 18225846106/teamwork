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
