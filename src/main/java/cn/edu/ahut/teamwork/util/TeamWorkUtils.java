package cn.edu.ahut.teamwork.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.edu.ahut.teamwork.entity.Student;

public class TeamWorkUtils {

	/**
	 * 字符串转时间格式String - Date
	 * @param datetime 字符串类型的时间
	 * @return
	 * @throws Exception
	 */
	public Date StringToDate(String datetime) throws Exception {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat();
		Date date;
		if (datetime.contains("/") && datetime.contains(":")) {
			simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			date = simpleDateFormat.parse(datetime);
		}else if (datetime.contains("-") && datetime.contains(":")) {
			simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			date = simpleDateFormat.parse(datetime);
		}
		else {
			//时间戳转时间
			date = new Date(Long.valueOf(datetime));
		}
		return date;
	}
	
	/**
	 * 分组,对学生列表重新排序
	 * @param count 每组多少人
	 * @param students 学生列表
	 * @return List<Student> groupstudent
	 */
	public List<Student> sortStudents(Integer count,List<Student> students){
		//分几个小组
		int groupcount = students.size()/count;
		if (students.size()%count > 0) {
			groupcount = groupcount + 1;
		}
		//存储排序的students
		List<Student> groupstudent = new ArrayList<Student>();
		int j = 0;
		int k = 0;
		for(int i=0; i<students.size(); i++) {
			groupstudent.add(students.get(j));
			j = j + groupcount;
			if (j >= students.size()) {
				k = k + 1;
				j = k;
			}
		}
		return groupstudent;
	}
	
	public Map<String, Object> sortStudentsm(Integer count,List<Student> students){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			
				//分几个小组
				int groupcount = students.size()/count;
				if (students.size()%count > 0) {
					groupcount = groupcount + 1;
				}
				//存储排序的students
				List<Student> groupstudent = new ArrayList<Student>();
				//排序的下标
				List<Integer> groupindex = new ArrayList<Integer>();
				int j = 0;
				int k = 0;
				for(int i=0; i<students.size(); i++) {
					groupstudent.add(students.get(j));
					j = j + groupcount;
					if (j >= students.size()) {
						k = k + 1;
						j = k;
						groupindex.add(groupstudent.size());
					}
				}
				result.put("students", groupstudent);
				result.put("index", groupindex);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}
	
}
