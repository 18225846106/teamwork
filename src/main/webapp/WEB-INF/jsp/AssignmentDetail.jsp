<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Assignment Detail</title>

<!-- 引入jQuery，使用ajax -->
<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/2.1.4/jquery.min.js"></script>

<!-- 引入bootstrap页面样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/bootstrap-3.3.7-dist/css/bootstrap.css" type="text/css">

<!-- 引入AssignmentDetail页面的css样式 -->
<!-- <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/AssignmentDetail.css" type="text/css"> -->

<!-- 引入进度条样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/ProgressBar.css" type="text/css">

<!-- 引入进度球的ProgressBall的样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/ProgressBall.css" type="text/css">

<script type="text/javascript">
	
	$(function() {
		var assignmentid = <%=request.getAttribute("assignmentid")%>;
		console.log("assignmentid:"+assignmentid+typeof(assignmentid));
		var projectid = <%=request.getAttribute("projectid")%>;
		console.log("projectid:"+projectid+typeof(projectid));
		
		if (assignmentid != null || assignmentid != "") {
			findassignmentdetail(assignmentid);
		}
		
	});
	
	//获取项目信息
	function findprojectdetail(projectid) {
		if (projectid != null || projectid != "") {
			//获取项目信息
			$.ajax({
				type:"post",
				dataType:"json",
				data:{id:projectid},
				url:"/teamwork/project/findprojectbyid",
				success:function(data){
					console.log("success:"+data);
					//失败
					if (data.code == "100") {
						//返回错误信息
						console.log(data.info);
					} 
					//成功
					else if(data.code == "200"){
						//打印project
						//displayproject(data.project);
					}
					//未知信息
					else{
						//
					}
				},
				error:function(data){
					console.log("error:"+data);
				}
			});
		}
	}
	
	//获取任务信息
	function findassignmentdetail(assignmentid) {
		if (assignmentid != null || assignmentid != "") {
			//获取项目信息
			$.ajax({
				type:"post",
				dataType:"json",
				data:{assignmentid:<%=request.getAttribute("assignmentid")%>},
				url:"/teamwork/assignment/findassignmentbyid",
				success:function(data){
					console.log("success:"+data);
					//失败
					if (data.code == "100") {
						//返回错误信息
						console.log(data.info);
					} 
					//成功
					else if(data.code == "200"){
						//project
						findprojectdetail(data.assignment.projectid);
						//displayassignment(data.assignment);
					}
					//未知信息
					else{
						//
					}
				},
				error:function(data){
					console.log("error:"+data);
				}
			});
		}
	}
	
	//打印项目信息
	function dispalyproject(data) {
		var project = data;
		console.log("project:"+project+typeof(project));
	}
	
	//打印任务信息
	function displayassignment(data) {
		var assignment = data;
		console.log("assignment:"+assignment+typeof(assignment));
	}
	
</script>

</head>
<body>

</body>
</html>