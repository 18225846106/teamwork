package cn.edu.ahut.teamwork.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.ahut.teamwork.dao.ProjectMapper;
import cn.edu.ahut.teamwork.entity.Project;

@Service
public class ProjectService {

	@Autowired
	ProjectMapper projectMapper;
	
	/**
	 * 通过项目属性查询项目信息
	 * @param project
	 * @return
	 */
	public List<Project> findProjectByProject(Project project){
		List<Project> projects = projectMapper.findProjectByProject(project);
		return projects;
	}
	
	/**
	 * 通过小组的id到项目表中查询小组的项目
	 * @param teamid
	 * @return
	 */
	public List<Project> findProjectByTeamid(String teamid) {
		List<Project> projects = projectMapper.findProjectByTeamid(teamid);
		return projects;
	}
	
	/**
	 * 通过id查找项目信息
	 * @param id
	 * @return
	 */
	public Project findProjectById(String id) {
		Project project = projectMapper.findProjectById(id);
		return project;
	}
	
	/**
	 * 通过项目的班级编号courseid查询所有项目
	 * @param courseid
	 * @return
	 */
	public	List<Project> findProjectByCourseid(String courseid){
		List<Project> projects = projectMapper.findProjectByCourseid(courseid);
		return projects;
	}
	
	/**
	 * 插入一条新的项目
	 * @param project
	 * @return
	 */
	public int insertProject(Project project) {
		int result = projectMapper.insertProject(project);
		return result;
	}
	
	/**
	 * 根据id修改项目的信息
	 * @param project
	 * @return
	 */
	public int updateProject(Project project) {
		int result = projectMapper.updateProject(project);
		return result;
	}
	/**
	 * 删除项目，根据id
	 * @param projectid
	 * @return
	 */
	public int deleteProject(String projectid) {
		int result = projectMapper.deleteProject(projectid);
		return result;
	}
	
	/**
	 * 根据班级编号，删除项目
	 * @param courseid
	 * @return
	 */
	public int deleteProjecByCourseid(String courseid) {
		int result = projectMapper.deleteProjecByCourseid(courseid);
		return result;
	}
}
