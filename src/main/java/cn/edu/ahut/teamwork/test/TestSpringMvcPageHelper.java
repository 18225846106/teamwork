package cn.edu.ahut.teamwork.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;

import cn.edu.ahut.teamwork.entity.Student;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml","classpath:dispatcherServlet-servlet.xml"})
public class TestSpringMvcPageHelper {

	@Autowired
	WebApplicationContext webApplicationContext;
	
	MockMvc mockMvc;
	
	@Before
	public void initMokMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
	}
	
	@Test
	public void testPage() throws Exception {
		try {

			MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/testcontroller/pagehelper").param("pag", "1")).andReturn();
			
			MockHttpServletRequest request = result.getRequest();
			
			System.out.println("项目路径："+request.getContextPath());
			
			PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
			
			System.out.println("当前页码："+pageInfo.getPageNum());
			
			System.out.println("总页码："+pageInfo.getPages());
			
			System.out.println("总记录数："+pageInfo.getTotal());
			
			System.out.println("第一个页码："+pageInfo.getNavigateFirstPage());
			
			System.out.println("最后一个页码："+pageInfo.getNavigateLastPage());
			
			System.out.println("显示的页码范围："+pageInfo.getNavigatepageNums());
			
			System.out.print("页码：");
			for(int i : pageInfo.getNavigatepageNums()) {
				System.out.print("  "+i);
			}
			System.out.println();
			
			List<Student> student = pageInfo.getList();
//			for (Student student2 : student) {
//				System.out.println(student2.toString());
//			}
			
			for(int i=0; i<student.size();i++) {
				System.out.println(student.get(i));
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
