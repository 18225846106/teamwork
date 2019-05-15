package cn.edu.ahut.teamwork.dao;

import cn.edu.ahut.teamwork.entity.Coursestudent;
import cn.edu.ahut.teamwork.entity.CoursestudentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CoursestudentMapper {
	
	//根据课程id查找学生id
	List<Coursestudent> findStudentByCourseId(@Param("courseid") String courseid);
	
    long countByExample(CoursestudentExample example);

    int deleteByExample(CoursestudentExample example);

    int insert(Coursestudent record);

    int insertSelective(Coursestudent record);

    List<Coursestudent> selectByExample(CoursestudentExample example);

    int updateByExampleSelective(@Param("record") Coursestudent record, @Param("example") CoursestudentExample example);

    int updateByExample(@Param("record") Coursestudent record, @Param("example") CoursestudentExample example);
}