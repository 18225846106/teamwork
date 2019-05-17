package cn.edu.ahut.teamwork.dao;

import cn.edu.ahut.teamwork.entity.Course;
import cn.edu.ahut.teamwork.entity.CourseExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CourseMapper {
	
	//根据教师id查找课程
	List<Course> findByTeacherId(@Param("tid") String tid);
	
	//根据课程id查找课程
	Course findCourseByCourseid(@Param("courseid") String courseid);
	
	//修改课程信息
	int updateCourse(Course course);
	
    long countByExample(CourseExample example);

    int deleteByExample(CourseExample example);

    int insert(Course record);

    int insertSelective(Course record);

    List<Course> selectByExample(CourseExample example);

    int updateByExampleSelective(@Param("record") Course record, @Param("example") CourseExample example);

    int updateByExample(@Param("record") Course record, @Param("example") CourseExample example);
}