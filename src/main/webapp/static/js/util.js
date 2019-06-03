	//用户登出
	/**
	 * 用户登出
	 * @returns
	 */
	function loginout() {
		console.log("用户登出!");
		window.location.href="/teamwork/teacher/loginout";
		alert("成功登出!");
	}

	//解决编号过长
	/**
	 * 解决编号过长
	 * @param data 编号字符串
	 * @returns
	 */
	function codetoolang(data) {
		//console.log("codetoolang:"+data+" "+data.length);
		var code = data;
		if (code.length >= 8) {
			code = code.substr(0,8)+"...";
		}
		return code;
	}
	
	//从时间戳获取时间
	/**
	 * 从时间戳获取时间
	 * @param data 时间戳
	 * @returns
	 */
	function getdate(data) {
		var now = new Date(data),
		y = now.getFullYear(),
		m = ("0" + (now.getMonth() + 1)).slice(-2),
		d = ("0" + now.getDate()).slice(-2);
		return y + "-" + m + "-" + d + " " + now.toTimeString().substr(0, 8);
	}
	
	//从时间戳获取年月日
	/**
	 * 从时间戳获取年月日
	 * @param data 时间戳
	 * @returns
	 */
	function getdateymd(data) {
		var now = new Date(data),
		y = now.getFullYear(),
		m = ("0" + (now.getMonth() + 1)).slice(-2),
		d = ("0" + now.getDate()).slice(-2);
		return y + "-" + m + "-" + d;
	}
	
	//写cookies
	/**
	 * 写cookies
	 * @param name
	 * @param value
	 * @returns
	 */
	function setMyCookie(name,value) {
		var Days = 30;
		var exp = new Date();
		exp.setTime(exp.getTime() + Days*24*60*60*1000);
		document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
	}

	//读取cookies
	/**
	 * 读取cookies
	 * @param name
	 * @returns
	 */
	function getMyCookie(name) {
		var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
		if(arr=document.cookie.match(reg))
			return unescape(arr[2]);
		else
			return null;
	}

	//删除cookies
	/**
	 * 删除cookies
	 * @param name
	 * @returns
	 */
	function delMyCookie(name) {
		var exp = new Date();
		exp.setTime(exp.getTime() - 1);
		var cval=getCookie(name);
		if(cval!=null)
			document.cookie= name + "="+cval+";expires="+exp.toGMTString();
	}

	//画进度条
	function drawprogress(progress) {
		var progressdiv = $("<div></div>").addClass("progress").attr({"id":"progress","style":"margin: 1px;min-width: 250px;width: 100%;"});
		progressdiv.append($("<div></div>")
		.addClass("progress-bar")
		.attr({"role":"progressbar","aria-valuenow":"60","aria-valuemin":"0","aria-valuemax":"100","style":"width: "+progress+"%;min-width: 2em;"})
		.text(progress+"%"));
		return progressdiv;
	}
	
	//教师创建一个新项目
	/**
	 * 教师创建一个新项目
	 * @param courseid 课程id
	 * @returns
	 */
	function creatnewproject(courseid) {
		console.log("creatnewproject");
		//模态框中的各个字段
		var c_projectcode = $("#c_projectcode").val();
		var c_projectname = $("#c_projectname").val();
		var c_starttime = $("#c_starttime").val();
		var cst = Number(new Date(c_starttime));
		var c_endtime = $("#c_endtime").val();
		var cet = Number(new Date(c_endtime));
		var c_description = $("#c_description").val();
		var tid = $("#allotteamlist").val();
		
//		if($("#createbaseproject").is(":checked")) {
//		    // do something
//			console.log("同步创建项目!");
//		}
		
		console.log("c_projectcode "+c_projectcode);//+c_projectname+c_starttime+c_endtime+c_description);
		console.log("c_projectname "+c_projectname);
		console.log("c_starttime "+c_starttime+" num: "+cst);
		console.log("c_endtime "+c_endtime+" num: "+cet);
		console.log("c_description "+c_description);
		console.log($("#CreattProjectModal form").serialize());
		console.log("tid "+tid);
		
		if (c_projectname == null || c_projectname == "") {
			alert("创建项目请指定项目名!");
			return null;
		}
		if (c_starttime == null || c_starttime == "" || c_endtime == null || c_endtime == "") {
			alert("创建项目时请指定时间!");
			return null;
		}
		
		if ($("#createbaseproject").prop("checked")) {
			console.log("同步创建项目!");
			$.ajax({
				type:"post",
				dataType:"json",
				data:{code:c_projectcode,name:c_projectname,courseid:courseid,starttime:cst,endtime:cet,description:c_description},
				url:"/teamwork/project/insertprojectforallteam",
				success:function(data){
					console.log("success");
					console.log(data);
					if (data.code == "100") {
						console.log(data.info);
					}
					if (data.code == "200") {
						console.log(data.info);
						alert("成功创建项目!");
						//创建成功隐藏模态框
						$("#CreatProjectModal").modal("hide");
						//填充班级项目信息
						ajaxproject(courseid);
					}
				},
				error:function(data){
					console.log("error");
					console.log(data);
				}
			});
		}else{
			$.ajax({
				type:"post",
				dataType:"json",
				data:{code:c_projectcode,name:c_projectname,courseid:courseid,tid:tid,starttime:cst,endtime:cet,description:c_description},
				url:"/teamwork/project/insertproject",
				success:function(data){
					console.log("success");
					console.log(data);
					if (data.code == "100") {
						console.log(data.info);
					}
					if (data.code == "200") {
						console.log(data.info);
						alert("成功创建项目!");
						//创建成功隐藏模态框
						$("#CreatProjectModal").modal("hide");
						//填充班级项目信息
						ajaxproject(courseid);
					}
				},
				error:function(data){
					console.log("error");
					console.log(data);
				}
			});
		}
	}
	
	//更新项目信息
	/**
	 * 根据项目id更新项目信息
	 * @param id 项目id
	 * @returns
	 */
	function updateproject(id) {
		console.log("updateproject");
		var e_projectcode = $("#e_projectcode").val();
		var e_projectname = $("#e_projectname").val();
		var e_starttime = $("#e_starttime").val();
		var est = Number(new Date(e_starttime));
		var e_endtime = $("#e_endtime").val();
		var eet = Number(new Date(e_endtime));
		var e_description = $("#e_description").val();
		console.log(e_projectcode+" "+e_projectname+" "+e_starttime+" "+e_endtime+" "+e_description);
		console.log($("#EditProjectModal form").serialize());
		
		if (e_projectname == null || e_projectname == "") {
			alert("创建项目请指定项目名!");
			return null;
		}
		if (e_starttime == null || e_starttime == "" || e_endtime == null || e_endtime == "") {
			alert("创建项目时请指定时间!");
			return null;
		}
		
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:id,code:e_projectcode,name:e_projectname,starttime:est,endtime:eet,description:e_description},
			url:"/teamwork/project/updateproject",
			success:function(data){
				console.log("success");
				console.log(data);
				if (data.code == "100") {
					console.log(data.info);
				}
				if (data.code == "200") {
					console.log(data.info);
					alert("更新成功!");
					//更新成功隐藏模态框
					$("#EditProjectModal").modal("hide");
					//重新填充班级项目信息
					ajaxproject(courseid);
				}
			},
			error:function(data){
				console.log("error");
				console.log(data);
			}
		});
	}
	
	//删除项目
	/**
	 * 根据项目id删除项目
	 * @param projectid 项目id
	 * @param projectname 项目名称
	 * @returns
	 */
	function deleteProject(projectid,projectname){
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
	
	/**
	 * 创建新任务
	 * @param projectid
	 * @returns
	 */
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
					alert("创建成功!")
					//隐藏模态框
					$("#CreatAssignmentModal").modal("hide");
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
	
	//更新任务信息
	/**
	 * 根据任务id更新项目信息
	 * @param id 项目id
	 * @returns
	 */
	function updateassignment(id) {
		console.log("updateassignment");
		var e_assignmentcode = $("#e_assignmentcode").val();
		var e_assignmentname = $("#e_assignmentname").val();
		var e_starttime = $("#e_starttime").val();
		var est = Number(new Date(e_starttime));
		var e_endtime = $("#e_endtime").val();
		var eet = Number(new Date(e_endtime));
		var e_description = $("#e_description").val();
		console.log(e_assignmentcode+" "+e_assignmentname+" "+e_starttime+" "+e_endtime+" "+e_description);
		console.log($("#EditAssignmentModal form").serialize());
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:id,code:e_assignmentcode,name:e_assignmentname,starttime:est,endtime:eet,description:e_description},
			url:"/teamwork/assignment/updateassignment",
			success:function(data){
				console.log("success");
				console.log(data);
				if (data.code == "100") {
					console.log(data.info);
				}
				if (data.code == "200") {
					console.log(data.info);
					alert("更新成功!");
					//隐藏模态框
					$("#EditAssignmentModal").modal("hide");
					//重新填充任务信息
					ajaxgetassignment(projectid);
				}
			},
			error:function(data){
				console.log("error");
				console.log(data);
			}
		});
	}
	
	//删除任务
	/**
	 * 根据项目id删除任务
	 * @param assignmentid 任务id
	 * @param assignmentname 任务名称
	 * @returns
	 */
	function deleteAssignment(assignmentid,assignmentname){
		var del = confirm("确定删除"+assignmentname+"项目吗!");
		if (del) {//点击确定
			console.log("删除"+assignmentid+" "+assignmentname+" 项目!");
			$.ajax({
				type:"post",
				dataType:"json",
				data:{assignmentid:assignmentid},
				url:"/teamwork/assignment/deleteassignment",
				success:function(data){
					console.log("接入/teamwork/assignment/deleteassignment");
					if (data.code == "100") {
						console.log(data.info);
					}
					if (data.code == "200") {
						console.log(data.info);
						alert("删除成功!");
						//重新填充任务信息
						ajaxgetassignment(projectid);
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
	
	/**
	 * 提交分数
	 * 小组的得分
	 * 判断是否小组成员的分数也和小组分数相同
	 * @returns
	 */
	function courseteamsubmitscore(){
		//取得分数框中的分数
		var teamscore = $("#teamscore").val();
		if (teamscore == null || teamscore == "") {
			//无效值
			alert("输入有效值!");
		} else {
			if (Number(teamscore) > 100 || Number(teamscore) < 0) {
				//无效值
				alert("输入有效值!"+teamscore+teamid);
			} else {
				//有效值,是否同步
				if($("#samescore").prop("checked")){//同步选中
					//alert("同步选中!"+teamscore+" "+teamid);
					$.ajax({
						type:"post",
						dataType:"json",
						data:{teamid:teamid,score:teamscore},
						url:"/teamwork/setteampersonscore",
						success:function(data){
							if (data.code == "100") {
								console.log(data.info);
							}
							if (data.code == "200") {
								console.log(data.info);
								alert("分数提交成功!");
							}
						},
						error:function(data){
							console.log(data);
						}
					});
					
				}else{//未选中同步评分学生等同小组
					//alert("未同步选中!"+teamscore+" "+teamid);
					$.ajax({
						type:"post",
						dataType:"json",
						data:{teamid:teamid,score:teamscore},
						url:"/teamwork/setteamscore",
						success:function(data){
							if (data.code == "100") {
								console.log(data.info);
							}
							if (data.code == "200") {
								console.log(data.info);
								alert("分数提交成功!");
							}
						},
						error:function(data){
							console.log(data);
						}
					});
				}
			}
		}
	}
	
	/**
	 * 提交个人分数
	 * 班级id和学生id作为查询参数
	 * @returns
	 */
	function coursestudentpersonsubmitscore(){
		//取得分数框中的分数
		var personscore = $("#coursestudentpersonscore").val();
		if (personscore == null || personscore == "") {
			//无效值
			alert("输入有效值!");
		} else {
			if (Number(personscore) > 100 || Number(personscore) < 0) {
				//无效值
				alert("输入0-100有效值!");
			} else {
				//有效值
				$.ajax({
					type:"post",
					dataType:"json",
					data:{courseid:courseid,studentid:studentid,personscore:personscore},
					url:"/teamwork/coursestudent/updatecoursestudentscore",
					success:function(data){
						if (data.code == "100") {
							console.log(data.info);
						}
						if (data.code == "200") {
							console.log(data.info);
							alert("分数提交成功!");
						}
					},
					error:function(data){
						console.log(data);
					}
				});
			}
		}
	}
	
	/**
	 * 提交项目分数
	 * 项目id和项目分数
	 * @returns
	 */
	function projectsubmitscore(){
		//取得分数框中的分数
		var projectscore = $("#projectscore").val();
		if (projectscore == null || projectscore == "") {
			//无效值
			alert("输入有效值!");
		} else {
			if (Number(projectscore) > 100 || Number(projectscore) < 0) {
				//无效值
				alert("输入0-100有效值!");
			} else {
				//有效值
				$.ajax({
					type:"post",
					dataType:"json",
					data:{id:projectid,score:projectscore},
					url:"/teamwork/project/updateproject",
					success:function(data){
						if (data.code == "100") {
							console.log(data.info);
						}
						if (data.code == "200") {
							console.log(data.info);
							alert("分数提交成功!");
						}
					},
					error:function(data){
						console.log(data);
					}
				});
			}
		}
	}
	
	/**
	 * 提交任务分数
	 * 任务id和任务分数
	 * @returns
	 */
	function assignmentsubmitscore(){
		//取得分数框中的分数
		var assignmentscore = $("#assignmentscore").val();
		if (assignmentscore == null || assignmentscore == "") {
			//无效值
			alert("输入有效值!");
		} else {
			if (Number(assignmentscore) > 100 || Number(assignmentscore) < 0) {
				//无效值
				alert("输入0-100有效值!");
			} else {
				//有效值
				$.ajax({
					type:"post",
					dataType:"json",
					data:{id:assignmentid,score:assignmentscore},
					url:"/teamwork/assignment/updateassignment",
					success:function(data){
						if (data.code == "100") {
							console.log(data.info);
						}
						if (data.code == "200") {
							console.log(data.info);
							alert("分数提交成功!");
						}
					},
					error:function(data){
						console.log(data);
					}
				});
			}
		}
	}
	
	//项目状态描述规范
	function projectstate(projectstate){
		var divstate = $("<div></div>");
		if (projectstate == 1) {//未开始
			divstate.attr({"style":"color: #d0d066;"}).text("未开始");
		}
		if (projectstate == 2) {//进行中
			divstate.attr({"style":"color: blue;"}).text("进行中");		
		}
		if (projectstate == 3) {//已完成
			divstate.attr({"style":"color: green;"}).text("已完成");
		}
		if (projectstate == 4) {//已逾期
			divstate.attr({"style":"color: red;"}).text("已逾期");
		}
		return divstate;
	}
	
	//项目结束时间规范
	function projectfinishtime(projectfinishtime) {
		var divfinishtime = $("<div></div>");
		if (projectfinishtime == null) {
			divfinishtime.text("----");
		}else{
			divfinishtime.text(getdate(projectfinishtime));
		}
		return divfinishtime;
	}
	
	//项目，任务 状态判定
	/**
	 * 状态判定
	 * @param endtime
	 * @param finishtime
	 * @param progress
	 * @returns
	 */
	function getstate(endtime,finishtime,progress) {
		var statediv = $("<div></div>");
		var state = "";
		//有完成时间和完成时间比较
		if (finishtime != null && finishtime != "") {
			if (endtime < finishtime) {
				state = "逾期";
				statediv.attr({"style":"color: red;"});
			}
			else {
				//只有提交完成以后或进度100才有完成时间,所以不用判断进度
				state = "完成";
				statediv.attr({"style":"color: green;"});
			}
		}
		//没有完成时间和当前时间比较
		else {
			if (endtime >= Number(new Date())) {
				if (progress == 0) {
					state = "未开始";
					statediv.attr({"style":"color: #d0d066;"});
				}else if (progress > 0 && progress < 100) {
					state = "进行中";
					statediv.attr({"style":"color: blue;"});
				}else if (progress == 100) {
					state = "已完成";
					statediv.attr({"style":"color: green;"});
				}
			}else {
				state = "逾期";
				statediv.attr({"style":"color: red;"});
			}
		}
		statediv.text(state);
		return statediv;
	}
	
	//页面跳转
	/**
	 * 班级学生任务列表页
	 * @param courseid
	 * @param studentid
	 * @returns
	 */
	function toCourseStudentAssignment(courseid,studentid){
		//alert("toCourseStudentAssignment"+courseid+typeof(courseid)+" "+studentid+typeof(studentid));
		console.log("toCourseStudentAssignment"+courseid+typeof(courseid)+" "+studentid+typeof(studentid));
		window.location.href="/teamwork/jump/coursestudentassignment?studentid='"+studentid+"'&courseid='"+courseid+"'";
	}
	
	//取得学生成绩
	/**
	 * 取得学生成绩
	 * @param studentid
	 * @param courseid
	 * @returns
	 */
	function ajaxcoursestudent(studentid,courseid){
		$.ajax({
			type:"post",
			dataType:"json",
			data:{courseid:courseid,studentid:studentid},
			url:"/teamwork/coursestudent/findcoursestudentbycsid",
			success:function(data){
				console.log("success");
				console.log(data);
				if (data.code == "100") {
					console.log(data.info);
				}
				if (data.code == "200") {
					console.log(data.info);
					//重新填充任务信息
					displayscore(data.coursestudent);
				}
			},
			error:function(data){
				console.log("error");
				console.log(data);
			}
		});
	}
	
	