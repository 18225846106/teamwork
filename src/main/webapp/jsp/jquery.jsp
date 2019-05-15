<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jquery ajax</title>
<!-- 从百度引用jQuery jquery-2.0以上版本不再支持IE 6/7/8-->
<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
<!-- 引入bootstrap样式 -->
<link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>

<script type="text/javascript">
	function login() {
		alert("login");
		$.ajax({
			url:"/teamwork/testcontroller/test2",
			type:"PSOT",
			//dataType:"json",
			data:{id:"",password:""},
			success:function(data){
				alert("return data: "+data);
				var json1 = $.parseJSON(data);
				alert(json1);
				alert(json1.test);
				//var json2 = JSON.parse(data);
				//console.log(json2);
				//alert("1");
			},
			error:function(data){
				alert("error:"+data);
			}
		})
		
	}
	function login1() {
		alert("login1");
		$.ajax({
			url:"/teamwork/testcontroller/test2",
			type:"PSOT",
			dataType:"Json",
			data:{id:"",password:""},
			success:function(data){
				alert("return data: "+data);
				alert(data.test);
				$("#bbb").val(data.test);//修改id="bbb"的标签的value
			},
			error:function(data){
				alert("error:"+data);
			}
		})
	}
	function test3(){
		alert("test3");
		$.ajax({
			type:"POST",
			dataType:"Json",
			//data:{},
			url:"/teamwork/testcontroller/test3",
			success:function(data){
				alert("ruturn data: " + data);
				alert(data.teachers);
			},
			error:function(data){
				alert("error: "+ data);
			}
		})
	}
</script>

</head>
<body>
<p>点击登录</p>
<input type="button" onclick="login()" value="login"></input>
<p>dian dian point spot dot click</p>
<input type="button" onclick="login1()" value="login1">
<br>
<label id="aaa">aaa</label>
<br>
<input id="bbb" type="text" value="bbb">
<br>
<input type="button" onclick="test3()" value="test3">
</body>
</html>