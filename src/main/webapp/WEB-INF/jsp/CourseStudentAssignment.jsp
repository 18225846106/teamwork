<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Course Student Assignment</title>

<!-- 引入jQuery，使用ajax -->
<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/2.1.4/jquery.min.js"></script>

<!-- 引入bootstrap页面样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/bootstrap-3.3.7-dist/css/bootstrap.css" type="text/css">

<!-- 引入CourseStudentAssignment页面的css样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/CourseStudentAssignment.css" type="text/css">

<!-- 引入进度球的ProgressBall的样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/ProgressBall.css" type="text/css">

<script type="text/javascript">
	$(function(){
		var studentid = <%=request.getAttribute("studentid")%>;
		var courseid = <%=request.getAttribute("courseid")%>;
		//console.log("  "+${session.getAttribute("username")});
		console.log("studentid:"+<%=request.getAttribute("studentid")%>+typeof(<%=request.getAttribute("studentid")%>));
		console.log("courseid:"+<%=request.getAttribute("courseid")%>+typeof(<%=request.getAttribute("courseid")%>));
		
		//发起请求找到该学生的信息
		$.ajax({
			type:"post",
			dataType:"json",
			data:{studentid:<%=request.getAttribute("studentid")%>},
			url:"/teamwork/student/findstudentbyid",
			success:function(data){
				//
				console.log("success:"+data);
				//失败
				if (data.code == "100") {
					//打印失败信息
					console.log("code:"+data.code+" info:"+data.info);
				} 
				//成功
				else if(data.code == "200"){
					//填充学生信息
					displaystudent(data.student);
				}
				//意外
				else{
					//
				}
			},
			error:function(data){
				console.log("error:"+data);
			}
		});
		
		//发起请求找到所有该学生在该班级的任务
		$.ajax({
			type:"post",
			dataType:"json",
			data:{courseid:<%=request.getAttribute("courseid")%>,studentid:<%=request.getAttribute("studentid")%>},
			url:"/teamwork/assignment/findassignmentbycsid",
			success:function(data){
				//
				console.log("success:"+data);
				//失败
				if (data.code == "100") {
					//打印失败信息
					console.log("code:"+data.code+" info:"+data.info);
				} 
				//成功
				else if(data.code == "200"){
					//填充任务信息
					displayassignment(data.assignments);
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
	
	//填充学生信息
	function displaystudent(data) {
		var student = data;
		//
		var studentid = $("<td></td>").append(student.id);
		var studentname = $("<td></td>").append(student.name);
		var studentsex = $("<td></td>").append(student.sex);
		var studentgrade = $("<td></td>").append(student.grade);
		var studentclassname = $("<td></td>").append(student.classname);
		$("<tr></tr>").append(studentid)
					.append(studentname)
					.append(studentsex)
					.append(studentgrade)
					.append(studentclassname)
					.appendTo("#students_table tbody");
	}
	
	//填充任务信息
	function displayassignment(data) {
		var assignments = data;
		//
		$.each(assignments,function(index,assignment){
			console.log("assignment:"+assignment);
			//新建一个表格
			var table = $("<table></table>").attr("id",assignment.id).addClass("table table-hover");
			
			//项目编号
			var trpid = $("<tr></tr>").append($("<td></td>").text("项目编号:")).append($("<td></td>").text(assignment.projectid).attr({"style":"color: blue;","onclick":"toProjectAssignment("+assignment.projectid+")"}));
			//任务编号
			var trid = $("<tr></tr>").append($("<td></td>").text("任务编号:")).append($("<td></td>").text(assignment.id).attr({"style":"color: blue;","onclick":"toAssignmentDetail("+assignment.id+")"}));
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
		//
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
			cnt.innerHTML = percent;
			water.style.transform='translate(0'+','+(100-percent)+'%)';
			if(percent > progress-1 && percent <= progress+1){
				//保留小数部分
				cnt.innerHTML = progress;
				console.log("cnt.innerHTML:"+cnt.innerHTML+"cnt.innerText:"+cnt.innerText);
				clearInterval(interval);
			 }
		},60);
	}
	
	//项目内任务页面
	function toProjectAssignment(projectid) {
		console.log("toProjectAssignment"+projectid+typeof(projectid));
		window.location.href="/teamwork/jump/projectassignment?projectid='"+projectid+"'";
	}
	
	//任务详情页面
	function toAssignmentDetail(assignmentid) {
		console.log("toAssignmentDetail"+assignmentid+typeof(assignmentid));
		window.location.href="/teamwork/jump/assignmentdetail?assignmentid='"+assignmentid+"'";
	}
	
	//从时间戳获取时间
	function getdate(data) {
		var now = new Date(data),
		y = now.getFullYear(),
		m = ("0" + (now.getMonth() + 1)).slice(-2),
		d = ("0" + now.getDate()).slice(-2);
		return y + "-" + m + "-" + d + " " + now.toTimeString().substr(0, 8);
	}
	
</script>

</head>
<body>

	<!-- 展示学生信息 -->
	<div class="Student">
		<div class="container">
			<div class="row">
				<p>学生信息</p>
			</div>
			<div class="row">
				<div class="col-md-12">
					<table id="students_table" class="table table-hover">
						<thead>
							<tr>
								<th>学号</th>
								<th>姓名</th>
								<th>性别</th>
								<th>年级</th>
								<th>班级</th>
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
	
	<!-- 展示学生在班级内的任务 -->
	<div class="StudentAssignment">
		<div class="container">
			<div class="row">
				<div id="AssignmentList" class="col-md-12">
					
				</div>
			</div>
		</div>
	</div>

</body>
</html>