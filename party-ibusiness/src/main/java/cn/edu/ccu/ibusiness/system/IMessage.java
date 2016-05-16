package cn.edu.ccu.ibusiness.system;


import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.message.*;

import java.util.List;

/**
 * 
* @ClassName: IMessage 
* @Description: 站内消息业务处理
* @author yinqiang
* @date Jun 15, 2015 5:21:08 PM 
*
 */
public interface IMessage {

	/**
	 * 
	* @Title: msgGet 
	* @Description: 获取消息详情
	* @param request
	* @param requestHead
	* @return
	* @throws Exception
	* @author yinqiang
	* @throws
	 */
	public MSGMessageGetResponse msgGet(MSGMessageGetRequest request, RequestHead requestHead) throws Exception;
	/**
	 * 
	* @Title: msglist 
	* @Description: 获取消息列表
	* @param request
	* @param requestHead
	* @return
	* @throws BusinessException
	* @throws Exception
	* @author yinqiang
	* @throws
	 */
	MSGMessageListResponse msglist(MSGMessageListRequest request, RequestHead requestHead) throws BusinessException,Exception;
	
	/**
	 * 
	* @Title: listPushMessage 
	* @Description:  获取需要推送的消息
	* @return
	* @author yinqiang
	* @throws
	 */
//	List<PushNotificationModel> listPushMessage() throws Exception;
	/**
	 * 
	 * @Title: addMessage 
	 * @Description:  添加需要推送的消息
	 * @return
	 * @author yinqiang
	 * @throws
	 */
	int addMessage(MsgMessageModel message) throws Exception;

    int addMessageToRole(MsgMessageModel message, Integer roleId) ;
	
	int getNotReadMessageCountByReceiveUserid(int receiveUserid);
	
	MsgMessageModel getMessageById(Long messageId);
	
	MSGMessageListResponse listMessages(MSGMessageListRequest request);



}
