<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jstl -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Course Detail</title>

<!-- 引入jQuery，使用ajax -->
<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/2.1.4/jquery.min.js"></script>

<!-- 引入bootstrap页面样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/bootstrap-3.3.7-dist/css/bootstrap.css" type="text/css">

<!-- 引入bootstrap的js文件 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>

<!-- 引入CourseDetail页面的css样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/CourseDetail.css" type="text/css">

<!-- 引入util的js文件 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/util.js"></script>

<script type="text/javascript">
	//全页变量courseid
	var courseid = <%=request.getAttribute("courseid")%>;
	var pid;
	//页面加载完成后，发送ajax请求，得到分页数据
	$(function(){
		//班级的id
		var courseid = <%=request.getAttribute("courseid")%>;
		//班级的分组情况(1:没分组;2:分组了;3:以前分过组;)
		var group = <%=request.getAttribute("group")%>;
		
		console.log("courseid:"+<%=request.getAttribute("courseid")%>+" "+courseid+" "+typeof(courseid));
		console.log("group:"+<%=request.getAttribute("group")%>+" "+group+" "+typeof(group));
		
		//默认加载第一页
		var pagenum = 1;
		//填充班级学生的信息到学生信息面板
		ajaxstudents(courseid,pagenum);
		//填充分组信息到学生分组信息面板
		ajaxgroup(courseid,group);
		//填充班级项目信息
		ajaxproject(courseid);
		
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
		//情况:当班级曾经分组
		else if(group == 3){
		}
		//情况:当班级未分组
		else {
			displayallotteam();
		}
	}
	
	//班级内项目信息
	function ajaxproject(courseid) {
		$.ajax({
			type:"post",
			dataType:"json",
			data:{courseid:courseid},
			url:"/teamwork/project/findprojectbycourseid",
			success:function(data){
				//请求接入成功
				console.log("success"+data);
				if (data.code == "200") {
					//请求接入并成功取得数据
					console.log("code:200;"+"info:"+data.info);
					//显示小组,画页面效果
					displayproject(data.projects);
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

	//画班级项目信息
	/* function displayproject(data) {
		var projects = data;
		console.log("projects:"+projects+typeof(projects));
	} */
	//画项目信息
	function displayproject(data) {
		var projects = data;
		//先清空标签内的内容
		$("#projectlists").empty();
		$.each(projects,function(index,project){
			console.log("project:"+project);
			//新建一个表格
			var table = $("<table></table>").attr({"id":project.id}).addClass("table table-hover ProjectTable");
			
			//项目编号
			var trid = $("<tr></tr>").append($("<td></td>").text("项目编号:")).append($("<td></td>").text(codetoolang(project.id)).attr({"style":"color: blue;","onclick":"toProjectAssignment('"+project.id+"')","title":project.id})).attr({"title":"项目内任务详情"});
			//项目名称
			var trname = $("<tr></tr>").append($("<td></td>").text("项目名称:")).append($("<td></td>").text(project.name));
			//任务状态，状态不同，修改样式
			if (project.state == 1) {
				var trstate = $("<tr></tr>").append($("<td></td>").text("项目状态:")).append($("<td></td>").text("未开始"));
			}
			else if (project.state == 2) {
				var trstate = $("<tr></tr>").append($("<td></td>").text("项目状态:")).append($("<td></td>").text("进行中").attr("style","color: #6cc6a2;"));
			}
			else if (project.state == 3) {
				var trstate = $("<tr></tr>").append($("<td></td>").text("项目状态:")).append($("<td></td>").text("已完成").attr("style","color: #4bff37;"));
			}
			else if (project.state == 4) {
				var trstate = $("<tr></tr>").append($("<td></td>").text("项目状态:")).append($("<td></td>").text("逾期").attr("style","color: #ff1717;"));
			}
			//任务开始时间
			var trstarttime = $("<tr></tr>").append($("<td></td>").text("开始时间:")).append($("<td></td>").text(getdate(project.starttime)));
			//任务截止时间
			var trsendtime = $("<tr></tr>").append($("<td></td>").text("截止时间:")).append($("<td></td>").text(getdate(project.endtime)));
			//任务结束时间
			if (project.state == 3 || project.state == 4) {
				var trsfinishime = $("<tr></tr>").append($("<td></td>").text("结束时间:")).append($("<td></td>").text(getdate(project.finishtime)));
			}
			else if (project.state == 1) {
				var trsfinishime = $("<tr></tr>").append($("<td></td>").text("结束时间:")).append($("<td></td>").text("----"));
			}
			else if (project.state == 2) {
				var trsfinishime = $("<tr></tr>").append($("<td></td>").text("结束时间:")).append($("<td></td>").text("----"));
			}
			//进度状态
			//one
			var tdone = $("<td></td>").append(trid).append(trname).append(trstate);
			//two
			var tdtwo = $("<td></td>").append(trstarttime).append(trsendtime).append(trsfinishime);
			//three///进度条//返回tr行
			var trthree = drawprogress(project.progress);
			//all
			var onetwo = $("<tr></tr>").append(tdone).append(tdtwo).append($("<td></td>"));//.append(tdthree);
			//all-to-tbody-to-table//画出表格
			var tbody = $("<tbody></tbody>")
			//.attr({"style":"display: flex"})
			.append(onetwo)
			//.append($("<div></div>").attr({"style":"width: 30%;"}).append(tdone))
			.append(trthree);
			//.append($("<div></div>").attr({"style":"width: auto;"}).append(tdtwo))
			//画按钮
			if (project.tid != null && project.tid != "") {//当项目已经被分组
				var trbut = $("<tr></tr>")
						.append($("<td></td>").text("分配到小组编号:"+codetoolang(project.tid)))
						.append($("<td></td>")
								.append($("<button></button>").attr({"type":"button","data-toggle":"modal","data-target":"#EditProjectModal","style":"padding: 2px;font-size: 1em;","onclick":"editProject('"+project.id+"');"}).addClass("btn btn-default btn-lg").text("编辑项目"))
								.append($("<button></button>").attr({"type":"button","style":"padding: 2px;font-size: 1em;","onclick":"delectProject('"+project.id+"','"+project.name+"');"}).addClass("btn btn-default").text("删除项目")))
				tbody.append(trbut);
			}else {//当项目没有分配到组//给出按钮，弹出模态框
				var trbut = $("<tr></tr>")
						.append($("<td></td>").append($("<button></button>").attr({"type":"button","data-toggle":"modal","data-target":"#AllotProjectModal","style":"padding: 2px;font-size: 1em;","onclick":"getteam('"+project.id+"');"}).addClass("btn btn-default btn-lg").text("分配项目")))
						.append($("<td></td>")
								.append($("<button></button>").attr({"type":"button","data-toggle":"modal","data-target":"#EditProjectModal","style":"padding: 2px;font-size: 1em;","onclick":"editProject('"+project.id+"');"}).addClass("btn btn-default btn-lg").text("编辑项目"))
								.append($("<button></button>").attr({"type":"button","style":"padding: 2px;font-size: 1em;","onclick":"delectProject('"+project.id+"','"+project.name+"');"}).addClass("btn btn-default").text("删除项目")))
				tbody.append(trbut);
			}
			//将tbody加入到表格
			table.append(tbody);
			//table-to-div//表格填充到页面
			$("#projectlists").append(table);
		});
		//
	}
	
	//画进度条
	function drawprogress(data) {
		//
		var progress = data;
		console.log("progress:"+progress+typeof(progress));
		progress = new String(progress);
		console.log("progress:"+progress+typeof(progress));
		//<div class="progress">
			//<div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
				//60%
			//</div>
		var divinner = $("<div></div>")
			.addClass("progress-bar")
			.attr({"role":"progressbar","aria-valuenow":"60","aria-valuemin":"0","aria-valuemax":"100","style":"width: "+progress+"%;min-width: 2em;"})
			.text(progress+"%");
		//</div>
		var divout = $("<div></div>").addClass("progress").append(divinner);
		//方式一
		var td1 = $("<td></td>").text("项目进度:").attr("style","padding-bottom: 1px;");
		var td2 = $("<td></td>").append(divout).attr("style","padding-bottom: 1px;");
		var tr = $("<tr></tr>").append(td1).append(td2).append($("<td></td>"));
		return tr;
	}
	
	//未分组时画页面
	function displayallotteam(){
		$("#newteams").append($("<button></button>").addClass("btn btn-default").attr({"type":"button","style":"padding: 1px 2px;font-size: 1em;","onclick":"newteam('"+courseid+"');"}).text("创建分组"));
		/* <button type="button" class="btn btn-default btn-lg" style="padding: 1px;font-size: 1em;" data-toggle="modal" data-target="#CreattProjectModal">
			创建分组
		</button> */
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
	
	//项目内任务页面
	function toProjectAssignment(projectid) {
		console.log("toProjectAssignment"+projectid+typeof(projectid));
		window.location.href="/teamwork/jump/projectassignment?projectid='"+projectid+"'";
	}
	
	//从时间戳获取时间
/* 	function getdate(data) {
		var now = new Date(data),
		y = now.getFullYear(),
		m = ("0" + (now.getMonth() + 1)).slice(-2),
		d = ("0" + now.getDate()).slice(-2);
		return y + "-" + m + "-" + d + " " + now.toTimeString().substr(0, 8);
	} */
	
	//解决编号过长
/* 	function codetoolang(data) {
		console.log("codetoolang");
		var code = data;
		if (code.length >= 5) {
			code = code.substr(0,5)+"...";
		}
		return code;
	} */
	
	function delectProject(projectid){
		console.log(this);
		/* $.ajax({
			type:"post",
			dataType:"json",
			data:{id:projectid},
			url:"/teamwork/project/deleteprojectbyid",
			success:function(data){
				console.log("success");
			},
			error:function(data){
				console.log("error");
			}
		}); */
	}
	
	function editProject(projectid){
		console.log(this);
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:projectid},
			url:"/teamwork/project/findprojectbyid",
			success:function(data){
				console.log("success");
				//加载数据到模态框
				$("#e_projectcode").val(data.project.code);
				$("#e_projectname").val(data.project.name);
				$("#e_starttime").val(getdate(data.project.starttime).substr(0,10));
				$("#e_endtime").val(getdate(data.project.endtime).substr(0,10));
				$("#e_description").val(data.project.description);
				$("#updateproject").attr({"onclick":"updateproject('"+data.project.id+"');"})
				//调出模态框
			},
			error:function(data){
				console.log("error");
			}
		});
	}
	
	//修改指派框内的内容
	function choseteam() {
		var chosed = $("#allotteams").find("option:selected").text();//.val();
		console.log("chosed:"+chosed);
		$("#allotteamchose").val(chosed);
	}
	
	//加载小组信息到分配模态框，填充下拉选项
	function getteam(projectid) {
		pid = projectid;//为模态框指配项目的全页变量赋值
		console.log("pid:"+pid);
		$.ajax({
			type:"post",
			dataType:"json",
			data:{courseid:courseid},
			url:"/teamwork/team/findteambycourseid",
			success:function(data){
				console.log("接入/teamwork/team/findteambycourseid");
				if (data.code == "100") {
					console.log(data.info);
				}
				if (data.code == "200") {
					console.log(data.info);
					//填充选项
					$.each(data.teams,function(index,team){
						//<option value="闲人书库">闲人书库</option>
						$("#allotteams").append($("<option></option>").attr({"value":team.id}).text(team.name));
					});
				}
			},
			error:function(data){
				console.log("error:"+data);
			}
		});
	}
	
	//模态框指配项目事件
	function allotproject(){
		//$("#allotteamremind").text("");
		var chosed = $("#allotteams").val();//被选中的，value存code或id
		if (chosed == "" || chosed == null) {//没有取得唯一标识码
			//$("#allotteamremind").text("选择有效选项!").attr({"style":"color: red; font-size: 1em;"});
			alert("选择有效选项!");
		}
		else{//取得唯一标识val
			//修改项目接口
			$.ajax({
				type:"post",
				dataType:"json",
				data:{id:pid,tid:chosed},
				url:"/teamwork/project/updateproject",
				success:function(data){
					console.log("接入/teamwork/project/updateproject");
					if (data.code == "100") {
						console.log(data.info);
					}
					if(data.code == "200"){
						console.log(data.info);
						//重新填充班级项目信息
						ajaxproject(courseid);
					}
				},
				error:function(data){
					console.log("error:"+data);
				}
			});
		}
	}
	
	//删除项目
	function delectProject(projectid,projectname){
		var del = confirm("确定删除"+projectname+"项目吗!");
		if (del) {//点击确定
			console.log("删除"+projectid+" "+projectname+" 项目!");
			$.ajax({
				type:"post",
				dataType:"json",
				data:{projectid:projectid},
				url:"/teamwork/project/deleteproject",
				success:function(data){
					console.log("接入/teamwork/project/deleteproject");
					if (data.code == "100") {
						console.log(data.info);
					}
					if (data.code == "200") {
						console.log(data.info);
						alert("删除成功!");
						//重新填充班级项目信息
						ajaxproject(courseid);
					}
				},
				error:function(data){
					console.log("error!");
				}
			});
		}
		else{
			console.log("del false");
		}
	}
	
	//创建分组，回显到页面
	function newteam(courseid){
		//
		console.log("newteam");
	}
	
	
</script>
</head>
<body>

	<!-- 页面布局的头部 -->
	<div id="head" style="height: 200px;background-image: url(/teamwork/static/img/headcartoon.gif);background-repeat: no-repeat;background-position:center;">
		<div style="display: flex;height:  2em;justify-content: flex-end;justify-items: center;width: 100%;">
			<div style="min-width: 50px;"><p>欢迎：</p></div>
			<div id="customer" style="min-width: 50px"><p>moumou</p></div>
			<div style="min-width: 50px;color: blue;font: inherit;" onclick="loginout();"><p>退出!</p></div>
		</div>
		<!-- <img alt="xiatongtoubutupian" src="/teamwork/static/img/headcartoon.gif"> -->
	</div>
	
	<!-- 中间体 -->
	<div style="display: flex;width: 100%;">
		
		<div style="width: 20%;"></div>
		<!-- 切片页面 -->
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
									<table id="students_table" class="table table-bordered table-hover">
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
				<!-- 班级小组切片 -->
				<div role="tabpanel" class="tab-pane" id="groupstab">
					
					<!-- 分组展示面板外包 -->
					<div class="StudentGroup">
						<!-- 分组展示面板 -->
						<div class="container">
							<!-- 表头信息 -->
							<div class="row">
								<div id="newteams" style="display: flex;justify-content: space-between;margin: 0px 15px;padding: 2px;">
									<p>班级分组信息</p>
									<!-- 创建项目 -->
									<!-- Button trigger modal -->
									<!-- <button type="button" class="btn btn-default btn-lg" style="padding: 1px;font-size: 1em;" data-toggle="modal" data-target="#CreattProjectModal">
										创建分组
									</button> -->
								</div>
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
				<!-- 班级项目信息切片 -->
				<div role="tabpanel" class="tab-pane" id="projectstab">
					<!-- 班级项目信息展示 -->
					<div class="ProjectList">
						<!-- 项目展示面板 -->
						<div class="container">
							<!-- 表头信息 -->
							<div class="row">
								<div style="display: flex;justify-content: space-between;margin: 0px 15px;padding: 2px;">
									<p>班级项目信息</p>
									<!-- 创建项目 -->
									<!-- Button trigger modal -->
									<button type="button" class="btn btn-default btn-lg" style="padding: 1px;font-size: 1em;" data-toggle="modal" data-target="#CreattProjectModal">
										新建项目
									</button>
								</div>
							</div>
							<!-- 来一条分割线怎么说 -->
							<div class="row" style="border-bottom: 1px solid #CCC;">
								<!-- <hr> -->
							</div>
							<!-- 表体外包 -->
							<div class="row">
								<div id="projectlists" class="col-md-12">
									
								</div>
								<!-- <div class="col-md-12">
									<div class="ProjectContainer">
										画每张表
										<table>
											<thead></thead>
											<tbody></tbody>
										</table>
									</div>
								</div> -->
							</div>
						</div>
					</div>
				</div>
				<!-- <div role="tabpanel" class="tab-pane" id="messages">.messages.</div>
				<div role="tabpanel" class="tab-pane" id="settings">.settings.</div> -->
			</div>
		</div>
		
	</div>
	<%-- 
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
	
	<!--  -->
	
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
						<c:if test="${group != 2 }">
							<div style="background-color: #CCC;height: 80%;max-height: 200px;width: 100%;">
								<p>未分组</p>
							</div>
						</c:if>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	 --%>
	
	<!-- 创建项目 -->
	<!-- Button trigger modal -->
	<!-- <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#CreattProjectModal">
		CreattProjectModal
	</button> -->
	
	<!-- Modal -->
	<div class="modal fade" id="CreattProjectModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">新建项目</h4>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="">项目编号</label>
							<input type="text" class="form-control" id="c_projectcode" name="code" placeholder="projectcode 可选">
						</div>
						<div class="form-group">
							<label for="">项目名称</label>
							<input type="" class="form-control" id="c_projectname" name="name" placeholder="projectname">
						</div>
						<div class="form-group">
							<label>开始时间</label>
							<input type="date" class="form-control" name="starttime" id="c_starttime"  >
						</div>
						<div class="form-group">
							<label>截止时间</label>
							<input type="date" class="form-control" name="endtime" id="c_endtime"  >
						</div>
						<div class="form-group">
							<label for="message-text" class="control-label">描述信息:</label>
							<textarea class="form-control" id="c_description"></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" id="creatnewproject" class="btn btn-primary" onclick="creatnewproject(<%=request.getAttribute("courseid") %>);">创建新的项目</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 分配项目 -->
	<!-- Button trigger modal -->
<!-- 	<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#AllotProjectModal">
		AllotProjectModal
	</button> -->
	
	<!-- Modal -->
	<div class="modal fade" id="AllotProjectModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">发配项目</h4>
				</div>
				<div class="modal-body">
					<!-- <div style="display: flex;width: 100%;">
						<div style="width: 6em;padding-right: 10px;"><label>指派小组:</label></div>
						<div style="">
							<input href="#opt"></input>
							<select id="allotteams">
								指派的小组放在这里
								<option id="opt" name="opt" value ="volvo">Volvo</option>
								<option id="opt" name="opt" value ="lalala">lalala</option>
								<option><input type="checkbox" /></option>
							</select>
						</div>
					</div> -->
					<div style="display: flex;width: 100%;">
						<div style="width: 6em;padding-right: 10px;"><label>指派小组:</label></div>
						<div>
							<span style="absolute;margin-top:-12px;">
							    <table cellspacing="0" cellpadding="0" width="100%" border="0">
							        <tr>
							            <td align="left">
							                <span style="position:absolute;border:1pt solid #c1c1c1;overflow:hidden;width:188px;height:19px;clip:rect(-1px 190px 190px 170px);">
							                    <select name="allotteams" id="allotteams" style="width:190px;height:20px;margin:-2px;" onchange="choseteam();">
								                    <option value="" style="color:#c2c2c2;">---请选择---</option>
								                    <!-- getteam()函数填充 -->
							                    </select>
							                </span>
							                <span style="position:absolute;border-top:1pt solid #c1c1c1;border-left:1pt solid #c1c1c1;border-bottom:1pt solid #c1c1c1;width:170px;height:19px;">
							                    <input type="text" name="allotteamchose" id="allotteamchose" placeholder="可选择也可输入的下拉框" value="" style="width:170px;height:15px;border:0pt;">
							                </span>
							            </td>
							            <td>
							            	<label id="allotteamremind"></label>
							            </td>
							        </tr>
							    </table>
							</span>	
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" id="allotproject" class="btn btn-primary" onclick="allotproject();">指配</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Button trigger modal -->
<!-- 	<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#EditProjectModal">
		EditProjectModal
	</button> -->
	
	<!-- Modal -->
	<div class="modal fade" id="EditProjectModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">编辑项目信息</h4>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="">项目编号</label>
							<input type="text" class="form-control" id="e_projectcode" name="code" placeholder="projectcode 可选">
						</div>
						<div class="form-group">
							<label for="">项目名称</label>
							<input type="" class="form-control" id="e_projectname" name="name" placeholder="projectname">
						</div>
						<div class="form-group">
							<label>开始时间</label>
							<input type="date" class="form-control" name="starttime" id="e_starttime"  >
						</div>
						<div class="form-group">
							<label>截止时间</label>
							<input type="date" class="form-control" name="endtime" id="e_endtime"  >
						</div>
						<div class="form-group">
							<label for="message-text" class="control-label">描述信息:</label>
							<textarea class="form-control" id="e_description"></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" id="updateproject" class="btn btn-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>
	 
</body>
</html>