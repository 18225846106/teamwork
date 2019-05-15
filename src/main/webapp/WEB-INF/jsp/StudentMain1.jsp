<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>studentmain1</title>

<script type="text/javascript">

//$(document).ready(function(){
window.onload = function() {
	//var username = request.getAttribute("username");
	var username = <%=request.getAttribute("username")%>;
	alert("username="+username);
	//$("#test").val(username);
	var login = <%=session.getAttribute("LOGIN")%>;
	alert("login="+login);
	<%-- //var p = <%=request.getParameter("username"); --%>
	/* //alert("p="+p); */
}
</script>
</head>
<body>
<%-- <p><%request.getAttribute("username") %></p> --%>
	<%-- <p><%=request.getAttribute("username") %></p> --%>
	<p>学生登录成功</p>
	<input id="test" type="text" title="test" value="aaa">
	<p>1</p>
	<p>${requestScope.uername }1<%=request.getAttribute("username")%></p>
	<p>2</p>
	<p>${requestScope.uername1 }2<%=request.getAttribute("username1")%></p>
	<p>3</p>
	<p>${uername }3</p>
	<p>4</p>
	<p>${uername1 }4</p>
	<% 
    String id = (String)request.getAttribute("username");
    out.write("username=" + id);
	%>
</body>
</html>