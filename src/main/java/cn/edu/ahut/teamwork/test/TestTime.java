package cn.edu.ahut.teamwork.test;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;

public class TestTime {

	@Test
	public void testtime() {
		try {
		Date date = new Date();
		System.out.println(date);
		
		String sdate = (new Date()).toString();
		System.out.println(sdate);
		
		String ldate = (new Date()).toLocaleString();
		System.out.println(ldate);
		
		String sjcdate = (new Date()).toGMTString();
		System.out.println(sjcdate);
		
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
	
	@Test
	public void name() {
		int a = 10;
		int b = 18;
		int c = 14;
		System.out.println(b/a + " " + c/a);
	}
	
	@Test
	public void lis() {
		List<String> strings = new ArrayList<String>();
		strings.add("0");
		strings.add("1");
		strings.add("2");
		strings.add("3");
		strings.add("4");
		strings.add("5");
		strings.add("6");
		strings.add("7");
		strings.add("8");
		strings.add("9");
//		strings.add("10");
//		strings.add("11");
//		strings.add("12");
//		strings.add("13");
//		strings.add("14");
//		strings.add("15");
//		strings.add("16");
//		strings.add("17");
//		strings.add("18");
//		strings.add("19");
//		strings.add("20");
//		strings.add("21");
//		strings.add("22");
//		strings.add("23");
//		strings.add("24");
//		strings.add("25");
//		strings.add("26");
//		strings.add("27");
//		strings.add("28");
//		strings.add("29");
//		System.out.println(strings.size());
		List<String> list = new ArrayList<String>();
		List<Integer> ind = new ArrayList<Integer>();
		Map<String, Object> res = new HashMap<String, Object>();
		int count = 3;//每组多少人
		
		int groupcount = strings.size()/count;
		if (strings.size()%count > 0) {
			groupcount = groupcount + 1;
		}
//		System.out.println(groupcount);
		
		int j = 0;
		int k = 0;
		for(int i=0; i<strings.size(); i++) {
			list.add(strings.get(j));
			//j = j + count;
			j = j + groupcount;
			if (j >= strings.size()) {
				k = k + 1;
				j = k;
				//j = (j + 1) % strings.size();
				System.out.println(list.size());
				System.out.println(list);
				ind.add(list.size());
			}
		}
		//System.out.println(list);
//		System.out.println(list.size());
		
//		for(int m = 0;m<list.size();m=m+count) {
//			//xin
//			for(int n=0;n<count;n++) {
//				
//			}
//		}
		res.put("lis", list);
		res.put("ind", ind);
		System.out.println(res);
		System.out.println(((List<String>) res.get("lis")).size());
	}
}
