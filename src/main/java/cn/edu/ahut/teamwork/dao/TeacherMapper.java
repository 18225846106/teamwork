package cn.edu.ahut.teamwork.dao;

import cn.edu.ahut.teamwork.entity.Teacher;
import cn.edu.ahut.teamwork.entity.TeacherExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TeacherMapper {
	
	List<Teacher> findAll();
	
	Teacher findById(@Param("id") String id);
	
	List<Teacher> findByName(@Param("name") String name);
	
    long countByExample(TeacherExample example);

    int deleteByExample(TeacherExample example);

    int insert(Teacher record);

    int insertSelective(Teacher record);

    List<Teacher> selectByExample(TeacherExample example);

    int updateByExampleSelective(@Param("record") Teacher record, @Param("example") TeacherExample example);

    int updateByExample(@Param("record") Teacher record, @Param("example") TeacherExample example);
}