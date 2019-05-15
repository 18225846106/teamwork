<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Project Assignment</title>

<!-- 引入jQuery，使用ajax -->
<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/2.1.4/jquery.min.js"></script>

<!-- 引入bootstrap页面样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/bootstrap-3.3.7-dist/css/bootstrap.css" type="text/css">

<!-- 引入ProjectAssignment页面的css样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/ProjectAssignment.css" type="text/css">

<!-- 引入进度条样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/ProgressBar.css" type="text/css">

<!-- 引入进度球的ProgressBall的样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/ProgressBall.css" type="text/css">

<script type="text/javascript">
	$(function() {
		var projectid = <%=request.getAttribute("projectid")%>;
		console.log("projectid:"+projectid+typeof(projectid));
		
		//获取项目信息请求
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:<%=request.getAttribute("projectid")%>},
			url:"/teamwork/project/findprojectbyid",
			success:function(data){
				console.log("success:"+data);
				//失败
				if (data.code == "100") {
					//返货错误信息
				} 
				//成功
				else if(data.code == "200"){
					//打印project
					displayproject(data.project);
				}
				//未知信息
				else{
					//
				}
			},
			error:function(data){
				
			}
		});
		
		//获取项目内所有任务信息
		$.ajax({
			type:"post",
			dataType:"json",
			data:{projectid:<%=request.getAttribute("projectid")%>},
			url:"/teamwork/sa/findstudentassignmentbyprojectid",
			success:function(data){
				console.log("success:"+data);
				//失败
				if (data.code == "100") {
					//返货错误信息
				} 
				//成功
				else if(data.code == "200"){
					//打印project
					displaystudentassignments(data.studentassignments);
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
	});
	
	//打印项目信息
	function displayproject(data){
		var project = data;
		console.log("project:"+project+typeof(project));
		//新建一个表格
		var table = $("<table></table>").attr({"id":project.id}).addClass("table table-hover ProjectTable");
		
		//项目编号
		var trid = $("<tr></tr>").append($("<td></td>").text("项目编号:")).append($("<td></td>").text(codetoolang(project.id)).attr({"style":"color: blue;","onclick":"toProjectAssignment("+project.id+")","title":project.id})).attr({"title":"项目内任务详情"});
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
		//one
		var tdone = $("<td></td>").append(trid).append(trname).append(trstate);
		//two
		var tdtwo = $("<td></td>").append(trstarttime).append(trsendtime).append(trsfinishime);
		//three///进度条
		var trthree = drawprogress(project.progress);
		//all->one and two
		var onetwo = $("<tr></tr>").append(tdone).append(tdtwo).append($("<td></td>"));//.append(tdthree);
		//all-to-tbody-to-table//画出表格//两行
		table.append($("<tbody></tbody>").append(onetwo).append(trthree));
		$("#project_table").append(table);
	}
	
/* 	//打印任务信息
 	function displayassignments(data) {
		var assignments = data;
		console.log("assignments:"+assignments+typeof(assignments));
		$.each(assignments,function(index,assignment){
			console.log("assignment:"+assignment);
			//新建一个表格
			var table = $("<table></table>").attr("id",assignment.id).addClass("table table-hover");
			
			//项目编号
			var trpid = $("<tr></tr>").append($("<td></td>").text("项目编号:")).append($("<td></td>").text(assignment.projectid));
			//任务编号
			var trid = $("<tr></tr>").append($("<td></td>").text("任务编号:")).append($("<td></td>").text(assignment.id));
			//任务名称
			var trname = $("<tr></tr>").append($("<td></td>").text("任务名称:")).append($("<td></td>").text(assignment.name));
			//任务状态，状态不同，修改样式
			if (assignment.state == 1) {
				var trstate = $("<tr></tr>").append($("<td></td>").text("任务状态:")).append($("<td></td>").text("未开始"));
			}
			else if (assignment.state == 2) {
				var trstate = $("<tr></tr>").append($("<td></td>").text("任务状态:")).append($("<td></td>").text("进行中").attr("style","color: #6cc6a2;"));
			}
			else if (assignment.state == 3) {
				var trstate = $("<tr></tr>").append($("<td></td>").text("任务状态:")).append($("<td></td>").text("已完成").attr("style","color: #4bff37;"));
			}
			else if (assignment.state == 4) {
				var trstate = $("<tr></tr>").append($("<td></td>").text("任务状态:")).append($("<td></td>").text("逾期").attr("style","color: #ff1717;"));
			}
			//任务开始时间
			var trstarttime = $("<tr></tr>").append($("<td></td>").text("开始时间:")).append($("<td></td>").text(getdate(assignment.starttime)));
			//任务截止时间
			var trsendtime = $("<tr></tr>").append($("<td></td>").text("截止时间:")).append($("<td></td>").text(getdate(assignment.endtime)));
			//任务结束时间
			if (assignment.state == 3 || assignment.state == 4) {
				var trsfinishime = $("<tr></tr>").append($("<td></td>").text("结束时间:")).append($("<td></td>").text(getdate(assignment.finishtime)));
			}
			else if (assignment.state == 1) {
				var trsfinishime = $("<tr></tr>").append($("<td></td>").text("结束时间:")).append($("<td></td>").text(assignment.finishtime));
			}
			else if (assignment.state == 2) {
				var trsfinishime = $("<tr></tr>").append($("<td></td>").text("结束时间:")).append($("<td></td>").text("----"));
			}
			//进度状态
			//var progress = $("<tr></tr>").append($("<td></td>").text("在这个td里面画状态进度图"));//在这个td里面画状态进度图
			/////var progress = $("<tr></tr>").append($("<td></td>").append($("<div></div>").append(drawball())));
			//one
			var tdone = $("<td></td>").append(trpid).append(trid).append(trname).append(trstate);
			//two
			var tdtwo = $("<td></td>").append(trstarttime).append(trsendtime).append(trsfinishime);
			//three///进度球
			var tdthree = $("<td></td>").append($("<div></div>").addClass("ProgressDiv").append(drawball(assignment.id)));/////.append(progress);
			//all
			var all = $("<tr></tr>").append(tdone).append(tdtwo).append(tdthree);
			//all-to-tbody-to-table
			$("<tbody></tbody>").append(all).appendTo(table);
			//table-to-div
			$("#AssignmentList").append(table);
			//修改进度球状态
			
			pro(assignment.progress,assignment.id);
		});
	}
 */
	
	//打印任务信息
	function displaystudentassignments(data) {
		var studentassignments = data;
		console.log("studentassignments:"+studentassignments+typeof(studentassignments));
		$.each(studentassignments,function(index,studentassignment){
			console.log("studentassignment:"+studentassignment);
			//新建一个表格
			var table = $("<table></table>").attr("id",studentassignment.id).addClass("table table-hover ProjectTable");
			
			//任务编号
			var traid = $("<tr></tr>").append($("<td></td>").text("任务编号:")).append($("<td></td>").text(studentassignment.assignmentid).attr({"style":"color: blue;","onclick":"toAssignmentDetail("+studentassignment.assignmentid+")"}));
			//任务名称
			var traname = $("<tr></tr>").append($("<td></td>").text("任务名称:")).append($("<td></td>").text(studentassignment.assignmentname));
			//学生编号
			var trsid = $("<tr></tr>").append($("<td></td>").text("学生编号:")).append($("<td></td>").text(studentassignment.studentid));
			//学生姓名
			var trsname = $("<tr></tr>").append($("<td></td>").text("学生姓名:")).append($("<td></td>").text(studentassignment.studentname));
			//任务状态，状态不同，修改样式
			if (studentassignment.state == 1) {
				var trstate = $("<tr></tr>").append($("<td></td>").text("任务状态:")).append($("<td></td>").text("未开始"));
			}
			else if (studentassignment.state == 2) {
				var trstate = $("<tr></tr>").append($("<td></td>").text("任务状态:")).append($("<td></td>").text("进行中").attr("style","color: #6cc6a2;"));
			}
			else if (studentassignment.state == 3) {
				var trstate = $("<tr></tr>").append($("<td></td>").text("任务状态:")).append($("<td></td>").text("已完成").attr("style","color: #4bff37;"));
			}
			else if (studentassignment.state == 4) {
				var trstate = $("<tr></tr>").append($("<td></td>").text("任务状态:")).append($("<td></td>").text("逾期").attr("style","color: #ff1717;"));
			}
			//任务开始时间
			var trstarttime = $("<tr></tr>").append($("<td></td>").text("开始时间:")).append($("<td></td>").text(getdate(studentassignment.starttime)));
			//任务截止时间
			var trsendtime = $("<tr></tr>").append($("<td></td>").text("截止时间:")).append($("<td></td>").text(getdate(studentassignment.endtime)));
			//任务结束时间
			if (studentassignment.state == 3) {
				var trsfinishime = $("<tr></tr>").append($("<td></td>").text("结束时间:")).append($("<td></td>").text(getdate(studentassignment.finishtime)));
			}
			else if (studentassignment.state == 1) {
				var trsfinishime = $("<tr></tr>").append($("<td></td>").text("结束时间:")).append($("<td></td>").text("----"));
			}
			else if (studentassignment.state == 2) {
				var trsfinishime = $("<tr></tr>").append($("<td></td>").text("结束时间:")).append($("<td></td>").text("----"));
			}
			else if (studentassignment.state == 4) {
				var trsfinishime = $("<tr></tr>").append($("<td></td>").text("结束时间:")).append($("<td></td>").text(getdate(studentassignment.endtime)));
			}
			//one第一部分四项信息
			var tdone = $("<td></td>").append(traid).append(traname).append(trsid).append(trsname);
			//two第二部分四项信息
			var tdtwo = $("<td></td>").append(trstarttime).append(trsendtime).append(trstate).append(trsfinishime);
			//three//第三部分进度球
			var tdthree = $("<td></td>").append($("<div></div>").addClass("ProgressDiv").append(drawball(studentassignment.assignmentid)));/////.append(progress);
			//all//三列合并到同一行
			var all = $("<tr></tr>").append(tdone).append(tdtwo).append(tdthree);
			//all-to-tbody-to-table//行加入到tbody//tbody加入到table
			$("<tbody></tbody>").append(all).appendTo(table);
			//table-to-div//table打印到页面
			$("#AssignmentList").append(table);
			//修改进度球状态//每一个table
			pro(studentassignment.progress,studentassignment.assignmentid);
		});
	}
	
	//画进度条
	function drawprogress(data) {
		var progress = data;
		//console.log("progress:"+progress+typeof(progress));
		progress = new String(progress);
		//console.log("progress:"+progress+typeof(progress));
		var divinner = $("<div></div>")
			.addClass("progress-bar")
			.attr({"role":"progressbar","aria-valuenow":"60","aria-valuemin":"0","aria-valuemax":"100","style":"width: "+progress+"%;min-width: 2em;"})
			.text(progress+"%");
		var divout = $("<div></div>").addClass("progress").append(divinner);
		var td1 = $("<td></td>").text("项目进度:").attr("style","padding-bottom: 1px;");
		var td2 = $("<td></td>").append(divout).attr("style","padding-bottom: 1px;");
		var tr = $("<tr></tr>").append(td1).append(td2).append($("<td></td>"));
		return tr;
	}
	
	//画进度球
	function drawball(aid){
		var svg = $("<svg></svg>").attr({"version":"1.1","xmlns":"http://www.w3.org/2000/svg","xmlns:xlink":"http://www.w3.org/1999/xlink","x":"0px","y":"0px","style":"display: none;"})
		var symbol = $("<symbol></symbol>").attr("id","wave");
		var path1 = $("<path></path>").attr("d","M420,20c21.5-0.4,38.8-2.5,51.1-4.5c13.4-2.2,26.5-5.2,27.3-5.4C514,6.5,518,4.7,528.5,2.7c7.1-1.3,17.9-2.8,31.5-2.7c0,0,0,0,0,0v20H420z");
		var path2 = $("<path></path>").attr("d","M420,20c-21.5-0.4-38.8-2.5-51.1-4.5c-13.4-2.2-26.5-5.2-27.3-5.4C326,6.5,322,4.7,311.5,2.7C304.3,1.4,293.6-0.1,280,0c0,0,0,0,0,0v20H420z");
		var path3 = $("<path></path>").attr("d","M140,20c21.5-0.4,38.8-2.5,51.1-4.5c13.4-2.2,26.5-5.2,27.3-5.4C234,6.5,238,4.7,248.5,2.7c7.1-1.3,17.9-2.8,31.5-2.7c0,0,0,0,0,0v20H140z");
		var path4 = $("<path></path>").attr("d","M140,20c-21.5-0.4-38.8-2.5-51.1-4.5c-13.4-2.2-26.5-5.2-27.3-5.4C46,6.5,42,4.7,31.5,2.7C24.3,1.4,13.6-0.1,0,0c0,0,0,0,0,0l0,20H140z");
		symbol.append(path1).append(path2).append(path3).append(path4);
		svg.append(symbol);
		
		//<div class="box">
		  //<div class="percent">
		    //<div class="percentNum" id="count">0</div>
		var percentNum = $("<div></div>").addClass("percentNum").attr("id",aid+"count").text(0);
		    //<div class="percentB">%</div>
		var percentB = $("<div></div>").addClass("percentB").text("%");
		  //</div>
		var percent = $("<div></div>").addClass("percent");
		percent.append(percentNum).append(percentB);
		  //<div id="water" class="water">
		    //<svg viewBox="0 0 560 20" class="water_wave water_wave_back">
		      //<use xlink:href="#wave"></use>
		var use1 = $("<use></use>").attr("xlink:href","#wave");
		    //</svg>
		var water_wave_water_wave_back =  $("<svg></svg>").addClass("water_wave water_wave_back").attr("viewBox","0 0 560 20");
		water_wave_water_wave_back.append(use1);
		    //<svg viewBox="0 0 560 20" class="water_wave water_wave_front">
		      //<use xlink:href="#wave"></use>
		var use2 = $("<use></use>").attr("xlink:href","#wave");
		    //</svg>
		var water_wave_water_wave_front =  $("<svg></svg>").addClass("water_wave water_wave_front").attr("viewBox","0 0 560 20");
		water_wave_water_wave_front.append(use2);
		  //</div>
		var water = $("<div></div>").addClass("water").attr("id",aid+"water");
		//</div>
		var box = $("<div></div>").addClass("box");
		box.append(svg).append(percent).append(water);
		//box.append(percent).append(water);
		return box;
	}
	
	//修改进程球信息
	function pro(progress,aid) {
		console.log(progress+typeof(progress));
		var cnt=document.getElementById(aid+"count"); 
		var water=document.getElementById(aid+"water");
		var percent=parseInt(cnt.innerText);
		console.log(cnt.innerText+typeof(cnt.innerText)+percent+typeof(percent)+parseInt(percent)+typeof(parseInt(percent)));
		var interval;
		interval=setInterval(function(){ 
		  percent++;
		  //console.log("cnt.innerHTML:"+cnt.innerHTML+"cnt.innerText:"+cnt.innerText);
		  cnt.innerHTML = percent;
		 // cnt.innerText = percent;
		 // $("#"+aid+"count").text(percent);
		  water.style.transform='translate(0'+','+(100-percent)+'%)';
		  if(percent > progress-1 && percent <= progress+1){
			  //保留小数部分
			  cnt.innerHTML = progress;
		    clearInterval(interval);
		  }
		},70);
	}
	
	//从时间戳获取时间
	function getdate(data) {
		var now = new Date(data),
		y = now.getFullYear(),
		m = ("0" + (now.getMonth() + 1)).slice(-2),
		d = ("0" + now.getDate()).slice(-2);
		return y + "-" + m + "-" + d + " " + now.toTimeString().substr(0, 8);
	}
	
	//任务详情页面
	function toAssignmentDetail(assignmentid) {
		console.log("toAssignmentDetail"+assignmentid+typeof(assignmentid));
		window.location.href="/teamwork/jump/assignmentdetail?assignmentid='"+assignmentid+"'";
	}
	//任务详情页面
	function toAssignmentDetailt(assignmentid,projectid) {
		console.log("toAssignmentDetailt"+assignmentid+typeof(assignmentid)+projectid+typeof(projectid));
		window.location.href="/teamwork/jump/assignmentdetailt?assignmentid='"+assignmentid+"'&projectid='"+projectid+"'";
	}
	
	//解决编号过长
	function codetoolang(data) {
		console.log("codetoolang");
		var code = data;
		if (code.length >= 5) {
			code = code.substr(0,5)+"...";
		}
		return code;
	}
	
/* 	//项目内任务页面
	function toProjectAssignment(projectid) {
		console.log("toProjectAssignment"+projectid+typeof(projectid));
		window.location.href="/teamwork/jump/projectassignment?projectid='"+projectid+"'";
	}
 */
	
</script>

</head>
<body>
	<!-- 项目基本信息 -->
	<div class="Project">
		<!-- 表头project -->
		<div class="container">
			<div class="row">
				<div id="project_table" class="col-md-12">
					<!-- <table id="project_table" class="table table-hover">
					</table> -->
				</div>
			</div>
		</div>
		<!-- 表体projects -->
		<!-- <div class="container">
			<div class="row">
				<div class="col-md-12">
					<table id="students_table" class="table table-hover">
					</table>
				</div>
			</div>
		</div> -->
	</div>
	
	<!-- 任务列表 -->
	<!-- 展示团队项目信息 -->
<!-- 	<div class="ProjectAssignment">
		<div class="container">
			<div class="row">
				右移一格
				<div class="col-md-1">
				</div>
				十二分格占中间十个
				<div id="Assignmentlists" class="col-md-10">
					项目列表体
					<table id="projects_table" class="table table-hover">
					</table>
				</div>
			</div>
		</div>
	</div> -->
	
	<!-- 展示学生在班级内的任务 -->
	<div class="ProjectAssignment">
		<div class="container">
			<div class="row">
				<div id="AssignmentList" class="col-md-12">
					<!-- 打印每一条任务信息 -->
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>