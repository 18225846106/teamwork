package cn.edu.ahut.teamwork.dao;

import cn.edu.ahut.teamwork.entity.Teamstudent;
import cn.edu.ahut.teamwork.entity.TeamstudentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TeamstudentMapper {
	
	//根据课程编号查找该课程内的小组学生关系表
	List<Teamstudent> findByCourseid(@Param("courseid") String courseid);
	
    long countByExample(TeamstudentExample example);

    int deleteByExample(TeamstudentExample example);

    int insert(Teamstudent record);

    int insertSelective(Teamstudent record);

    List<Teamstudent> selectByExample(TeamstudentExample example);

    int updateByExampleSelective(@Param("record") Teamstudent record, @Param("example") TeamstudentExample example);

    int updateByExample(@Param("record") Teamstudent record, @Param("example") TeamstudentExample example);
}