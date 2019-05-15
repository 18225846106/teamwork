package cn.edu.ahut.teamwork.test;

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
}
