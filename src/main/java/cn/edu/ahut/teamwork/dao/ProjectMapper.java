package cn.edu.ahut.teamwork.dao;

import cn.edu.ahut.teamwork.entity.Project;
import cn.edu.ahut.teamwork.entity.ProjectExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ProjectMapper {
	
	//通过项目属性查询项目信息
	List<Project> findProjectByProject(Project project);
	
	//通过小组的id到项目表中查询小组的项目
	List<Project> findProjectByTeamid(@Param("teamid") String teamid);
	
	//通过项目id查找项目信息
	Project findProjectById(@Param("id") String id);
	
	//通过项目的班级编号courseid查询所有项目
	List<Project> findProjectByCourseid(@Param("courseid") String courseid);
	
	//插入一条新的项目
	int insertProject(Project project);
	
	//根据id修改项目的信息
	int updateProject(Project project);
	
	//删除项目根据id
	int deleteProject(@Param("id") String projectid);
	
	//根据班级编号，删除项目
	int deleteProjecByCourseid(@Param("courseid") String courseid);
	
    long countByExample(ProjectExample example);

    int deleteByExample(ProjectExample example);

    int insert(Project record);

    int insertSelective(Project record);

    List<Project> selectByExample(ProjectExample example);

    int updateByExampleSelective(@Param("record") Project record, @Param("example") ProjectExample example);

    int updateByExample(@Param("record") Project record, @Param("example") ProjectExample example);
}