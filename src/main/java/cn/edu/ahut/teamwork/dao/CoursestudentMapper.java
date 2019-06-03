package cn.edu.ahut.teamwork.dao;

import cn.edu.ahut.teamwork.entity.Coursestudent;
import cn.edu.ahut.teamwork.entity.CoursestudentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CoursestudentMapper {
	
	//插入 coursestudent 数据
	int insertCoursestudent(Coursestudent coursestudent);
	
	//插入 coursestudent 数据 选择列
	int insertCoursestudentSelect(Coursestudent coursestudent);
	
	//根据课程id查找学生id
	List<Coursestudent> findCoursestudentByCourseId(@Param("courseid") String courseid);
	
	//根据课程id，学生id，精确定位查找
	Coursestudent findCoursestudentByCsid(Coursestudent coursestudent);
	
	//根据 班级学生实体 查询 班级学生表
	List<Coursestudent> findCoursestudent(Coursestudent coursestudent);
	
	//根据 班级学生实体 修改 班级学生表
	int updateCoursestudent(Coursestudent coursestudent);
	
	//更新班级学生分数,courseid，studentid
	int updateCoursestudentScore(Coursestudent coursestudent);
	
	//删除 coursestudent 数据
	int deleteCoursestudent(Coursestudent coursestudent);
	
    long countByExample(CoursestudentExample example);

    int deleteByExample(CoursestudentExample example);

    int insert(Coursestudent record);

    int insertSelective(Coursestudent record);

    List<Coursestudent> selectByExample(CoursestudentExample example);

    int updateByExampleSelective(@Param("record") Coursestudent record, @Param("example") CoursestudentExample example);

    int updateByExample(@Param("record") Coursestudent record, @Param("example") CoursestudentExample example);
}