package cn.edu.ahut.teamwork.util;

import java.text.SimpleDateFormat;
import java.util.Date;

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
}
