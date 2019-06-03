package cn.edu.ahut.teamwork.dao;

import cn.edu.ahut.teamwork.entity.Teamstudent;
import cn.edu.ahut.teamwork.entity.TeamstudentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TeamstudentMapper {
	
	//根据课程编号查找该课程内的小组学生关系表
	List<Teamstudent> findByCourseid(@Param("courseid") String courseid);
	
	//根据teamstudent查找teamstudent
	List<Teamstudent> findTeamstudentByTeamstudent(Teamstudent teamstudent);
	
	//插入新的小组学生表
	int insertTeamstudent(Teamstudent teamstudent);
	
	//修改teamstudent
	int updateTeamstudent(Teamstudent teamstudent);
	
	//根据课程id删除小组学生
	int deleteTeamstudentByCourseid(@Param("courseid") String courseid);
	
	//删除teamstudent
	int deleteTeamstudent(Teamstudent teamstudent);
	
    long countByExample(TeamstudentExample example);

    int deleteByExample(TeamstudentExample example);

    int insert(Teamstudent record);

    int insertSelective(Teamstudent record);

    List<Teamstudent> selectByExample(TeamstudentExample example);

    int updateByExampleSelective(@Param("record") Teamstudent record, @Param("example") TeamstudentExample example);

    int updateByExample(@Param("record") Teamstudent record, @Param("example") TeamstudentExample example);
}