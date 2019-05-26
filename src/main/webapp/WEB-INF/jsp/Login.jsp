<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Customer Login</title>

<!-- 引入jQuery，使用ajax -->
<!-- <script type="text/javascript" src="/teamwork/jquery/2.1.4/jquery.min.js"></script> -->
<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/2.1.4/jquery.min.js"></script>

<!-- 引入bootstrap页面样式 -->
<!-- <link rel="stylesheet" type="text/css" href="/teamwork/static/bootstrap-3.3.7-dist/css/bootstrap.css"> -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/bootstrap-3.3.7-dist/css/bootstrap.css" type="text/css">

<!-- 引入Login页面的css样式 -->
<!-- <link rel="stylesheet" type="text/css" href="/teamwork/static/css/Login.css"> -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/Login.css" type="text/css">

<!-- javascript -->
<script type="text/javascript">
	/* $(document).ready(function () {
		//平台、设备和操作系统
	      var system = {
	          win: false,
	          mac: false,
	          xll: false
	      };
	      //检测平台
	      var p = navigator.platform;
	      system.win = p.indexOf("Win") == 0;
	      system.mac = p.indexOf("Mac") == 0;
	      system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);
	      //跳转语句
	      if (system.win || system.mac || system.xll) {//pc端 转向后台登陆页面
	    	 //如果是pc端,重新设置它的宽度
	      } else {
	        //window.location.href = "HomeIndex.aspx";//手机端页面
	      }
	}); */

	//判断是否是PC端
	/* function IsPC() {
	    var userAgentInfo = navigator.userAgent;
	    var Agents = ["Android", "iPhone","SymbianOS", "Windows Phone", "iPod"];
	    var flag = true;
	    for (var v = 0; v < Agents.length; v++) {
	        if (userAgentInfo.indexOf(Agents[v]) > 0) {
	            flag = false;
	            break;
	        }
	    }
	    if(window.screen.width>=768){
	         flag = true;
	    }
	    return flag;
	} */

	//登录ajax验证
	function login() {
		var job = $("[name=job]:checked").val();
		//alert("login : "+job);
		console.log("login : "+job);
		var urladd = "/teamwork";
		var pageurl = "";
		//取得登录名，登录密码
		var username = $("#username").val();
		var password = $("#password").val();
		//alert("username:" + username + "\npassword:" + password);
		console.log("username:" + username + "\npassword:" + password);
		//对登录名，登录密码简单判断，处理多种情况
		if (username == "") {
			alert("用户名不应为空");
		}
		if (password == "") {
			alert("登录密码不应为空");
		}
		if (username != "" && password != "") {
			//判断登录用户
			//if ($("#sexs").attr("checked") == "checked") {
			if( job == "Student") {
				//登录的是学生
				urladd = urladd + "/student/login";
				//验证成功跳转到学生界面
				pageurl = "/teamwork/jump/studentcourse"+"?username="+username;//+"&password="+password;
			} 
			//else if ($("#sext").attr("checked") == "checked") {
			else if ( job == "Teacher" ) {
				//登陆的是教师
				urladd = urladd + "/teacher/login";
				pageurl = "/teamwork/course/findbyteacherid"+"?username="+username;//+"&password="+password;
			}else {
				alert("丢失登录角色，请刷新页面重试");
			}
			//发送登录请求
			$.ajax({
				type : "POST",
				dataType : "Json",
				data : {
					"username" : username,
					"password" : password
				},
				url : urladd,
				success : function(data) {
					//请求成功code
					console.log("success" + data.toString());
					console.log(data);
					console.log(window.location.href);//当前地址
					console.log("session:"+<%=session.getAttribute("LOGIN")%>);
					//alert("success" + data.toString());
					if(data.code == "200" || data.type == 0){
					//验证成功，执行跳转
					window.location.href = pageurl;
					//window.location.href="/teamwork/jump/studentmain1"+"?username="+username+"&password="+password;
					}
					if (data.code =="100") {
						if (data.type == 1) {
							alert(data.info);
						}
						if (data.type == 2) {
							alert(data.info);
						}
					}
					
				},
				error : function(data) {
					//请求失败code
					alert("error:" + data);
					console.log("error:" + data);
				}
			})
		}
	}
	
	function reset() {
		alert("reset");
		$("#username").val("");
		$("#password").val("");
		//window.location.reload();
		console.log($("#sexs"));
	}
	
	//登录ajax验证
	function login1() {
		var job = $("[name=job]:checked").val();
		alert("login1: "+job);
		var urladd = "/teamwork";
		//取得登录名，登录密码
		var username = $("#username").val();
		var password = $("#password").val();
		//alert("username:" + username + "\npassword:" + password);
		console.log("username:" + username + "\npassword:" + password);
		//对登录名，登录密码简单判断，处理多种情况
		if (username == "") {
			alert("用户名不应为空");
		}
		if (password == "") {
			alert("登录密码不应为空");
		}
		if (username != "" && password != "") {
			//判断登录用户
			if ($("#sexs").attr("checked") == "checked") {
				//登录的是学生
				urladd = urladd + "/student/login1";
			} else if ($("#sext").attr("checked") == "checked") {
				//登陆的是教师
				urladd = urladd + "/teacher/login1";
			}
			window.location.href="/teamwork/student/login1"+"?username="+username+"&password="+password;
		}
	}
