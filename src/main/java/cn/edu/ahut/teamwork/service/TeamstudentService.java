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
	
	/**
	 * 根据teamstudent查找teamstudent
	 * @param teamstudent
	 * @return
	 */
	public List<Teamstudent> findTeamstudentByTeamstudent(Teamstudent teamstudent) {
		List<Teamstudent> teamstudents = teamstudentMapper.findTeamstudentByTeamstudent(teamstudent);
		return teamstudents;
	}
	
	/**
	 * 插入新的小组学生表
	 * @param teamstudent
	 * @return
	 */
	public int insertTeamstudent(Teamstudent teamstudent) {
		int result = teamstudentMapper.insertTeamstudent(teamstudent);
		return result;
	}
	
	/**
	 * 修改teamstudent
	 * @param teamstudent
	 * @return
	 */
	public int updateTeamstudent(Teamstudent teamstudent) {
		int result = teamstudentMapper.updateTeamstudent(teamstudent);
		return result;
	}
	
	/**
	 * 根据课程id删除小组学生
	 * @param courseid
	 * @return
	 */
	public int deleteTeamstudentByCourseid(String courseid) {
		int result = teamstudentMapper.deleteTeamstudentByCourseid(courseid);
		return result;
	}
	
	/**
	 * 删除teamstudent
	 * @param teamstudent
	 * @return
	 */
	public int deleteTeamstudent(Teamstudent teamstudent) {
		int result = teamstudentMapper.deleteTeamstudent(teamstudent);
		return result;
	}
}
