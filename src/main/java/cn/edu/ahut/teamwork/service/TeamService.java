package cn.edu.ahut.teamwork.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.ahut.teamwork.dao.TeamMapper;
import cn.edu.ahut.teamwork.entity.Team;

@Service
public class TeamService {

	@Autowired
	TeamMapper teamMapper;
	
	/**
	 * 根据班级id找到小组
	 * @param courseid
	 * @return
	 */
	public List<Team> findTeamByCourseid(String courseid){
		List<Team> teams = teamMapper.findTeamByCourseid(courseid);
		return teams;
	}
}
