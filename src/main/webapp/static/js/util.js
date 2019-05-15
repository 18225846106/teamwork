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
	 * @param data
	 * @returns
	 */
	function codetoolang(data) {
		console.log("codetoolang");
		var code = data;
		if (code.length >= 5) {
			code = code.substr(0,5)+"...";
		}
		return code;
	}
	
	//从时间戳获取时间
	/**
	 * 从时间戳获取时间
	 * @param data
	 * @returns
	 */
	function getdate(data) {
		var now = new Date(data),
		y = now.getFullYear(),
		m = ("0" + (now.getMonth() + 1)).slice(-2),
		d = ("0" + now.getDate()).slice(-2);
		return y + "-" + m + "-" + d + " " + now.toTimeString().substr(0, 8);
	}
	
	//教师创建一个新项目
	/**
	 * 教师创建一个新项目
	 * @param courseid
	 * @returns
	 */
	function creatnewproject(courseid) {
		console.log("creatnewproject");
		var c_projectcode = $("#c_projectcode").val();
		var c_projectname = $("#c_projectname").val();
		var c_starttime = $("#c_starttime").val();
		var cc_starttime = $("#c_starttime").text();
		var cst = Number(new Date(c_starttime));
		var c_endtime = $("#c_endtime").val();
		var cc_endtime = $("#c_endtime").text();
		var cet = Number(new Date(c_endtime));
		var c_description = $("#c_description").val();
		console.log("c_projectcode "+c_projectcode);//+c_projectname+c_starttime+c_endtime+c_description);
		console.log("c_projectname "+c_projectname);
		console.log("c_starttime "+c_starttime+" text: "+cc_starttime+" num: "+cst);
		console.log("c_endtime "+c_endtime+" text: "+cc_endtime+" num: "+cet);
		console.log("c_description "+c_description);
		console.log($("#CreattProjectModal form").serialize());
		$.ajax({
			type:"post",
			dataType:"json",
			data:{code:c_projectcode,name:c_projectname,courseid:courseid,starttime:cst,endtime:cet,description:c_description},
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
	
	//更新项目信息
	/**
	 * 更新项目信息
	 * @param id
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
	
	