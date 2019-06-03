package cn.edu.ahut.teamwork.dao;

import cn.edu.ahut.teamwork.entity.Assignment;
import cn.edu.ahut.teamwork.entity.AssignmentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface AssignmentMapper {
	
	//根据项目编号查找任务信息
	List<Assignment> findAssignmentByProjectid(@Param("projectid") String projectid);
	
	//根据任务id查找任务信息
	Assignment findAssignmentByid(@Param("assignmentid") String assignmentid);
	
	//全属性插入新建一个任务
	int insertAssignment(Assignment assignment);
	
	//根据id修改任务的信息
	int updateAssignment(Assignment assignment);
	
	//删除任务根据id
	int deleteAssignment(@Param("id") String assignmentid);
	
	//根据项目编号，删除任务
	int deleteAssignmentByProjectid(@Param("projectid") String projectid);
	
	//根据学生编号，删除任务
	int deleteAssignmentByStudentid(@Param("studentid") String studentid);
	
	//
    long countByExample(AssignmentExample example);

    int deleteByExample(AssignmentExample example);

    int insert(Assignment record);

    int insertSelective(Assignment record);

    List<Assignment> selectByExample(AssignmentExample example);

    int updateByExampleSelective(@Param("record") Assignment record, @Param("example") AssignmentExample example);

    int updateByExample(@Param("record") Assignment record, @Param("example") AssignmentExample example);
}