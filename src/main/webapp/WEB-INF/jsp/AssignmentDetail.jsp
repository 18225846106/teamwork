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
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/AssignmentDetail.css" type="text/css">

<!-- 引入进度条样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/ProgressBar.css" type="text/css">

<!-- 引入进度球的ProgressBall的样式 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/ProgressBall.css" type="text/css">

<!-- 引入util的js文件 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/util.js"></script>

<script type="text/javascript">
	
	var role = "<%=session.getAttribute("role") %>";
	var assignmentid = <%=request.getAttribute("assignmentid")%>;
	var loginid = <%=session.getAttribute("username")%>;
	
	$(function() {
		var assignmentid = <%=request.getAttribute("assignmentid")%>;
		var loginid = <%=session.getAttribute("username")%>;
		var role = "<%=session.getAttribute("role") %>";
		console.log("assignmentid:"+assignmentid+typeof(assignmentid));
		
		//一和二两步
		if (assignmentid != null || assignmentid != "") {
			findassignment(assignmentid,loginid);
		}
		//第三步
		ajaxassignmentdetail(assignmentid);
		
		//根据角色是指只读
		if (role == "teacher") {
			$("#details").attr("readonly",true);//角色是教师，不允许对任务核心修改，隐藏两个按钮
			$("#cleardetails").hide();
			$("#submitdetails").hide();
			$("#finishprogress").hide();//隐藏任务完成按钮
		}
		if (role == "student") {
			$("#message").attr("readonly",true);//角色是学生，不允许对评语修改，隐藏两个按钮·
			$("#clearmessage").hide();
			$("#submitmessage").hide();
			$("#assignmentscorediv").hide();//评分模块关闭
		}
	});
	
	//第一步:获取任务信息
	function findassignment(assignmentid,loginid) {
		if (assignmentid != null || assignmentid != "") {
			//获取任务信息
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
						//不是本人，所以整个页面disabled，权限等级也不是教师
						console.log(data.assignment.studentid);
						console.log(loginid);
						if (data.assignment.studentid != loginid && '<%=session.getAttribute("role") %>' != "teacher") {
							//$("div").attr("readonly",true);
							//$("#divcenter").attr("disabled",true);
							$("input").attr("disabled",true);
							$("#details").attr("readonly",true);
						}
						//填充任务评分
						$("#assignmentscore").val(data.assignment.score);
						//填充任务信息到页面
						displayassignment(data.assignment);
						//查找project
						findprojectdetail(data.assignment.projectid);
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
	
	//第二步:获取项目信息
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
						dispalyproject(data.project);
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
	
	//第三步:获取任务详情内容信息
	function ajaxassignmentdetail(assignmentid){
		$.ajax({
			type:"post",
			dataType:"json",
			data:{assignmentid:assignmentid},
			url:"/teamwork/assignmentdetail/findassignmentdetailbyassignmentid",
			success:function(data){
				if (data.code == "100") {
					console.log(data.info);
					//将任务的内容写在文本框内
					$("#details").val("拉取失败!点击刷新重试").attr({"onclick":"ajaxassignmentdetail('"+assignmentid+"')"});
					//将意见评语写入文本框
					$("#message").val("拉取失败!点击刷新重试").attr({"onclick":"ajaxassignmentdetail('"+assignmentid+"')"});
				}
				if (data.code == "200") {
					console.log(data.info);
					//将任务的内容写在文本框内
					$("#details").val(data.assignmentdetail.details);
					//将意见评语写入文本框
					$("#message").val(data.assignmentdetail.message);
				}
			},
			error:function(data){
				console.log(data);
				//将任务的内容写在文本框内
				$("#details").val("请求失败!");
				//将意见评语写入文本框
				$("#message").val("请求失败!");
			}
		});
	}
	
	//打印项目信息
	function dispalyproject(data) {
		var project = data;
		console.log("project:"+project+typeof(project));
		$("#projectname").val(codetoolang(project.name)).attr({"title":project.name});
	}
	
	//打印任务信息
	function displayassignment(assignment) {
		//var assignment = assignment;
		//console.log("assignment:"+assignment+typeof(assignment));
		$("#projectid").val(codetoolang(assignment.projectid)).attr({"title":assignment.projectid});
		$("#assignmentid").val(codetoolang(assignment.id)).attr({"title":assignment.id});
		$("#assignmentname").val(codetoolang(assignment.name)).attr({"title":assignment.name});
		$("#assignmentstarttime").val(getdate(assignment.starttime));
		$("#assignmentendtime").val(getdate(assignment.endtime));
		if (assignment.finishtime != null && assignment.finishtime != "") {
			$("#assignmentfinishtime").val(getdate(assignment.finishtime));
		} else {
			$("#assignmentfinishtime").val("");
		}
		//先清空
		$("#assignmentprogress").empty();
		$("#assignmentprogress").append($("<div></div>").attr({"style":"min-width: 3em;"}).text("进度:"));
		$("#assignmentprogress").append(drawprogress(assignment.progress))//进度条
		//判断角色,是否添加可以编辑的按钮
		if ("<%=session.getAttribute("role") %>" == "student") {//是学生可以改进度
			//$("#assignmentprogress").append($("<div></div>").append(
			//		$("<input></input>").attr({"style":"padding: 1px;margin: 0px 4px;width: 5em;","type":"button","value":"修改进度","onclick":"editprogress()"}).addClass("btn btn-default")));
		}else if("<%=session.getAttribute("role") %>" == "teacher"){//教师没有改进度按钮
			//$("#assignmentprogress").append($("<div></div>").append(
			//		$("<input></input>").attr({"style":"padding: 1px;margin: 0px 4px;width: 5em;","type":"button","value":"修改进度","onclick":"editprogress()"}).addClass("btn btn-default")));
			$("#editprogress").hide();
		}
		$("#assignmentstate").append(getstate(assignment.endtime,assignment.finishtime,assignment.progress));
		/* if (assignment.state == 1) {
			$("#assignmentstate").text("未开始");
		}
		if (assignment.state == 2) {
			$("#assignmentstate").text("进行中").attr({"style":"color: blue;"});
		}
		if (assignment.state == 3) {
			$("#assignmentstate").text("已完成").attr({"style":"color: green;"});
		}
		if (assignment.state == 4) {
			$("#assignmentstate").text("已逾期").attr({"style":"color: red;"});
		} */
		//描述信息
		$("#assignmentdescription").val(assignment.description);
	}
	
	//清空任务详情的内容
	function cleardetails(){
		if(confirm("清空任务内容?")){
			$("#details").val("");
		}
	}
	
	//提交任务详情的内容
	function submitdetails(){
		var details = $("#details").val();
		if(confirm("确认提交任务内容?")){
			alert(details);
			$.ajax({
				type:"post",
				dataType:"json",
				data:{assignmentid:assignmentid,details:details},
				url:"/teamwork/assignmentdetail/updateassignmentdetailbyassignmentid",
				success:function(data){
					if (data.code == "100") {
						console.log(data.info);
					}
					if (data.code == "200") {
						console.log(data.info);
					}
				},
				error:function(data){
					console.log(data);
				}
			});
		}
	}
	
	//清空任务详情的内容
	function clearmessage(){
		//console.log($("#message").val());
		if(confirm("清空任务内容?")){
			$("#message").val("");
		}
	}
	
	//提交任务评语的内容
	function submitmessage(){
		var message = $("#message").val();
		if(confirm("确认提交任务评语?")){
			//alert(message);
			$.ajax({
				type:"post",
				dataType:"json",
				data:{assignmentid:assignmentid,message:message},
				url:"/teamwork/assignmentdetail/updateassignmentdetailbyassignmentid",
				success:function(data){
					if (data.code == "100") {
						console.log(data.info);
					}
					if (data.code == "200") {
						console.log(data.info);
					}
				},
				error:function(data){
					console.log(data);
				}
			});
		}
	}
	
	//修改进度
	function editprogress(){
		console.log("修改进度");
		var progress = prompt("进度:");
		if (progress != "" && progress != null) {
			$.ajax({
				type:"post",
				dataType:"json",
				data:{id:assignmentid,progress:progress},
				url:"/teamwork/assignment/updateassignment",
				success:function(data){
					if (data.code == "100") {
						console.log(data.info);
						alert(data.info);
					}
					if (data.code == "200"){
						console.log(data.info);
						//重新加载显示
						findassignment(assignmentid,loginid);
					}
				},
				error:function(data){
					
				}
			});
		}
	}
	//完成任务
	function finishassignment(){
		if (confirm("确定完成任务!")) {
			$.ajax({
				type:"post",
				dataType:"json",
				data:{id:assignmentid,progress:100},
				url:"/teamwork/assignment/updateassignment",
				success:function(data){
					if (data.code == "100") {
						console.log(data.info);
						alert(data.info);
					}
					if (data.code == "200"){
						console.log(data.info);
						//重新加载显示
						findassignment(assignmentid,loginid);
					}
				},
				error:function(data){
					
				}
			});
		}
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
		
			<!-- 任务细则外包容器 -->
			<div class="AssignmentDetailContain">
				<!-- 展示任务的一些细则 -->
				<div class="container" style="width: 100%;">
					<!-- 表头提示 -->
					<div class="row">
						<p>任务细则</p>
					</div>
					<!-- 来一条分割线怎么说 -->
					<div class="row" style="border-bottom: 1px solid #CCC;"></div>
					<!-- 表体 -->
					<div class="row">
						<div style="width: 100%;padding: 1px;margin: 2px;">
							<div style="display: flex;margin: 2px;">
								<div style="margin: 0px 2px;">项目编码: <input id="projectid" style="border: 1px solid #e2e2e4;" type="text" readonly="readonly"></div>
								<div style="margin: 0px 2px;">项目名称: <input id="projectname" style="border: 1px solid #e2e2e4;" type="text" readonly="readonly"></div>
							</div>
							<!-- 来一条分割线怎么说 -->
							<div style="border-bottom: 1px solid #CCC;margin: 1px 0px;"></div>
							<div style="display: flex;margin: 2px;">
								<div style="margin: 0px 2px;">任务编码: <input id="assignmentid" style="border: 1px solid #e2e2e4;" type="text" readonly="readonly"></div>
								<div style="margin: 0px 2px;">任务名称: <input id="assignmentname" style="border: 1px solid #e2e2e4;" type="text" readonly="readonly"></div>
							</div>
							<!-- 来一条分割线怎么说 -->
							<div style="border-bottom: 1px solid #CCC;margin: 1px 0px;"></div>
							<div style="display: flex;margin: 2px;flex-wrap: wrap;">
								<div style="margin: 0px 2px;">开始时间: <input id="assignmentstarttime" style="border: 1px solid #e2e2e4;" type="text" readonly="readonly"></div>
								<div style="margin: 0px 2px;">截止时间: <input id="assignmentendtime" style="border: 1px solid #e2e2e4;" type="text" readonly="readonly"></div>
								<div style="margin: 0px 2px;">完成时间: <input id="assignmentfinishtime" style="border: 1px solid #e2e2e4;" type="text" readonly="readonly"></div>
							</div>
							<!-- 来一条分割线怎么说 -->
							<div style="border-bottom: 1px solid #CCC;margin: 1px 0px;"></div>
							<!-- 进度 -->
							<div id="assignmentprogress" style="display: flex;padding: 1px;margin: 2px;">
								<!-- <div style="min-width: 3em;">进度:</div> -->
								<!-- 进度条 -->
								<!-- 修改进度按钮 -->
							</div>
							<!-- 完成状态和按钮 -->
							<div id="assignmentstatediv" style="display: flex;justify-content: space-between;margin: 2px;">
								<div style="display: flex;">
									<div style="min-width: 5em;">任务状态: </div>
									<div id="assignmentstate"></div>
								</div>
								<div style="display: flex;">
									<input id="editprogress" type="button" class="btn btn-default" style="padding: 1px;margin: 0px 4px;width: 5em;" value="修改进度" onclick="editprogress();">
									<input id="finishprogress" type="button" class="btn btn-success" style="margin: 1px 2px;padding: 1px 2px;min-width: 4em;" value="完成" onclick="finishassignment();">
								</div>
							</div>
							<!-- 来一条分割线怎么说 -->
							<div style="border-bottom: 1px solid #CCC;margin: 1px 0px;"></div>
							<!-- 描述 -->
							<p>任务描述:</p>
							<div style="display: flex;">
								<!-- <input id="assignmentdescription" type="text" readonly="readonly"> -->
								<textarea id="assignmentdescription" style="width: 100%;" rows="3" cols="" readonly="readonly"></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 任务内容外包容器 -->
			<div class="AssignmentDetailsContain">
				<div class="container" style="width: 100%;">
					<!-- 表头提示 -->
					<div class="row" style="display: flex; justify-content: space-between;width: 100%;">
						<div style="width: 50%;">
							<p>任务完成内容</p>
						</div>
						<div class="row" style="display: flex;justify-content: flex-end;width: 50%;">
							<input id="cleardetails" type="button" class="btn btn-info" style="padding: 2px 4px;margin: 2px 4px;" value="清空内容" onclick="cleardetails()">
							<input id="submitdetails" type="button" class="btn btn-success" style="padding: 2px 4px;margin: 2px 4px;" value="保存修改" onclick="submitdetails()">
						</div>
					</div>
					<!-- 来一条分割线怎么说 -->
					<div class="row" style="border-bottom: 1px solid #CCC;"></div>
					<!-- 任务内容 -->
					<textarea id="details" class="form-control" style="margin: 2px;" rows="10"></textarea>
					<!-- <div class="row" style="display: flex;justify-content: space-between;">
						<input id="cleardetails" type="button" class="btn btn-info" style="padding: 2px 4px;" value="清空内容" onclick="cleardetails()">
						<input id="submitdetails" type="button" class="btn btn-success" style="padding: 2px 4px;" value="提交保存" onclick="submitdetails()">
					</div> -->
					<!-- 来一条分割线怎么说 -->
					<div class="row" style="border-bottom: 1px solid #CCC;"></div>
				</div>
			</div>
			<!-- 评语内容 -->
			<div class="AssignmentmessageContain">
				<div class="container" style="width: 100%;">
					<!-- 评语内容头 -->
					<div class="row" style="display: flex; justify-content: space-between;width: 100%;">
						<div style="width: 50%;">
							<p>教师评语意见</p>
						</div>
						<div class="row" style="display: flex;justify-content: flex-end;width: 50%;">
							<input id="clearmessage" type="button" class="btn btn-info" style="padding: 2px 4px;margin: 2px 4px;" value="清空内容" onclick="clearmessage()">
							<input id="submitmessage" type="button" class="btn btn-success" style="padding: 2px 4px;margin: 2px 4px;" value="保存修改" onclick="submitmessage()">
						</div>
					</div>
					<!-- 来一条分割线怎么说 -->
					<div class="row" style="border-bottom: 1px solid #CCC;"></div>
					<!-- 留言内容 -->
					<textarea id="message" class="form-control" style="margin: 2px;padding: 2px;" rows="4"></textarea>
				</div>
			</div>
			
			<!-- 任务评分模块 -->
			<div id="assignmentscorediv" style="width: 95%;margin-top: 10px;display: flex;justify-content: space-between;">
				<div style="display: flex;">
					<div style="padding: 1px 4px;">
						任务评分:
					</div>
					<div>
						<input id="assignmentscore" type="text" class="" style="width: auto;border-radius: 2px;" placeholder="输入0-100的正数" title="输入0-100的正数">
					</div>
				</div>
				<div style="padding: 1px 4px;">
					<input id="assignmentsubmitscore" type="button" class="btn btn-primary" style="padding: 2px 4px;" value="提交分数" onclick="assignmentsubmitscore();">
				</div>
			</div>
			
		</div>
	</div>

</body>
</html>