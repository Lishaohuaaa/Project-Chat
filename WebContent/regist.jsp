<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="shortcut icon" href="assets/images/favicon.png" type="image/x-icon" />
    <title>聊天室</title>
    <meta name="keywords" content="javaWebsocket">
    <meta name="description" content="javaWebsocket">
    <link rel="stylesheet" href="css/iconfont.css">
    <link rel="stylesheet" href="css/chatRoom.css">
    <script src="assets/js/jquery.min.js"></script>
</head>
<body>

<script type="text/javascript">

function registerFn(){//点击提交按钮，触发函数

	var username = document.getElementById("username").value;
	var password = document.getElementById("password").value;

	if (!/^[\u4e00-\u9fa5_a-zA-Z0-9_]{3,16}$/.test(username) || !/^[a-zA-Z0-9]{3,16}$/.test(password)) {
		alert("用户名和密码在3到16位之间！");
		return false;
	}
/* 	if (!/^[a-zA-Z0-9]{4,16}$/.test(password)) {
		alert("密码4到16位之间！");
		return false;
	} */
	
	$.post(                   //post，比get的好处就不多说了   
	    "registServlet",           //提交的servlet   
	    {  
	      	username:username,  //获取输入框中的数据   
	      	password:password  
	    },  
	    function(data,status){   //获得servlet返回的数据，如何返回，在serlvet中会详写      
	    	console.log(data);
	    	switch (data) {
            case "1": 
                alert("注册成功");
                window.location.href="login.jsp";
                break;
            case "2":
                alert("用户名已存在");
                break;
        }
	});  
};

function login(){
	window.location.href="login.jsp";
}
document.onkeydown =keyEnter;
function keyEnter() {
    if(window.event.keyCode == 13) {
    	registerFn();
    }
}

</script>

<div class="web03">

    <!--注册-->
    <div class="login-view login-box">
        <h3>注册聊天室</h3>
        	<div class="form-item">
            	<div>账号</div>
            	<div><input type="text" placeholder="登陆账号" name="username" id="username""></div>
        	</div>
        	<div class="form-item">
            	<div>密码</div>
            	<div><input type="password" placeholder="登陆密码" name="password" id="password"></div>
        	</div>
        	<div class="login-btn-view">
            	<button class="login-btn" onclick="registerFn()">注册</button>
            	<button class="login-btn login-btn-c" onclick="login()">登入</button>
            </div>
	</div>
</div>


</body>
</html>
