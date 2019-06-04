package cn.edu.ahut.teamwork.test;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;

public class TestTime {

	@Test
	public void testtime() {
		try {
		Date date = new Date();
		System.out.println(date);
		
		String sdate = (new Date()).toString();
		System.out.println(sdate);
		
//		String ldate = (new Date()).toLocaleString();
//		System.out.println(ldate);
		
//		String sjcdate = (new Date()).toGMTString();
//		System.out.println(sjcdate);
		
		Long sjcd = (new Date()).getTime();
		System.out.println(sjcd);
		sjcd.toString();
		System.out.println(new Date(Long.valueOf(sjcd.toString())));
		
//		String  long1 = "1557805352942";
		Date date2 = new Date(sjcd);
		System.out.println(date2);
		
		String datetime = "2019-5-14 11:33:02";
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat();
		if (datetime.contains("/") && datetime.contains(":")) {
			simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		}else if (datetime.contains("-") && datetime.contains(":")) {
			simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		}
		
        date = simpleDateFormat.parse(datetime);
        long ts = date.getTime();
        System.out.println(ts);
		
		
		
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
