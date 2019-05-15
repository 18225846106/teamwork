package cn.edu.ahut.teamwork.dao;

import cn.edu.ahut.teamwork.entity.Team;
import cn.edu.ahut.teamwork.entity.TeamExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TeamMapper {
	
	//根据班级id找到小组
	List<Team> findTeamByCourseid(@Param("courseid") String courseid);
	
    long countByExample(TeamExample example);

    int deleteByExample(TeamExample example);

    int insert(Team record);

    int insertSelective(Team record);

    List<Team> selectByExample(TeamExample example);

    int updateByExampleSelective(@Param("record") Team record, @Param("example") TeamExample example);

    int updateByExample(@Param("record") Team record, @Param("example") TeamExample example);
}