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


function loginIn(){//点击提交按钮，触发函数
	var username = document.getElementById("username").value;
	var password = document.getElementById("password").value;

	$.post(                   //post
	    "loginServlet",           //提交的servlet   
	    {  
	      	username:username,  //获取输入框中的数据   
	      	password:password  
	    }, 
	    function(data,status){   //获得servlet返回的数据，如何返回，在serlvet中会详写      
	    	console.log(data);
	    	switch (data) {
            case "1":
                alert("登录成功");
                window.location.href="index.jsp";
                break;
            case "2":
                alert("用户名或密码错误");
                break;
        }
	});  
};

function regist(){
	window.location.href="regist.jsp";
	}


document.onkeydown =keyEnter;
function keyEnter() {
    if(window.event.keyCode == 13) {
    	loginIn();
    }
}
</script>

<div class="web03">
	<!--登陆-->
	<div class="login-view login-box">
		<h3>登陆聊天室</h3>
        	<div class="form-item">
            	<div>账号</div>
            	<div><input type="text" placeholder="登陆账号" name="username" id="username"></div>
        	</div>
        	<div class="form-item">
           		<div>密码</div>
           	 	<div><input type="password" placeholder="登陆密码" name="password" id="password"></div>
        	</div>
        	<div class="login-btn-view">
           	 	<button class="login-btn" onclick="loginIn()">登录</button> 
            	<button class="login-btn login-btn-c" onclick="regist()">注册</button> 
           	</div>
    </div>
</div>
</body>
</html>


