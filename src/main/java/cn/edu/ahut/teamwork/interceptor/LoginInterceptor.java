package cn.edu.ahut.teamwork.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor{

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		// 执行完毕，返回前拦截
		HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		// 在处理过程中，执行拦截	
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		// 返回false则不执行拦截
		HttpSession session = request.getSession();
		//String uri = request.getRequestURI(); // 获取登录的uri，这个是不进行拦截的
		//if(session.getAttribute("LOGIN_USER")!=null || uri.indexOf("system/login")!=-1) {// 说明登录成功 或者 执行登录功能			
		
		System.out.println("尝试打印拦截获取值：   "+session.getAttribute("LOGIN"));
		
		if(session.getAttribute("LOGIN") != null) {
			
			System.out.println("尝试打印拦截获取值：   "+session.getAttribute("LOGIN"));
			
			// 登录成功不拦截
			return true;
		}else {
			// 拦截后进入登录页面
			response.sendRedirect(request.getContextPath()+"/jump/login");
			return false;
		//return HandlerInterceptor.super.preHandle(request, response, handler);
		}
	}
}
