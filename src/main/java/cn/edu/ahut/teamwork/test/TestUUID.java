package cn.edu.ahut.teamwork.test;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.junit.Test;

public class TestUUID {

	@Test
	public  void main() {
		UUID id = UUID.randomUUID();
		System.out.println(id);
		String uid = id.toString();
		System.out.println(uid);
	}
	
	@Test
	public void maptostring() {
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map2 = new HashMap<String, Object>();
		map.put("159", 10);
//		map.put("158", 13);
		String stringmap = map.toString();
		
		System.out.println(map.toString());
		
		System.out.println(stringmap);
		
		String [] stm1 = stringmap.replace("{", "").replace("}", "").trim().split(",");
		System.out.print(stm1[0]);
//		System.out.println(stm1[1]);
		
		String [] stm2 ;
		for (int i = 0; i < stm1.length; i++) {
			stm2 = stm1[i].split("=");
			map2.put(stm2[0], stm2[1]);
		}
		System.out.println(map2);
		System.out.println(map2.toString());
	}
}
