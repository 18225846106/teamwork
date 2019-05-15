<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>StudentMain</title>

<script type="text/javascript" src="../jquery/2.1.4/jquery.min.js"></script>

<script type="text/javascript">

//$(document).ready(function(){
window.onload = function() {
	//var username = request.getAttribute("username");
	var username = <%=request.getAttribute("username")%>;
	alert(username);
	$("#test").val(username);
	var loginsession = <%=session.getAttribute("LOGIN")%>;
	alert("loginsession="+loginsession);
}
</script>
</head>
<body>
	<p>学生登录成功</p>
	<input id="test" type="text" title="test" value="aaa">
</body>
</html>