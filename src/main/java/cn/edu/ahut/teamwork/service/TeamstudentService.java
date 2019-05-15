package cn.edu.ahut.teamwork.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.ahut.teamwork.dao.TeamstudentMapper;
import cn.edu.ahut.teamwork.entity.Teamstudent;

@Service
public class TeamstudentService {

	@Autowired
	TeamstudentMapper teamstudentMapper;
	
	/**
	 * 根据课程编号查找所有该课程内的小组信息
	 * @param courseid
	 * @return
	 */
	public List<Teamstudent> findByCourseid(String courseid) {
		List<Teamstudent> teamstudents = teamstudentMapper.findByCourseid(courseid);
		return teamstudents;
	}
}
