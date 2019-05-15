package cn.edu.ahut.teamwork.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.ahut.teamwork.dao.TeacherMapper;
import cn.edu.ahut.teamwork.entity.Teacher;

@Service
public class TeacherService {

	@Autowired
	TeacherMapper teacherMapper;
	
	//根据教师id查询教师
	public Teacher findById(String id) {
		Teacher teacher = teacherMapper.findById(id);
		return teacher;
	}
	
	public List<Teacher> getAll() {
		// TODO Auto-generated method stub
//		return teacherMapper.findAll();
		return teacherMapper.selectByExample(null);
	}

}
