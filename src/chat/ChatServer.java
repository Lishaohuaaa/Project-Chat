package chat;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Vector;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import net.sf.json.JSONObject;


@ServerEndpoint("/websocket")
public class ChatServer {

	private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private static Vector<Session> room = new Vector<Session>();
	
	/**
	 * 用户接入
	 * @param session 可选
	 */
	@OnOpen
	public void onOpen(Session session){
		room.addElement(session);
		System.out.println("用户接入"+session.getId());
		System.out.println("建立Socket链接"+session.getId());
		Connect();
	}

	public void Connect() {
	}
	
	@OnMessage
	public void onMessage(String message,Session session){
		//把用户发来的消息解析为JSON对象
		JSONObject obj = JSONObject.fromObject(message);
		System.out.println(message);
		//向JSON对象中添加发送时间
		obj.put("date", df.format(new Date()));
		//遍历聊天室中的所有会话
		for(Session se : room){
			//设置消息是否为自己的
			obj.put("isSelf", se.equals(session));
			//发送消息给远程用户
				se.getAsyncRemote().sendText(obj.toString());
				
				System.out.println("发送["+obj.toString()+"]成功");
			}
		
}
	
	/**
	 * 用户断开
	 * @param session
	 */
	@OnClose
	public void onClose(Session session){
		room.remove(session);
		System.out.println("用户断开");
		System.out.println("Socket链接"+session.getId()+"断开");
	}
	
	/**
	 * 用户连接异常
	 * @param t
	 */
	@OnError
	public void onError(Throwable t){
		
	}
}