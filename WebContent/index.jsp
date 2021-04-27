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
    <meta name="viewport"content="width=device-width, initial-scale=1">
    <meta charset="UTF-8">
    <meta name="keywords" content="javaWebsocket">
    <meta name="description" content="javaWebsocket">
    <link rel="stylesheet" href="css/iconfont.css">
    <link rel="stylesheet" href="css/chatRoom.css">
    <script src="assets/js/jquery.min.js"></script>
    <link href="assets/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" charset="utf-8" src="assets/umeditor/umeditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="assets/umeditor/umeditor.min.js"></script>
    
</head>
<body>
<div class="web03">
	<div id="windowBox">
		<!--左边列表-->
        <div class="user-list">
            <!--个人信息-->
            <div class="user-list-header">
                <div class="user-list-header-txt">
                    <!-- 用户名 -->
                    <p class="user-list-header-username">
                    	<%String username = request.getSession().getAttribute("username").toString();%>
						<%=username %>
                    </p>
                </div>
            </div>
            <div class="user-list-group">
                <div class="user-list-header user-list-item active-u-l">
                    <div class="user-list-header-avatar user-list-item-header-avatar">
                        <img src="assets/images/group.png" alt="">
                    </div>
                    <div class="user-list-header-txt">
                        <p class="user-list-header-nickname user-list-item-header-nickname">群聊</p>
                    </div>
                </div>
            </div>
        </div>
        <!--右边-->
        <div class="message-box">
            <div class="message-box-title" id="message-box-title-inline">群聊</div>
            <!--消息列表-->
           	<div id="ChatBox" class="message-box-content">
                <div class="load-message">聊天内容</div>
         		<div id="chatContent">
 					<div id="msgtmp" style="display:none;"> 
 						<div class="message-item-u">
			    			<div class="message-item-content">
			    				<div class="message-item-content-top">
			            			<div ff="msgdate" class="message-item-content-time">今天17:31</div>
			            			<div ff="username" class="message-item-content-username">用户名</div>
			            		</div>
			            		<div ff="content" id="content" class="message-item-content-bubble">此处是消息内容</div>
			        		</div>
			    		</div>
					</div>
				</div>
            </div>
    		<!-- 聊天内容发送区域 -->
			<div id="EditBox" class="message-box-system">
				<!--style给定宽度可以影响编辑器的最终宽度-->
				<script type="text/plain" id="myEditor" style="width:100%;height:90px;"></script>
 				<div class="message-box-system-message-send">
                    <button id="send" class="btn-send" onclick="send">发送</button>
           		</div> 
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">


$(function(){
	//实例化编辑器
	var um = UM.getEditor('myEditor',{
		autoHeightEnabled:false,
		toolbar:[
	        'emotion image'
	    ]
	});
    var username = "<%=username%>";
	var socket = new WebSocket("ws://${pageContext.request.getServerName()}:${pageContext.request.getServerPort()}${pageContext.request.contextPath}/websocket");
	//接收服务器的消息
    socket.onmessage=function(event){
    	var obj = eval(   '('+event.data+')'   );
    	addMessage(obj);
    }
    var unloadPageTip = function(){
    	   socket.close();
    	};
    window.onbeforeunload = unloadPageTip;
    
    
    $("#send").click(function(){
    	if (!um.hasContents()) {  // 判断消息输入框是否为空
            // 消息输入框获取焦点
            um.focus();
        } else {
        	//获取输入框的内容，并去除其中的<p>与</p>
        	var txt = um.getContent();
        	var txt1 = txt.replace("<p>","");
        	var txt2 = txt1.replace("</p>","");
        	//构建一个标准格式的JSON对象
        	var obj = JSON.stringify({
	    		username:username,
	    		content:txt2
	    	});
            // 发送消息
            socket.send(obj);
            // 清空消息输入框
            um.setContent('');
            // 消息输入框获取焦点
            um.focus();
        }
    });

});

//人名nickname，时间date，是否自己isSelf，内容content
function addMessage(msg){
	var box = $("#msgtmp").clone(); 	//复制一份模板，取名为box
	box.show();							//设置box状态为显示
	box.appendTo("#chatContent");		//把box追加到聊天面板中
	box.find('[ff="username"]').html(msg.username); //在box中设置昵称
	box.find('[ff="msgdate"]').html(msg.date); 		//在box中设置时间
	box.find('[ff="content"]').html(msg.content); 	//在box中设置内容
 	box.addClass(msg.isSelf? 'message-item right':'message-item left');	//右侧显示
 	//滚动条移动至最底部 
 	var roll = document.getElementsByClassName("message-box-content")[0];
 	roll.scrollTop = roll.scrollHeight;
	console.log("msg:"+msg.username+","+msg.isSelf+","+msg.content);
}


</script>
</body>
</html>
