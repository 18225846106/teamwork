package cn.edu.ahut.teamwork.dao;

import cn.edu.ahut.teamwork.entity.Student;
import cn.edu.ahut.teamwork.entity.StudentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface StudentMapper {
	
	//查看所有学生
	List<Student> findAll();
	
	//根据id查找学生
	Student findById(@Param("id") String id);
	
	//根据学生姓名进行模糊查询
	List<Student> findByName(@Param("name") String name);
	
    long countByExample(StudentExample example);

    int deleteByExample(StudentExample example);

    int insert(Student record);

    int insertSelective(Student record);

    List<Student> selectByExample(StudentExample example);

    int updateByExampleSelective(@Param("record") Student record, @Param("example") StudentExample example);

    int updateByExample(@Param("record") Student record, @Param("example") StudentExample example);
}