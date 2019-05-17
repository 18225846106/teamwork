<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Course Team</title>

<!-- 引入jQuery，使用ajax -->
<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/2.1.4/jquery.min.js"></script>

<!-- 引入bootstrap页面样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/bootstrap-3.3.7-dist/css/bootstrap.css" type="text/css">

<!-- 引入CourseTeam页面的css样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/CourseTeam.css" type="text/css">

<!-- 引入进度条样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/ProgressBar.css" type="text/css">

<!-- 引入util的js文件 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/util.js"></script>

<script type="text/javascript">
	$(function(){
		var teamid = <%=request.getAttribute("teamid")%>;
		
		console.log("teamid:"+<%=request.getAttribute("teamid")%>);
		
		//查询小组成员信息
		$.ajax({
			type:"post",
			dataType:"json",
			data:{teamid:<%=request.getAttribute("teamid")%>},
			url:"/teamwork/sts/findstsbyteamid",
			success:function(data){
				//
				console.log("success:"+data);
				//失败
				if (data.code == "100") {
					//
				} 
				//成功
				else if(data.code == "200"){
					//打印team
					
					//打印students
					displaystudents(data.studentteamstudents);
				}
				//
				else{
					//
				}
			},
			error:function(data){
				console.log("error:"+data);
			}
		});
		
		//查询小组内所有项目信息
		$.ajax({
			type:"post",
			dataType:"json",
			data:{teamid:<%=request.getAttribute("teamid")%>},
			url:"/teamwork/project/findprojectbyteamid",
			success:function(data){
				//
				console.log("success:"+data);
				//
				if (data.code == "100") {
					//
				} 
				//
				else if(data.code == "200"){
					//画项目信息
					displayprojects(data.projects);
				}
				//
				else{
					//
				}
			},
			error:function(data){
				console.log("error:"+data);
			}
		});
	});
	
	//小组信息
	function displayteam(data) {
		
	}
	
	//成员信息
	function displaystudents(data){
		var stss = data;
		//头
		var thead = $("<thead></thead>").append(
				$("<tr></tr>").append($("<th></th>").text("学号"))
							.append($("<th></th>").text("姓名"))
							.append($("<th></th>").text("性别"))
							.append($("<th></th>").text("年级"))
							.append($("<th></th>").text("班级"))
							.append($("<th></th>").text("角色"))
							.append($("<th></th>").text("操作"))
				);
		//向表中加入表头
		$("#students_table").append(thead);
		//新建tbody
		var tbody = $("<tbody></tbody>");
		
		$.each(stss,function(index,sts){
			//新建一行
			var tr = $("<tr></tr>");
			//队长的颜色不同
			if (sts.character == 1) {
				tr.addClass("GroupLeader");
			}
			//加入学号
			tr.append($("<td></td>").text(sts.studentid));
			//加入姓名
			tr.append($("<td></td>").text(sts.studentname));
			//加入性别
			tr.append($("<td></td>").text(sts.studentsex));
			//加入年级
			tr.append($("<td></td>").text(sts.studentgrade));
			//加入班级
			tr.append($("<td></td>").text(sts.studentclassname));
			//加入角色
			if (sts.character == 1) {
				tr.append($("<td></td>").text("组长"));
			}
			else if (sts.character == 2) {
				tr.append($("<td></td>").text("组员"));
			}
			else if (sts.character == null) {
				tr.append($("<td></td>").text("指定"));
			}
			//tr.append($("<td></td>").text(sts.character));
			//加入操作
			tr.append($("<td></td>")
					.append("<input id=\""+sts.studentid+"\" type=\"button\" class=\"btn brn-default\" style=\"padding: 3px 12px;\" value=\"查看\" onclick=\"toCourseStudentAssignment('"+sts.courseid+"','"+sts.studentid+"')\">")
					.attr("title","学生在班级内的任务"));
			//行加入表体
			tbody.append(tr);
		});
		//内容加入到表
		$("#students_table").append(tbody);
	}
	
	//画项目信息
	function displayprojects(data) {
		var projects = data;
		//循环建表,一层循环一张表
		$.each(projects,function(index,project){
			console.log("project:"+project);
			//新建一个表格
			var table = $("<table></table>").attr({"id":project.id}).addClass("table table-hover ProjectTable");
			
			//项目编号
			var trid = $("<tr></tr>").append($("<td></td>").text("项目编号:")).append($("<td></td>").text(codetoolang(""+project.id+"")).attr({"style":"color: blue;","onclick":"toProjectAssignment('"+project.id+"')","title":project.id})).attr({"title":"项目内任务详情"});
			//项目名称
			var trname = $("<tr></tr>").append($("<td></td>").text("任务名称:")).append($("<td></td>").text(project.name));
			//任务状态，状态不同，修改样式
			if (project.state == 1) {
				var trstate = $("<tr></tr>").append($("<td></td>").text("任务状态:")).append($("<td></td>").text("未开始"));
			}
			else if (project.state == 2) {
				var trstate = $("<tr></tr>").append($("<td></td>").text("任务状态:")).append($("<td></td>").text("进行中").attr("style","color: #6cc6a2;"));
			}
			else if (project.state == 3) {
				var trstate = $("<tr></tr>").append($("<td></td>").text("任务状态:")).append($("<td></td>").text("已完成").attr("style","color: #4bff37;"));
			}
			else if (project.state == 4) {
				var trstate = $("<tr></tr>").append($("<td></td>").text("任务状态:")).append($("<td></td>").text("逾期").attr("style","color: #ff1717;"));
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
			//var progress = $("<tr></tr>").append($("<td></td>").append($("<div></div>").append(drawball())));
			//one
			var tdone = $("<td></td>").append(trid).append(trname).append(trstate);
			//two
			var tdtwo = $("<td></td>").append(trstarttime).append(trsendtime).append(trsfinishime);
			//three///进度条
			//var tdthree = $("<td></td>").append($("<div></div>").addClass("ProgressDiv").append(drawball(project.id)));/////.append(progress);
			var trthree = drawprogress(project.progress);
			//all
			var onetwo = $("<tr></tr>")
			//.attr({"style":"display: flex"})
			.append(tdone)
			//.append($("<div></div>").attr({"style":"width: 30%;"}).append(tdone))
			.append(tdtwo)
			//.append($("<div></div>").attr({"style":"width: auto;"}).append(tdtwo))
			.append($("<td></td>"));
			//.append(tdthree);
			//all-to-tbody-to-table//画出表格
			$("<tbody></tbody>").append(onetwo).append(trthree).appendTo(table);
			//table-to-div//表格填充到页面
			$("#projectlists").append(table);
		});
		//
	}
	
	//班级学生任务跳转
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
		//方式二
		//var div1 = $("<div></div>").text("项目进度:").attr("style","width: 25%;");
		//var div2 = $("<div></div>").append(divout).attr("style","width: 75%;");
		//var divall = $("<div></div>").attr("style","display: flex;width: 100%;").append(div1).append(div2);
		//var tr = $("<tr></tr>").append(divall);
		return tr;
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
	
</script>

</head>
<body>

	<!-- 展示团队人员信息 -->
	<div class="Student">
		<!-- 表头team -->
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<table id="team_table" class="table table-hover">
					</table>
				</div>
			</div>
		</div>
		<!-- 表体students -->
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<table id="students_table" class="table table-hover">
					</table>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 展示团队项目信息 -->
	<div class="StudentProject">
		<div class="container">
			<div class="row">
				<!-- 右移一格 -->
				<!-- <div class="col-md-1">
				</div> -->
				<!-- 十二分格占中间十个 -->
				<div id="projectlists" class="col-md-10">
					<!-- 项目列表体 -->
					<!-- <table id="projects_table" class="table table-hover">
					</table> -->
				</div>
			</div>
		</div>
	</div>

</body>
</html>