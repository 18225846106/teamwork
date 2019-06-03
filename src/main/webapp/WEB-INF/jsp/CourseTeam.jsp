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

<!-- 引入bootstrap的js文件 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>

<!-- 引入CourseTeam页面的css样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/CourseTeam.css" type="text/css">

<!-- 引入进度条样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/ProgressBar.css" type="text/css">

<!-- 引入util的js文件 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/util.js"></script>

<script type="text/javascript">
	
	var teamid = <%=request.getAttribute("teamid")%>;
	
	var sid = "";
	
	var allstudnets;//存储一下小组的所有人，要用到学号修改分数

	$(function(){
		var teamid = <%=request.getAttribute("teamid")%>;
		
		console.log("teamid:"+<%=request.getAttribute("teamid")%>);
		
		//第一步:查询小组成员信息
		ajaxteamstudents(teamid);
		
		//第二步:查询小组内所有项目信息
		ajaxteamprojects(teamid);
		
		//第三部:显示分数
		ajaxteam(teamid);
		
	});
	
	//小组信息
	function ajaxteam(teamid){
		$.ajax({
			type:"post",
			dataType:"json",
			data:{teamid:teamid},
			url:"/teamwork/team/findteambyteamid",
			success:function(data){
				if (data.code == "200") {
					if (data.team.score != null) {
						//有小组分数时,显示小组分数
						$("#teamscore").val(data.team.score);
					}
				}
			},
			error:function(data){
				
			}
		});
	}
	
	//小组信息
	function displayteam(data) {
		
	}
	
	//第一步:查询小组成员信息
	function ajaxteamstudents(teamid){
		$.ajax({
			type:"post",
			dataType:"json",
			data:{teamid:teamid},
			url:"/teamwork/sts/findstsbyteamid",
			success:function(data){
				console.log("查询小组成员信息 success:"+data);
				if (data.code == "100") {//失败
					
				} 
				else if(data.code == "200"){//成功
					//1打印team
					//2打印students
					displaystudents(data.studentteamstudents);
				}
				else{
					//其他情况
				}
			},
			error:function(data){
				console.log("查询小组成员信息 error:"+data);
			}
		});
	}
	
	//第二步:查询小组内所有项目信息
	function ajaxteamprojects(teamid){
		$.ajax({
			type:"post",
			dataType:"json",
			data:{teamid:teamid},
			url:"/teamwork/project/findprojectbyteamid",
			success:function(data){
				console.log("查询小组内所有项目信息 success:"+data);
				if (data.code == "100") {//查询失败
					//
				} 
				else if(data.code == "200"){//查询成功
					//画项目信息
					displayprojects(data.projects);
				}
				else{
					//意外情况
				}
			},
			error:function(data){
				console.log("查询小组内所有项目信息 error:"+data);
			}
		});
	}
	
	//成员信息
	function displaystudents(data){
		//调用该函数，先清空标签内的内容
		$("#students_table").empty();
		var stss = data;
		//表头
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
				tr.append($("<td></td>").text("组长").attr({"onclick":"allotcharactermodal('"+sts.studentid+"')","title":"可重新指定!"}));
			}
			else if (sts.character == 2) {
				tr.append($("<td></td>").text("组员").attr({"onclick":"allotcharactermodal('"+sts.studentid+"')","title":"可重新指定!"}));
			}
			else if (sts.character == null) {
				tr.append($("<td></td>").text("指定").attr({"style":"color: blue;","onclick":"allotcharactermodal('"+sts.studentid+"')"}));
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
			//进度状态
			//one
			var tdone = $("<td></td>").append(trid).append(trname).append(trstate);
			//two
			var tdtwo = $("<td></td>").append(trstarttime).append(trsendtime).append(trsfinishime);
			//three///进度条
			var trthree = drawprogress(project.progress);
			//分数
			if (project.score == null || project.score == "") {
				var trfour = $("<tr></tr>").append($("<td></td>").text("项目分数:"+"----")).append($("<td></td>")).append($("<td></td>"));
			} else {
				var trfour = $("<tr></tr>").append($("<td></td>").text("项目分数:"+project.score)).append($("<td></td>")).append($("<td></td>"));
			}
			//all
			var onetwo = $("<tr></tr>")
			.append(tdone)
			.append(tdtwo)
			.append($("<td></td>"));
			//all-to-tbody-to-table//画出表格
			$("<tbody></tbody>").append(onetwo).append(trthree).append(trfour).appendTo(table);
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
		var divout = $("<div></div>").addClass("progress").attr({"style":"margin-bottom: 2px;"}).append(divinner);
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
	
	//指定学生角色模态框
	function allotcharactermodal(studentid){
		//consloe.log("指定学生担任角色 "+studentid+" teamid:"+teamid);
		//指定全局变量学生id
		sid = studentid;
		$("#AllotCharacterModal").modal({
			backdrop: 'static'
		});
	}
	
	//修改角色选择框中的内容
	function chosecharacter(){
		$("#allotcharacterchose").val($("#allotcharacters").find("option:selected").text());
	}
	
	//修改角色
	function allotcharacter(){
		var character = $("#allotcharacters").val();
		alert("sid "+sid+" tid "+teamid+" chose "+character);
		$.ajax({
			type:"post",
			dataType:"json",
			data:{teamid:teamid,studentid:sid,character:character},
			url:"/teamwork/teamstudent/updateteamstudent",
			success:function(data){
				if (data.code == "100") {
					//修改失败
					console.log(data.info);
				}
				if (data.code == "200"){
					//成功修改
					console.log(data.info);
				}
				//回显小组,刷新小组
				ajaxteamstudents(teamid);
			},
			error:function(data){
				
			}
		});
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
	
	$("#teamscore").keydown(function(e) {
		var keyCode = e.keyCode;
		if((keyCode >= 48 && keyCode <= 57 || keyCode === 190 || keyCode === 8) && !(!$("#inp2").val() && e.keyCode === 48)) {
			var num = ($("#inp2").val() + "" + e.key);
			if(/^[0-9]+(.[0-9]{0,2})?$/.test(num)) {
			} else {
				if(e.keyCode === 8) {
				return;
			}
			e.preventDefault();
			}
		} else {
			e.preventDefault();
		}
	});
	
	function clearNoNum(obj) {
		obj.value = obj.value.replace(/[^\d.]/g,""); //清除"数字"和"."以外的字符
        obj.value = obj.value.replace(/^\./g,""); //验证第一个字符是数字而不是
        obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
        obj.value = obj.value.replace(/(\d{0,2})(\d+)\.(\d\d).*$/,'$1$2.$3'); //只能输入两个小数
	}
	
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
	
			<!-- 展示团队人员信息 -->
			<div class="Student">
				<!-- 表头team -->
				<div class="container" style="width: 100%;">
					<div class="row">
						<div class="col-md-12">
							<table id="team_table" class="table table-hover">
							</table>
						</div>
					</div>
				</div>
				<!-- 表体students -->
				<div class="container" style="width: 100%;">
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
				<div class="container" style="width: 100%;">
					<div class="row">
						<!-- 右移一格 -->
						<!-- <div class="col-md-1">
						</div> -->
						<!-- 十二分格占中间十个 -->
						<div id="projectlists" class="col-md-12">
							<!-- 项目列表体 -->
							<!-- <table id="projects_table" class="table table-hover">
							</table> -->
						</div>
					</div>
				</div>
			</div>
			
			<!-- 小组评分模块 -->
			<div style="width: 95%;margin-top: 10px;display: flex;justify-content: space-between;">
				<!-- <div>
					<div class="form-group" style="display: flex;">
						小组分数:
						<input type="text" class="" style="width: auto;" id="teamscore" placeholder="输入0-100的正数" onkeyup="clearNoNum(this)">
						<input type="checkbox">小组成员分数与小组分数相同
					</div>
				</div> -->
				<div style="display: flex;">
					<div style="padding: 1px 4px;">
						小组分数:
					</div>
					<div>
						<input id="teamscore" type="text" class="" style="width: auto;border-radius: 2px;" placeholder="输入0-100的正数" <%-- onkeyup="clearNoNum(this)" --%> onkeyup="this.value = this.value.replace(/^(100|[1-9]\d{0,2})([.]{1,1}\d{1,2})$/,'')">
					</div>
					<div style="padding: 1px 4px;">
						<input id="samescore" type="checkbox">小组成员分数与小组分数相同
					</div>
				</div>
				<div style="padding: 1px 4px;">
					<input type="button" class="btn btn-primary" style="padding: 2px 4px;" value="提交分数" onclick="courseteamsubmitscore()">
				</div>
			</div>
			
		</div>
	</div>
	
	<!-- 指定角色模态框 -->
	<!-- Modal -->
	<div class="modal fade" id="AllotCharacterModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">指定角色</h4>
				</div>
				<div class="modal-body">
					<div style="display: flex;width: 100%;">
						<div style="width: 4em;padding-right: 10px;"><label>角色:</label></div>
						<div>
							<span style="absolute;margin-top:-12px;">
							    <table cellspacing="0" cellpadding="0" width="100%" border="0">
							        <tr>
							            <td align="left">
							                <span style="position:absolute;border:1pt solid #c1c1c1;overflow:hidden;width:188px;height:19px;clip:rect(-1px 190px 190px 170px);">
							                    <select name="allotcharacters" id="allotcharacters" style="width:190px;height:20px;margin:-2px;" onchange="chosecharacter();">
								                    <option value="" style="color:#c2c2c2;">---请选择---</option>
								                    <!-- 两种角色填充 -->
								                    <option value="1">组长</option>
								                    <option value="2">组员</option>
							                    </select>
							                </span>
							                <span style="position:absolute;border-top:1pt solid #c1c1c1;border-left:1pt solid #c1c1c1;border-bottom:1pt solid #c1c1c1;width:170px;height:19px;">
							                    <input type="text" name="allotcharacterchose" id="allotcharacterchose" placeholder="可选择也可输入的下拉框" value="" style="width:170px;height:15px;border:0pt;">
							                </span>
							            </td>
							            <td>
							            	<label id="allotcharacterremind"></label>
							            </td>
							        </tr>
							    </table>
							</span>	
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" id="allotcharacter" class="btn btn-primary" onclick="allotcharacter();">确定</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>