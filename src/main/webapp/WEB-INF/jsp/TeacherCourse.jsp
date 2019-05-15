<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<!-- 使用jstl -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Teacher Course</title>

<!-- 引入jQuery，使用ajax -->
<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/2.1.4/jquery.min.js"></script>

<!-- 引入bootstrap页面样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/bootstrap-3.3.7-dist/css/bootstrap.css" type="text/css">

<!-- 引入TeacherCourse页面的css样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/TeacherCourse.css" type="text/css">


<script type="text/javascript">

	//查看班级详细信息跳转
	function coursedetail(courseid,group) {
		alert("coursedetail:"+courseid+" ;group:"+group);
		//点击查看按钮，跳转到查看该班级学生和分组页面
		window.location.href="/teamwork/jump/coursedetail?courseid='"+courseid+"'&group="+group;
	}
	
	//test
	function d(group){
		alert("group:"+group);
		alert("  "+typeof(group));
	}
</script>

</head>
<body>
	
	<!-- 包含课程的容器 -->
	<div class="">
		<!-- 包含课程类表的容器 -->
		<div class="">
			<!-- 课程的table -->
			<table class="table table-striped table-bordered table-hover">
				<tbody>
					<!-- 列名行 -->
					<tr></tr>
					<!-- 单行信息 -->
					<%-- <c:forEach></c:forEach> --%>
					
				</tbody>
			</table>
		</div>
	</div>
	
	<!--  -->
	<div class="container">
		<div class="row"></div>
		<div class="row"></div>
		<!-- 表格信息 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>课程编号</th>
							<th>课程名称</th>
							<th>课程时间</th>
							<th>上课地点</th>
							<th>分组信息</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${pageInfo.list }" var="course">
							<tr>
								<td>${course.id }</td>
								<td>${course.name }</td>
								<td>${course.time }</td>
								<td>${course.addr }</td>
								<td style="color: blue;" onclick="d(${course.group})">
									<%-- ${course.group } --%>
									<c:if test="${course.group == 1 || course.group == 0}">未分组</c:if>
									<c:if test="${course.group == '2' || course.group == 2}">已分组</c:if>
									<c:if test="${course.group == '3' || course.group == 3}">分组过</c:if>
								</td>
								<td>
									<input id="${course.id }" type="button" class="btn brn-default" style="padding: 3px 12px;" value="查看" onclick="coursedetail('${course.id}',${course.group })">
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 分页 -->
		<div class="row">
			<div class="col-md-6">
				共 ${pageInfo.total } 条数据 当前是第 ${pageInfo.pageNum } / ${pageInfo.pages } 页
			</div>
			<!-- 页码显示在右部 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
					<ul class="pagination">
						<!-- 首页按钮 -->
						<li><a href="/teamwork/course/findbyteacherid?pageNum=1&username=<%=session.getAttribute("username")%>">首页</a></li>
						<!-- 有上一页显示上一页按钮 -->
						<c:if test="${pageInfo.hasPreviousPage }">
						    <li>
						      <a href="/teamwork/course/findbyteacherid?pageNum=${pageInfo.pageNum-1 }&username=<%=session.getAttribute("username")%>" aria-label="Previous">
						        <span aria-hidden="true">&laquo;</span>
						      </a>
						    </li>
						</c:if>
						<!-- 显示页面按钮 -->
					    <c:forEach items="${pageInfo.navigatepageNums }" var="pageNum">
					    	<!-- 当前页高亮 -->
					    	<c:if test="${pageNum == pageInfo.pageNum }">
					    		<li class="active"><a href="/teamwork/course/findbyteacherid?pageNum=${pageNum }&username=<%=session.getAttribute("username")%>">${pageNum }</a></li>
					    	</c:if>
					    	<!-- 非当前页默认样式 -->
					    	<c:if test="${pageNum != pageInfo.pageNum }">
					    		<li><a href="/teamwork/course/findbyteacherid?pageNum=${pageNum }&username=<%=session.getAttribute("username")%>">${pageNum }</a></li>
					    	</c:if>
					    </c:forEach>
					    <!-- 有下一页显示下一页按钮 -->
					    <c:if test="${pageInfo.hasNextPage }">
						    <li>
						      <a href="/teamwork/course/findbyteacherid?pageNum=${pageInfo.pageNum+1 }&username=<%=session.getAttribute("username")%>" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						      </a>
						    </li>
					    </c:if>
					    <!-- 末页按钮 -->
					    <li><a href="/teamwork/course/findbyteacherid?pageNum=${pageInfo.pages }&username=<%=session.getAttribute("username")%>">末页</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
	
	
</body>
</html>