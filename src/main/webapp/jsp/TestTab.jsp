<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test Tab</title>

<!-- 引入jQuery，使用ajax -->
<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/2.1.4/jquery.min.js"></script>

<!-- 引入bootstrap页面样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/bootstrap-3.3.7-dist/css/bootstrap.css" type="text/css">
<!-- 引入bootstrap的js文件 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>

<!-- 引入CourseDetail页面的css样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/CourseDetail.css" type="text/css">

<script type="text/javascript">

	//页面加载完成后，发送ajax请求，得到分页数据
	$(function() {
		//班级的id
		var courseid = "0010";//request.getAttribute("courseid")
		//班级的分组情况(1:没分组;2:分组了;3:以前分过组;)
		var group = 2;//request.getAttribute("group")
		
		//默认加载第一页
		var pagenum = 1;
		//填充班级学生的信息到学生信息面板
		ajaxstudents(courseid,pagenum);
		//填充分组信息到学生分组信息面板
		ajaxgroup(courseid,group);
		
	});
	
	
	//ajax查询学生信息
	function ajaxstudents(courseid,pagenum) {
		$.ajax({
			type:"post",
			dataType:"json",
			data:{courseid:courseid,pageNum:"1"},
			//url:"/teamwork/student/findStudentByCourseidPageHelper",
			url:"/teamwork/student/findStudentByCourseid",
			success:function(data){
				console.log("success"+data);
				//console.log(data.pageInfo.list);
				//显示学生信息(分页)
				//displaydata(data.pageInfo.list);
				//显示学生信息
				displaydata(data.students);
			},
			error:function(data){
				console.log("error"+data);
			}
		});
	}
	
	//表格展示学生信息，信息填充函数
	function displaydata(data) {
		var students = data;
		$.each(students,function(index,student){
			var studentid = $("<td></td>").append(student.id);
			var studentname = $("<td></td>").append(student.name);
			var studentsex = $("<td></td>").append(student.sex);
			var studentclassname = $("<td></td>").append(student.classname);
			var checkbtn = $("<td></td>")
				.append("<input id=\""+student.id+"\" type=\"button\" class=\"btn brn-default\" style=\"padding: 3px 12px;\" value=\"查看\" onclick=\"toCourseStudentAssignment('"+<%=request.getAttribute("courseid")%>+"','"+student.id+"')\">")
				.attr("title","学生在班级内的任务");
			$("<tr></tr>").append(studentid)
				.append(studentname)
				.append(studentsex)
				.append(studentclassname)
				.append(checkbtn)
				.appendTo("#students_table tbody");
		});
	}
	
	//填充分组信息到学生分组信息面板
	function ajaxgroup(courseid,group){
		//当班级分组
		if (group == 2) {
			//分组
			$.ajax({
				type:"post",
				dataType:"json",
				data:{courseid:courseid},
				url:"/teamwork/tts/findttsbycourseid",
				success:function(data){
					//请求接入成功
					console.log("success"+data);
					if (data.code == "200") {
						//请求接入并成功取得数据
						console.log("code:200;"+"info:"+data.info);
						//显示小组,画页面效果
						displayteam(data.tts);
					}
					if (data.code == "100") {
						//请求接入但未取得数据
						console.log("infomation:"+data.info);
					}
				},
				error:function(data){
					console.log("error:"+data);
				}
			});
		} 
		//当班级曾经分组
		else if(group == 3){
			//
		}
		//当班级未分组
		else {
			//
		}
	}
	
	//画小组信息面板
	function displayteam(data) {
		var ttss = data;
		var table = $("<table></table>").addClass("table table-hover");
		var thead = $("<thead></thead>").append(
				$("<tr></tr>").append($("<th></th>").text("组号"))
							.append($("<th></th>").text("组名"))
							.append($("<th></th>").text("学号"))
							.append($("<th></th>").text("角色"))
							.append($("<th></th>").text("操作"))
				);
		//向表中加入表头
		table.append(thead);
		//新建tbody
		var tbody = $("<tbody></tbody>");
		
		$.each(ttss,function(index,tts){
			//新建一行
			var tr = $("<tr></tr>");
			//队长的颜色不同
			if (tts.character == 1) {
				tr.addClass("GroupLeader");
			}
			//组号
			tr.append($("<td></td>").text(tts.teamid).attr({title:"点击查看小组信息",style:"color: blue;",onclick:"toCourseTeam('"+tts.teamid+"')"}));
			//组名
			tr.append($("<td></td>").text(tts.teamname));
			//学号
			tr.append($("<td></td>").text(tts.studentid));
			//角色
			if (tts.character == 1) {
				tr.append($("<td></td>").text("组长"));
			}
			else if (tts.character == 2) {
				tr.append($("<td></td>").text("组员"));
			}
			//操作
			tr.append($("<td></td>")
					.append("<input id=\""+tts.studentid+"\" type=\"button\" class=\"btn brn-default\" style=\"padding: 3px 12px;\" value=\"查看\" onclick=\"toCourseStudentAssignment('"+<%=request.getAttribute("courseid")%>+"','"+tts.studentid+"')\">")
					.attr("title","学生在班级内的任务"));
			//增添新的一行
			tbody.append(tr);
		});
		table.append(tbody);
		$("#TeamContainer").append(table);
	}
	
	//小组信息页面
	function toCourseTeam(teamid) {
		//alert(teamid+typeof(teamid));
		console.log(teamid+typeof(teamid));
		window.location.href="/teamwork/jump/courseteam?teamid='"+teamid+"'";
	}
	
	//班级学生任务
	function toCourseStudentAssignment(courseid,studentid){
		//alert("toCourseStudentAssignment"+courseid+typeof(courseid)+" "+studentid+typeof(studentid));
		console.log("toCourseStudentAssignment"+courseid+typeof(courseid)+" "+studentid+typeof(studentid));
		window.location.href="/teamwork/jump/coursestudentassignment?studentid='"+studentid+"'&courseid='"+courseid+"'";
	}
	
	
	//切换切片
	$("#myTabss").click(function(){
		console.log("myTabss"+this);
		console.log("myTabss"+e);
		e.preventDefault();
		//$(this).tab('show');
	});
	
	$('#MyTabs a').click(function (e) {
		console.log("MyTabs"+e);
		e.preventDefault();
		$(this).tab('show');
	});

	
