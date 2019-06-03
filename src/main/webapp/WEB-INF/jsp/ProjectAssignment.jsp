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

<!-- 引入bootstrap的js文件 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>

<!-- 引入ProjectAssignment页面的css样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/ProjectAssignment.css" type="text/css">

<!-- 引入进度条样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/ProgressBar.css" type="text/css">

<!-- 引入进度球的ProgressBall的样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/ProgressBall.css" type="text/css">

<!-- 引入util的js文件 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/util.js"></script>

<script type="text/javascript">
	
	var projectid = <%=request.getAttribute("projectid")%>;
	var project;
	var pid;
	var aid;
	var starttime;
	var endtime;

	$(function() {
		var projectid = <%=request.getAttribute("projectid")%>;
		console.log("projectid:"+projectid+typeof(projectid));
		pid = projectid;
		
		//第一步：获取项目信息请求
		ajaxgetproject(projectid);
		
		//第二步：获取项目内所有任务信息
		ajaxgetassignment(projectid);
		
		//这个时候打印可能不行
		console.log("project project project "+project);
		
	});
	
	//第一步：获取项目信息请求
	function ajaxgetproject(projectid){
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:projectid},
			url:"/teamwork/project/findprojectbyid",
			success:function(data){
				console.log("success:"+data);
				//失败
				if (data.code == "100") {
					//返货错误信息
				} 
				//成功
				else if(data.code == "200"){
					window.project = data.project;
					//将部分信息存入全局变量
					//pid = data.project.id;
					starttime = data.project.starttime;
					endtime = data.project.endtime;
					//打印project
					displayproject(data.project);
					//将项目分数写在输入框
					if (data.project.score != null && data.project.score != "") {
						$("#projectscore").val(data.project.score);
					}
				}
				//未知信息
				else{
					//
				}
			},
			error:function(data){
				
			}
		});
	}
	
	//第二步：获取项目内所有任务信息
	function ajaxgetassignment(projectid){
		$.ajax({
			type:"post",
			dataType:"json",
			data:{projectid:projectid},
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
	}
	
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
		var trstate = $("<tr></tr>").append($("<td></td>").text("项目状态:")).append($("<td></td>").append(getstate(project.endtime,project.finishtime,project.progress)));
		/* if (project.state == 1) {
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
		} */
		//任务开始时间
		var trstarttime = $("<tr></tr>").append($("<td></td>").text("开始时间:")).append($("<td></td>").text(getdate(project.starttime)));
		//任务截止时间
		var trsendtime = $("<tr></tr>").append($("<td></td>").text("截止时间:")).append($("<td></td>").text(getdate(project.endtime)));
		//任务结束时间
		if (project.finishtime == null || project.finishtime == "") {
			var trsfinishime = $("<tr></tr>").append($("<td></td>").text("结束时间:")).append($("<td></td>").text("----"));
		} else {
			var trsfinishime = $("<tr></tr>").append($("<td></td>").text("结束时间:")).append($("<td></td>").text(getdate(project.finishtime)));
		}
		/* if (project.state == 3 || project.state == 4) {
			var trsfinishime = $("<tr></tr>").append($("<td></td>").text("结束时间:")).append($("<td></td>").text(getdate(project.finishtime)));
		}
		else if (project.state == 1) {
			var trsfinishime = $("<tr></tr>").append($("<td></td>").text("结束时间:")).append($("<td></td>").text("----"));
		}
		else if (project.state == 2) {
			var trsfinishime = $("<tr></tr>").append($("<td></td>").text("结束时间:")).append($("<td></td>").text("----"));
		} */
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
		//项目描述信息
		var description = $("<div></div>").attr({"style":"overflow: auto;width: 100%;min-height: 5em;max-height: 8em;border: 1px solid #dfdfdf;"}).text(project.description);
		$("#project_table").append(description);
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
		//回显时清空
		$("#AssignmentList").empty();
		
		var studentassignments = data;
		console.log("studentassignments:"+studentassignments+typeof(studentassignments));
		$.each(studentassignments,function(index,studentassignment){
			console.log("studentassignment:"+studentassignment);
			//新建一个表格
			var table = $("<table></table>").attr("id",studentassignment.id).addClass("table table-hover ProjectTable");
			
			//任务编号
			var traid = $("<tr></tr>").append($("<td></td>").text("任务编号:")).append($("<td></td>").text(codetoolang(studentassignment.assignmentid)).attr({"style":"color: blue;","onclick":"toAssignmentDetail('"+studentassignment.assignmentid+"')"}));
			//任务名称
			var traname = $("<tr></tr>").append($("<td></td>").text("任务名称:")).append($("<td></td>").text(studentassignment.assignmentname));
			//学生编号
			var trsid = $("<tr></tr>").append($("<td></td>").text("学生编号:")).append($("<td></td>").text(studentassignment.studentid));
			//学生姓名
			var trsname = $("<tr></tr>").append($("<td></td>").text("学生姓名:")).append($("<td></td>").text(studentassignment.studentname));
			//任务状态，状态不同，修改样式
			var trstate = $("<tr></tr>").append($("<td></td>").text("任务状态:")).append($("<td></td>").append(getstate(studentassignment.endtime,studentassignment.finishtime,studentassignment.progress)));
			/* if (studentassignment.state == 1) {
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
			} */
			//任务开始时间
			var trstarttime = $("<tr></tr>").append($("<td></td>").text("开始时间:")).append($("<td></td>").text(getdate(studentassignment.starttime)));
			//任务截止时间
			var trsendtime = $("<tr></tr>").append($("<td></td>").text("截止时间:")).append($("<td></td>").text(getdate(studentassignment.endtime)));
			//任务结束时间
			if (studentassignment.finishtime == null || studentassignment.finishtime == "") {
				var trsfinishime = $("<tr></tr>").append($("<td></td>").text("结束时间:")).append($("<td></td>").text("----"));
			}else{
				var trsfinishime = $("<tr></tr>").append($("<td></td>").text("结束时间:")).append($("<td></td>").text(getdate(studentassignment.finishtime)));
			}
			/* if (studentassignment.state == 3) {
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
			} */
			//one第一部分四项信息
			var tdone = $("<td></td>").append(traid).append(traname).append(trsid).append(trsname);
			//two第二部分四项信息
			var tdtwo = $("<td></td>").append(trstarttime).append(trsendtime).append(trstate).append(trsfinishime);
			//three//第三部分进度球
			var tdthree = $("<td></td>").append($("<div></div>").addClass("ProgressDiv").append(drawball(studentassignment.assignmentid)));/////.append(progress);
			//all//三列合并到同一行
			var all = $("<tr></tr>").append(tdone).append(tdtwo).append(tdthree);
			//
			
			//画按钮
			if (studentassignment.studentid != null && studentassignment.studentid != "") {//当项目已经被分组
				var trbut = $("<tr></tr>")
						.append($("<td></td>").text("分配到学生编号:"+codetoolang(studentassignment.studentid)).attr({"title":studentassignment.studentid}))
				if (studentassignment.state == 1) {
					trbut.append($("<td></td>")
						.append($("<button></button>").attr({"type":"button","data-toggle":"modal","data-target":"#AllotAssignmentModal","style":"padding: 2px;font-size: 1em;","title":"任务未开始可重新指配","onclick":"getstudent('"+studentassignment.projectid+"','"+studentassignment.assignmentid+"');"}).addClass("btn btn-default btn-lg").text("重新指派"))
						.append($("<button></button>").attr({"type":"button","data-toggle":"modal","data-target":"#EditAssignmentModal","style":"padding: 2px;font-size: 1em;","onclick":"editAssignment('"+studentassignment.assignmentid+"');"}).addClass("btn btn-default btn-lg").text("编辑任务"))
						.append($("<button></button>").attr({"type":"button","style":"padding: 2px;font-size: 1em;","onclick":"deleteAssignment('"+studentassignment.assignmentid+"','"+studentassignment.assignmentname+"');"}).addClass("btn btn-default").text("删除任务")))
					//.append($("<td></td>").text("分数:"+studentassignment.scor))
					if (studentassignment.score != null && studentassignment.score != "") {
						trbut.append($("<td></td>").text("分数:"+studentassignment.score))
					}else {
						trbut.append($("<td></td>").text("分数:----"))
					}
				}
				else{
					trbut.append($("<td></td>")
					.append($("<button></button>").attr({"type":"button","data-toggle":"modal","data-target":"#EditAssignmentModal","style":"padding: 2px;font-size: 1em;","onclick":"editAssignment('"+studentassignment.assignmentid+"');"}).addClass("btn btn-default btn-lg").text("编辑任务"))
					.append($("<button></button>").attr({"type":"button","style":"padding: 2px;font-size: 1em;","onclick":"deleteAssignment('"+studentassignment.assignmentid+"','"+studentassignment.assignmentname+"');"}).addClass("btn btn-default").text("删除任务")))
					//.append($("<td></td>").text("分数:"+studentassignment.scor))
					if (studentassignment.score != null && studentassignment.score != "") {
						trbut.append($("<td></td>").text("分数:"+studentassignment.score))
					}else {
						trbut.append($("<td></td>").text("分数:----"))
					}
				}
						//.append($("<td></td>")
						//		.append($("<button></button>").attr({"type":"button","data-toggle":"modal","data-target":"#EditAssignmentModal","style":"padding: 2px;font-size: 1em;","onclick":"editAssignment('"+studentassignment.assignmentid+"');"}).addClass("btn btn-default btn-lg").text("编辑任务"))
						//		.append($("<button></button>").attr({"type":"button","style":"padding: 2px;font-size: 1em;","onclick":"deleteAssignment('"+studentassignment.assignmentid+"','"+studentassignment.assignmentname+"');"}).addClass("btn btn-default").text("删除任务")))
						//.append($("<td></td>"))
				//tbody.append(trbut);
			}else {//当项目没有分配到组//给出按钮，弹出模态框
				var trbut = $("<tr></tr>")
						.append($("<td></td>").append($("<button></button>").attr({"type":"button","data-toggle":"modal","data-target":"#AllotAssignmentModal","style":"padding: 2px;font-size: 1em;","onclick":"getstudent('"+studentassignment.projectid+"','"+studentassignment.assignmentid+"');"}).addClass("btn btn-default btn-lg").text("分配任务")))
						.append($("<td></td>")
								.append($("<button></button>").attr({"type":"button","data-toggle":"modal","data-target":"#EditAssignmentModal","style":"padding: 2px;font-size: 1em;","onclick":"editAssignment('"+studentassignment.assignmentid+"');"}).addClass("btn btn-default btn-lg").text("编辑任务"))
								.append($("<button></button>").attr({"type":"button","style":"padding: 2px;font-size: 1em;","onclick":"deleteAssignment('"+studentassignment.assignmentid+"','"+studentassignment.assignmentname+"');"}).addClass("btn btn-default").text("删除任务")))
				if (studentassignment.score != null && studentassignment.score != "") {
					trbut.append($("<td></td>").text("分数:"+studentassignment.score))
				}else {
					trbut.append($("<td></td>").text("分数:----"))
				}
				//tbody.append(trbut);
			}
			
			//all-to-tbody-to-table//行加入到tbody//tbody加入到table
			$("<tbody></tbody>").append(all).append(trbut).appendTo(table);
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
	
	//限制开始截止时间
	function timelimit(){
		$("#c_starttime").attr({"min":getdateymd(starttime)});
		$("#c_endtime").attr({"max":getdateymd(endtime)});
	}
	
	//创建新任务
	function createnewassignment(projectid){
		//1获取模态框参数
		var assignmentcode = $("#c_assignmentcode").val();
		var assignmentname = $("#c_assignmentname").val();
		var assignmentstarttime = $("#c_starttime").val();
		var cast = Number(new Date(assignmentstarttime));//转时间戳
		var assignmentendtime = $("#c_endtime").val();
		var caet = Number(new Date(assignmentendtime));//转时间戳
		var assignmentdescription = $("#c_description").val();
		console.log(starttime+" "+endtime);
		//url:"/teamwork/assignment/insertassignment"
		$.ajax({
			type:"post",
			dataType:"json",
			data:{projectid:projectid,code:assignmentcode,name:assignmentname,starttime:cast,endtime:caet,description:assignmentdescription},
			url:"/teamwork/assignment/insertassignment",
			success:function(data){
				if (data.code == "200") {
					console.log(data.info);
					//隐藏新建模态框
					$("#CreatAssignmentModal").modal("hide");
					alert("创建成功");
					//成功创建，回显任务信息
					ajaxgetassignment(projectid);
				}
				else if(data.code == "100"){
					console.log(data.info);
				}
			},
			error:function(data){
				console.log(data);
			}
		});
	}
	
	//分配任务前要获取学生的信息，填充到选项中
	function getstudent(projectid,assignmentid){
		//随点击指配事件,即将全局任务id修改
		aid = assignmentid;
		$.ajax({
			type:"post",
			dataType:"json",
			data:{projectid:projectid},
			url:"/teamwork/teamstudent/findteamstudentbyprojectid",
			success:function(data){
				if (data.code == "100") {
					console.log(data.info);
				}
				if (data.code == "200") {
					console.log(data.info);
					//填充选项
					$("#allotstudents").empty();//填充前先清空
					$("#allotstudentchose").val("");
					$("#allotstudents").append($("<option></option>").attr({"value":"","style":"color:#c2c2c2;"}).text("---请选择---"));
					$.each(data.teamstudents,function(index,teamstudent){
						//<option value="teamstudent.studentid">teamstudent.studentid</option>
						$("#allotstudents").append($("<option></option>").attr({"value":teamstudent.studentid}).text(teamstudent.studentid));
					});
				}
			},
			error:function(data){
				console.log(data);
			}
		});
	}
	
	//分配任务
	function allotassignment(){
		console.log("allotassignment: "+aid);
		var chosed = $("#allotstudents").val();//被选中的，value存code或id
		if (chosed == "" || chosed == null) {//没有取得唯一标识码
			//$("#allotteamremind").text("选择有效选项!").attr({"style":"color: red; font-size: 1em;"});
			alert("选择有效选项!");
		}
		else{//取得唯一标识val
			//修改项目接口
			$.ajax({
				type:"post",
				dataType:"json",
				data:{id:aid,studentid:chosed},
				url:"/teamwork/assignment/updateassignment",
				success:function(data){
					console.log("接入/teamwork/assignment/updateassignment");
					if (data.code == "100") {
						console.log(data.info);
					}
					if(data.code == "200"){
						console.log(data.info);
						alert("指配成功!");
						//指配成功隐藏模态框
						$("#AllotAssignmentModal").modal("hide");
						//重新填充班级任务信息
						ajaxgetassignment(pid);
					}
				},
				error:function(data){
					console.log("error:"+data);
				}
			});
		}
	}
	
	//修改指派模态框内输入框和下拉选项选择的内容一致
	function chosestudent() {
		var chosed = $("#allotstudents").find("option:selected").text();//.val();
		console.log("chosed:"+chosed);
		$("#allotstudentchose").val(chosed);
	}
	
	//编辑任务
	function editAssignment(assignmentid){
		console.log(this);
		$.ajax({
			type:"post",
			dataType:"json",
			data:{assignmentid:assignmentid},
			url:"/teamwork/assignment/findassignmentbyid",
			success:function(data){
				console.log("success");
				//加载数据到模态框
				$("#e_assignmentcode").val(data.assignment.code);
				$("#e_assignmentname").val(data.assignment.name);
				$("#e_starttime").val(getdate(data.assignment.starttime).substr(0,10));
				$("#e_endtime").val(getdate(data.assignment.endtime).substr(0,10));
				$("#e_description").val(data.assignment.description);
				$("#updateassignment").attr({"onclick":"updateassignment('"+data.assignment.id+"');"})
				//调出模态框
				//限制时间
				$("#e_starttime").attr({"min":getdateymd(starttime)});
				$("#e_endtime").attr({"max":getdateymd(endtime)});
			},
			error:function(data){
				console.log("error");
			}
		});
	}
	
/* 	//从时间戳获取时间
	function getdate(data) {
		var now = new Date(data),
		y = now.getFullYear(),
		m = ("0" + (now.getMonth() + 1)).slice(-2),
		d = ("0" + now.getDate()).slice(-2);
		return y + "-" + m + "-" + d + " " + now.toTimeString().substr(0, 8);
	} */
	
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
/* 	function codetoolang(data) {
		console.log("codetoolang");
		var code = data;
		if (code.length >= 5) {
			code = code.substr(0,5)+"...";
		}
		return code;
	} */
	
/* 	//项目内任务页面
	function toProjectAssignment(projectid) {
		console.log("toProjectAssignment"+projectid+typeof(projectid));
		window.location.href="/teamwork/jump/projectassignment?projectid='"+projectid+"'";
	}
 */
	
</script>

</head>
<body>

	<!-- 页面布局的头部 -->
	<div id="head" style="padding: 1px;">
		<!-- 两端排列 -->
		<div style="display: flex;justify-content: space-between;">
			<div style="display: flex;justify-content: flex-start;justify-items: center;width: 50%;">
				<!-- 标题图片 -->
				<img alt="" src="/teamwork/static/img/headcharacter.png">
			</div>
			<div style="display: flex;height:  2em;justify-content: flex-end;justify-items: center;width: 50%;">
				<div style="min-width: 3em;"><p>欢迎:</p></div>
				<div id="customer" style="min-width: 50px"><p><%=session.getAttribute("loginname") %> !</p></div>
				<div style="min-width: 50px;color: blue;font: inherit;" onclick="loginout();"><p>退出!</p></div>
			</div>
		</div>
	</div>
	
	<!-- 中间体 -->
	<div style="display: flex;width: 100%;">
		
		<div style="width: 20%;border: 1px solid #e4e2e2;"></div>
		<!-- 切片页面 -->
		<div style="width: 80%;border-top: 1px solid #e4e2e2;">

			<!-- 项目基本信息 -->
			<div class="Project">
				<!-- 表头project -->
				<div class="container" style="width: 100%;">
					<!-- 表头 -->
					<div class="row">
						<p>项目基本信息</p>
					</div>
					<!-- 来一条分割线怎么说 -->
					<div class="row" style="border-bottom: 1px solid #CCC;">
						<!-- <hr> -->
					</div>
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
				<div class="container" style="width: 100%;">
					<!-- 表头 -->
					<div class="row">
						<div style="display: flex;justify-content: space-between;margin: 0px 15px;padding: 2px;">
							<p>项目任务信息</p>
							<!-- 创建项目 -->
							<!-- Button trigger modal -->
							<button type="button" class="btn btn-default btn-lg" style="padding: 1px;font-size: 1em;" data-toggle="modal" data-target="#CreatAssignmentModal" onclick="timelimit();">
								新建任务
							</button>
						</div>
					</div>
					<!-- 来一条分割线怎么说 -->
					<div class="row" style="border-bottom: 1px solid #CCC;">
						<!-- <hr> -->
					</div>
					<div class="row">
						<div id="AssignmentList" class="col-md-12">
							<!-- 打印每一条任务信息 -->
						</div>
					</div>
				</div>
			</div>
			
			<!-- 项目评分模块 -->
			<div id="projectscorediv" style="width: 90%;margin-top: 10px;display: flex;justify-content: space-between;">
				<div style="display: flex;">
					<div style="padding: 1px 4px;">
						项目评分:
					</div>
					<div>
						<input id="projectscore" type="text" class="" style="width: auto;border-radius: 2px;" placeholder="输入0-100的正数" title="输入0-100的正数">
					</div>
				</div>
				<div style="padding: 1px 4px;">
					<input id="projectsubmitscore" type="button" class="btn btn-primary" style="padding: 2px 4px;" value="提交分数" onclick="projectsubmitscore();">
				</div>
			</div>
	
		</div>
	</div>
	
	<!-- 新建任务模态框 -->
	<!-- Modal -->
	<div class="modal fade" id="CreatAssignmentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">新建任务</h4>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="">任务编号</label>
							<input type="text" class="form-control" id="c_assignmentcode" name="code" placeholder="assignmentcode 可选">
						</div>
						<div class="form-group">
							<label for="">任务名称</label>
							<input type="" class="form-control" id="c_assignmentname" name="name" placeholder="assignmentname">
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
					<button type="button" id="createnewassignment" class="btn btn-primary" onclick="createnewassignment(<%=request.getAttribute("projectid") %>);">创建新任务</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 发配任务模态框 -->
	<!-- Modal -->
	<div class="modal fade" id="AllotAssignmentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">发配任务</h4>
				</div>
				<div class="modal-body">
					<div style="display: flex;width: 100%;">
						<div style="width: 6em;padding-right: 10px;"><label>指派成员:</label></div>
						<div>
							<span style="absolute;margin-top:-12px;">
							    <table cellspacing="0" cellpadding="0" width="100%" border="0">
							        <tr>
							            <td align="left">
							                <span style="position:absolute;border:1pt solid #c1c1c1;overflow:hidden;width:188px;height:19px;clip:rect(-1px 190px 190px 170px);">
							                    <select name="allotstudents" id="allotstudents" style="width:190px;height:20px;margin:-2px;" onchange="chosestudent();">
													<!-- <option value="" style="color:#c2c2c2;">---请选择---</option> -->
													<!-- getstudent()函数填充 -->
							                    </select>
							                </span>
							                <span style="position:absolute;border-top:1pt solid #c1c1c1;border-left:1pt solid #c1c1c1;border-bottom:1pt solid #c1c1c1;width:170px;height:19px;">
							                    <input type="text" name="allotstudentchose" id="allotstudentchose" placeholder="可选择也可输入的下拉框" value="" style="width:170px;height:15px;border:0pt;">
							                </span>
							            </td>
							            <td>
							            	<label id="allotstudentremind"></label>
							            </td>
							        </tr>
							    </table>
							</span>	
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" id="allotassignment" class="btn btn-primary" onclick="allotassignment();">指配</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改任务模态框 -->
	<!-- Modal -->
	<div class="modal fade" id="EditAssignmentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">编辑任务信息</h4>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="">任务编号</label>
							<input type="text" class="form-control" id="e_assignmentcode" name="code" placeholder="assignmentcode 可选">
						</div>
						<div class="form-group">
							<label for="">任务名称</label>
							<input type="" class="form-control" id="e_assignmentname" name="name" placeholder="assignmenttname">
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
					<button type="button" id="updateassignment" class="btn btn-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>