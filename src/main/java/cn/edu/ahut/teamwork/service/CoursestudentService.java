package cn.edu.ahut.teamwork.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.ahut.teamwork.dao.CoursestudentMapper;
import cn.edu.ahut.teamwork.entity.Coursestudent;

@Service
public class CoursestudentService {
	
	@Autowired
	CoursestudentMapper coursestudentMapper;
	
	public List<Coursestudent> findStudentByCourseId(String courseid) {
		List<Coursestudent> coursestudents = coursestudentMapper.findStudentByCourseId(courseid);
		return coursestudents;
	}

}