</script>

</head>
<body>
	
	<!-- 中间体 -->
	<div style="display: flex;width: 100%;">
		
		<div style="width: 20%;"></div>
	
		<div style="width: 80%;">
			<!-- Nav tabs -->
			<ul id="myTabs" class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active"><a href="#studentstab" aria-controls="studentstab" role="tab" data-toggle="tab">students</a></li>
				<li role="presentation"><a href="#groupstab" aria-controls="groupstab" role="tab" data-toggle="tab">groups</a></li>
				<li role="presentation"><a href="#projectstab" aria-controls="projectstab" role="tab" data-toggle="tab">projects</a></li>
				<!-- <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Messages</a></li>
				<li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">Settings</a></li> -->
			</ul>
			<!-- Tab panes -->
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="studentstab">
					
					<!-- 学生展示面板外包 -->
					<div class="StudentList">
						<!-- 学生信息面板 -->
						<div class="container" style="overflow: auto;">
							<!-- 表头信息 -->
							<div class="row">
								<p>班级学生信息</p>
							</div>
							<!-- 来一条分割线怎么说 -->
							<div class="row" style="border-bottom: 1px solid #CCC;">
								<!-- <hr> -->
							</div>
							<!-- 表格信息 -->
							<div class="row">
								<div class="col-md-12">
									<table id="students_table" class="table table-hover">
										<thead>
											<tr>
												<th>学号</th>
												<th>姓名</th>
												<th>性别</th>
												<th>班级</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody class="tbodytd">
											<!-- 每一条学生的数据 -->
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					
				</div>
				<div role="tabpanel" class="tab-pane" id="groupstab">
					
					<!-- 分组展示面板外包 -->
					<div class="StudentGroup">
						<!-- 分组展示面板 -->
						<div class="container">
							<!-- 表头信息 -->
							<div class="row">
								<p>班级分组信息</p>
							</div>
							<!-- 来一条分割线怎么说 -->
							<div class="row" style="border-bottom: 1px solid #CCC;">
								<!-- <hr> -->
							</div>
							<div class="row">
								<div class="col-md-12">
									<div id="TeamContainer" class="TeamContainer">
										
										<!-- 有分组信息的情况 -->
										<!-- <table id="students_group" class="table table-hover">
											<thead>
												<tr>
													<th>组号</th>
													<th>组名</th>
													<th>学号</th>
													<th>角色</th>
													<th>操作</th>
												</tr>
											</thead>
											<tbody id="TeamDetail">
												每一组的数据
											</tbody>
										</table> -->
										
										<!-- 没有分组的情况 -->
										<%-- <c:if test="${group != 2 }">
											<div style="background-color: #CCC;height: 80%;max-height: 200px;width: 100%;">
												<p>未分组</p>
											</div>
										</c:if> --%>
										
									</div>
								</div>
							</div>
						</div>
					</div>
					
				</div>
				<div role="tabpanel" class="tab-pane" id="projectstab">.projects.</div>
				<!-- <div role="tabpanel" class="tab-pane" id="messages">.messages.</div>
				<div role="tabpanel" class="tab-pane" id="settings">.settings.</div> -->
			</div>
		</div>
		
	</div>
	
	<!-- Button trigger modal -->
	<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#AllotProjectModal">
	  AllotProjectModal
	</button>
	
	<!-- Modal -->
	<div class="modal fade" id="AllotProjectModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
	      </div>
	      <div class="modal-body">
	        ...
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">Save changes</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Button trigger modal -->
	<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#EditProjectModal">
		EditProjectModal
	</button>
	
	<!-- Modal -->
	<div class="modal fade" id="EditProjectModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
	      </div>
	      <div class="modal-body">
	        ...
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">Save changes</button>
	      </div>
	    </div>
	  </div>
	</div>

</body>
</html>