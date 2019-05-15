package cn.edu.ahut.teamwork.dao;

import cn.edu.ahut.teamwork.entity.Projectstudent;
import cn.edu.ahut.teamwork.entity.ProjectstudentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ProjectstudentMapper {
    long countByExample(ProjectstudentExample example);

    int deleteByExample(ProjectstudentExample example);

    int insert(Projectstudent record);

    int insertSelective(Projectstudent record);

    List<Projectstudent> selectByExample(ProjectstudentExample example);

    int updateByExampleSelective(@Param("record") Projectstudent record, @Param("example") ProjectstudentExample example);

    int updateByExample(@Param("record") Projectstudent record, @Param("example") ProjectstudentExample example);
}