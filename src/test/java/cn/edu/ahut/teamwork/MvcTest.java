package cn.edu.ahut.teamwork;

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
@ContextConfiguration(locations= {"classpath:applicationContext.xml","classpath:dispatcherServlet-servlet.xml"})
public class MvcTest {

	//psringmvc ioc
	@Autowired
	WebApplicationContext context;
	
	//mok mvc request
	MockMvc mockMvc;
	
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void page() throws Exception {
		MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/springtest").param("page", "1")).andReturn();
		MockHttpServletRequest request = mvcResult.getRequest();
		@SuppressWarnings("unchecked")
		PageInfo<Student> pageInfo = (PageInfo<Student>)request.getAttribute("pageInfo");
		System.out.println(pageInfo.getPageNum());
	}
}
