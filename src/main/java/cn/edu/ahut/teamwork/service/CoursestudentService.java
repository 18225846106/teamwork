package cn.edu.ahut.teamwork.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.ahut.teamwork.dao.CoursestudentMapper;
import cn.edu.ahut.teamwork.entity.Coursestudent;

@Service
public class CoursestudentService {
	
	@Autowired
	CoursestudentMapper coursestudentMapper;
	
	/**
	 * 插入 coursestudent 数据
	 * @param coursestudent
	 * @return
	 */
	public int insertCoursestudent(Coursestudent coursestudent) {
		int result = coursestudentMapper.insertCoursestudent(coursestudent);
		return result;
	}
	
	/**
	 * 插入 coursestudent 数据 选择列
	 * @param coursestudent
	 * @return
	 */
	public int insertCoursestudentSelect(Coursestudent coursestudent) {
		int result = coursestudentMapper.insertCoursestudentSelect(coursestudent);
		return result;
	}
	
	/**
	 * 根据课程id查找学生id
	 * @param courseid
	 * @return
	 */
	public List<Coursestudent> findCoursestudentByCourseId(String courseid){
		List<Coursestudent> coursestudents = coursestudentMapper.findCoursestudentByCourseId(courseid);
		return coursestudents;
	}
	
	/**
	 * 根据课程id，学生id，精确定位查找
	 * @param coursestudent
	 * @return
	 */
	public Coursestudent findCoursestudentByCsid(Coursestudent coursestudent) {
		Coursestudent coursestudentr = coursestudentMapper.findCoursestudentByCsid(coursestudent);
		return coursestudentr;
	}
	
	/**
	 * 根据 班级学生实体 查询 班级学生表
	 * @param coursestudent
	 * @return
	 */
	public List<Coursestudent> findCoursestudent(Coursestudent coursestudent){
		List<Coursestudent> coursestudents = coursestudentMapper.findCoursestudent(coursestudent);
		return coursestudents;
	}
	
	/**
	 * 根据 班级学生实体 修改 班级学生表
	 * @param coursestudent
	 * @return
	 */
	public int updateCoursestudent(Coursestudent coursestudent) {
		int result = coursestudentMapper.updateCoursestudent(coursestudent);
		return result;
	}
	
	/**
	 * 更新班级学生分数,courseid，studentid
	 * @param coursestudent
	 * @return
	 */
	public int updateCoursestudentScore(Coursestudent coursestudent) {
		int result = coursestudentMapper.updateCoursestudentScore(coursestudent);
		return result;
	}
	
	/**
	 * 删除 coursestudent 数据
	 * @param coursestudent
	 * @return
	 */
	public int deleteCoursestudent(Coursestudent coursestudent) {
	int result = coursestudentMapper.deleteCoursestudent(coursestudent);
	return result;
	}

}