</script>

</head>
<body>

	<div class="Container">
		<div class="Login-container">
			<!-- 第一样式 -->
			<div class="Login-input">
				<div class="Login-input-left">username</div>
				<div class="Login-input-center">
					<input id="username" type="text" class="form-control" value="" placeholder="username" title="学号或工号">
				</div>
				<!-- <div class="Login-input-right">
					<input type="button" value="c">
				</div> -->
			</div>
			<div class="Login-input">
				<div class="Login-input-left">password</div>
				<div class="Login-input-center">
					<input id="password" type="password" class="form-control" value="" placeholder="password" title="初始密码是学号或工号">
				</div>
				<!-- <div class="Login-input-right">
					<input type="button" value="t">
				</div> -->
			</div>
			<div class="Login-chose-job">
				<div class="Login-chose-job-radio">
					<input id="sexs" type="radio" name="job" value="Student" checked="checked">学生
				</div>
				<div class="Login-chose-job-radio">
					<input id="sext" type="radio" name="job" value="Teacher">教师
				</div>
			</div>
			<div class="Login-button">
				<div class="Login-button-left">
					<input id="login" type="button" class="btn btn-default Login-button-login" onclick="login()" value="登录">
				</div>
				<div class="Login-button-right">
					<input id="login" type="button" class="btn btn-default Login-button-login" onclick="reset()" value="重置">
				</div>
			</div>
<!-- 		<br>
		<br>
		<br> -->
			<!-- 第二样式 -->
			<!-- 输入用户名 -->
			<!-- <div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label auto">username</label>
				<div class="col-sm-10">
					//<input type="text" class="form-control" placeholder="username">
					<input id="username1" type="text" class="form-control" value="" placeholder="username" title="学号或工号">
				</div>
			</div> -->
			<!-- 输入密码 -->
			<!-- <div class="form-group">
				<label for="inputPassword3" class="col-sm-2 control-label auto">Password</label>
				<div class="col-sm-10">
					//<input type="password" class="form-control" id="inputPassword3" placeholder="Password">
					<input id="password1" type="password" class="form-control" value="" placeholder="password" title="初始密码是学号或工号">
				</div>
			</div> -->
			<!-- 选择登录用户的身份 -->
			<!-- <div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<div class="checkbox">
						//<input type="checkbox"> Remember me	
						//<input id="sexs" type="radio" name="job" value="Student">学生
						<input id="sext" type="radio" name="job" value="Teacher">教师
						<div class="Login-chose-job">
							<div class="Login-chose-job-radio">
								<input id="sexs" type="radio" name="job" value="Student">学生
							</div>
							<div class="Login-chose-job-radio">
								<input id="sext" type="radio" name="job" value="Teacher">教师
							</div>
						</div>
					</div>
				</div>
			</div> -->
			<!-- 登录重置按钮 -->
			<%-- <div class="form-group">
				<div class="col-sm-offset-2 col-sm-10 Center-loginbutton">
					<!-- <button type="button" class="btn btn-default">Sign in</button> -->
					<input id="login" type="button" class="btn btn-default Login-button-login" onclick="login1()" value="登录">
					<input id="login" type="button" class="btn btn-default Login-button-login" onclick="reset()" value="重置">
				</div>
			</div> --%>
		</div>
		
		
		
		
		<!-- <div class="Header">
		</div>
		
		<div>
			<input id="username" type="text" value="" placeholder="username">
			<input id="password" type="password" value="" placeholder="password">
			<select id="select">
				<option value="学生" selected="selected">学生</option>
				<option value="教师">教师</option>
			</select>
			<input id="sexs" type="radio" value="学生" checked="checked">学生
			<input id="sext" type="radio" value="教师">教师 
			<input id="login" type="button" onclick="login()" value="登录">
		</div>
		<div>footer</div>
	</div> -->



</body>
</html>