<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Index jsp page</title>
</head>
<body>
<a href="${pageContext.request.contextPath}/testcontroller/test1">go to TestSpringMvc jsp page</a>
<br>
<a href="${pageContext.request.contextPath}/testcontroller/test2">return a map</a>
<br>
<a href="${pageContext.request.contextPath}/jump/studentmain">jump studentmain</a>
<br>
<a href="${pageContext.request.contextPath}/jump/login">jump login</a>
<br>
<a href="${pageContext.request.contextPath}/jsp/TestTab.jsp">TestTab.jsp</a>
<br>
<%-- <a href='<jsp:forward page="/jsp/jquery.jsp"></jsp:forward>' >jquery</a> --%>
<br>
<%-- <a href='<jsp:forward page="/WEB-INF/jsp/Login.jsp"></jsp:forward>' >jquery</a> --%>
<%-- <a href='<jsp:forward page="/jsp/login.html"></jsp:forward>' >jquery</a> --%>
<%-- <a href='<jsp:forward page="/WEB-INF/jsp/StudentMain.jsp"></jsp:forward>' >jquery</a> --%>
</body>
</html>