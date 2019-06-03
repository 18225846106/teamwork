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
	
	/**
	 * 根据小组id找到小组
	 * @param teamid
	 * @return
	 */
	public Team findTeamByTeamid(String teamid) {
		Team team = teamMapper.findTeamByTeamid(teamid);
		return team;
	}
	
	/**
	 * 根据team找到小组
	 * @param team
	 * @return
	 */
	public List<Team> findTeam(Team team){
		List<Team> teams = teamMapper.findTeam(team);
		return teams;
	}
	
	/**
	 * 插入一个新的小组
	 * @param team
	 * @return
	 */
	public int insertTeam(Team team) {
		int result = teamMapper.insertTeam(team);
		return result;
	}
	
	/**
	 * 插入一个新的小组
	 * @param team
	 * @return
	 */
	public int insertTeamSelect(Team team) {
		int result = teamMapper.insertTeamSelect(team);
		return result;
	}
	
	/**
	 * 根据id 更新 小组 信息
	 * @param team
	 * @return
	 */
	public int updateTeamById(Team team) {
		int result = teamMapper.updateTeamById(team);
		return result;
	}
	
	/**
	 * 更新 小组 信息
	 * @param team
	 * @return
	 */
	public int updateTeam(Team team) {
		int result = teamMapper.updateTeam(team);
		return result;
	}
	
	/**
	 * 根据课程id删除对应课程的分组
	 * @param courseid
	 * @return
	 */
	public int deleteTeamByCourseid(String courseid) {
		int result = teamMapper.deleteTeamByCourseid(courseid);
		return result;
	}
}
