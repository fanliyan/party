package cn.edu.ccu.manage.controller.system;
import cn.edu.ccu.ibusiness.system.IMessage;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.message.MSGMessageListRequest;
import cn.edu.ccu.model.message.MSGMessageListResponse;
import cn.edu.ccu.model.message.MsgMessageModel;
import cn.edu.ccu.model.user.UserModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/message")
@AuthController(moduleId = 14)
public class MessageController extends BaseController {
	
	@Autowired
	private IMessage iMessage;

	@RequestMapping("/notification")
	public  @ResponseBody
    Map<String, Object> notification(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {
		ModelAndView mav = Common.getLoginModelAndView(httpRequest);
		Map<String, Object> map=new HashMap<String, Object>();
		/**************************头部显示未读消息内容 ***********************************************/
		UserModel user=(UserModel)mav.getModel().get("loginUserModel");
		int messageCount=iMessage.getNotReadMessageCountByReceiveUserid(user.getUserId());
		MSGMessageListRequest request=new MSGMessageListRequest();
		MsgMessageModel messageModel=new MsgMessageModel();
		messageModel.setReceiveUserid(user.getUserId()+"");
		messageModel.setIsRead(false);
		SplitPageRequest pageRequest=new SplitPageRequest();
		pageRequest.setPageNo(1);
		pageRequest.setPageSize(5);
		request.setMessageModel(messageModel);
		request.setSplitPage(pageRequest);
		List<MsgMessageModel> messages=iMessage.listMessages(request)!=null?iMessage.listMessages(request).getMessages():null;
		/******************************************************************************/
		map.put("msgCount", messageCount);
		map.put("msgList", messages);
		return map;
	}
	
	
	@RequestMapping("/list")
	public ModelAndView msgList(HttpServletRequest httpRequest, HttpServletResponse httpResponse,MsgMessageModel messageModel,SplitPageRequest pageRequest) throws Exception {
		ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        UserModel user=(UserModel)mav.getModel().get("loginUserModel");
		MSGMessageListRequest request=new MSGMessageListRequest();
		messageModel.setReceiveUserid(user.getUserId()+"");
		pageRequest.setPageSize(20);
		if (pageRequest.getPageNo() < 1) {
			pageRequest.setPageNo(1);
		}
		request.setMessageModel(messageModel);
		request.setSplitPage(pageRequest);
		MSGMessageListResponse listResponse=iMessage.listMessages(request);
		
		mav.addObject("listResponse", listResponse);
		
		mav.setViewName("system/user/messageList");
		return mav;
	}
	@RequestMapping("/msgInfo")
	public ModelAndView msgInfo(HttpServletRequest httpRequest, HttpServletResponse httpResponse,Long messageId) throws Exception {
		ModelAndView mav = Common.getLoginModelAndView(httpRequest);
        UserModel user=(UserModel)mav.getModel().get("loginUserModel");
		MsgMessageModel message=iMessage.getMessageById(messageId);
		if(user.getUserId().intValue()!= Integer.parseInt(message.getReceiveUserid())){
			throw  new BusinessException("您没有查看此消息的权限");
		}
		
		mav.addObject("message", message);
		mav.setViewName("system/user/messageInfo");
		return mav;
	}
}
