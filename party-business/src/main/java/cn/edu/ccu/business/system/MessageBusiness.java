package cn.edu.ccu.business.system;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.data.TransactionManagerName;
import cn.edu.ccu.data.message.MsgMessageModelMapper;
import cn.edu.ccu.ibusiness.system.IMessage;
import cn.edu.ccu.ibusiness.system.IUserRole;
import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.message.*;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class MessageBusiness implements IMessage {

    @Autowired
    private MsgMessageModelMapper msgMessageModelMapper;

    @Autowired
    private IUserRole iUserRole;


    /**
     * 获取站内消息详情
     */
    @Override
    public MSGMessageGetResponse msgGet(MSGMessageGetRequest request,
                                        RequestHead requestHead) throws Exception {

        String message = null;
        if (request.getMessageId() == null || request.getMessageId() <= 0) {
            message = "消息id必传";
        }
        if (!IntegerExtention.hasValueAndMaxZero(requestHead.getLoginUserId())) {
            message = "必须登录";
        }
        if (message != null) {
            throw new BusinessException(message);
        }

        MsgMessageModel messageModel = msgMessageModelMapper
                .selectByPrimaryKey(request.getMessageId());
        if (messageModel != null) {
            if (!messageModel.getReceiveUserid().equals(
                    requestHead.getLoginUserId().toString())) {
                messageModel = null;
            } else {
                // 获取消息详情 如果未读过则设置为已读
                if (!messageModel.getIsRead()) {
                    messageModel.setIsRead(true);
                    msgMessageModelMapper
                            .updateByPrimaryKeySelective(messageModel);
                }

            }
        }

        MSGMessageGetResponse response = new MSGMessageGetResponse();
        response.setMessage(messageModel);
        return response;
    }

    /**
     * 获取消息列表
     */
    @Override
    public MSGMessageListResponse msglist(MSGMessageListRequest request,
                                          RequestHead requestHead) throws BusinessException, Exception {

        if (!IntegerExtention.hasValueAndMaxZero(requestHead.getLoginUserId())) {
            throw new BusinessException("uid必须传");
        }
        MSGMessageListResponse response = new MSGMessageListResponse();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("receiveUserid", requestHead.getLoginUserId());
        UtilsBusiness.pubMapforSplitPage(request.getSplitPage(), map);
        if (request.getSplitPage() != null
                && request.getSplitPage().isReturnCount()) {

            int count = msgMessageModelMapper
                    .selectMessageListCount(requestHead.getLoginUserId());
            response.setSplitPage(UtilsBusiness.getSplitPageResponse(count,
                    request.getSplitPage().getPageSize(), request
                            .getSplitPage().getPageNo()));
        }
        List<MsgMessageModel> messages = msgMessageModelMapper
                .selectMessageList(map);

        if (messages != null && messages.size() > 0) {
            List<Integer> uids = new ArrayList<Integer>();


            for (MsgMessageModel m : messages) {
                String sendUid = m.getSendUserid();
                int uid = Integer.parseInt(sendUid);
                if (!uids.contains(uid)) {
                    uids.add(uid);
                }

            }
        }

        response.setMessages(messages);

        return response;
    }

//	@Override
//	public List<PushNotificationModel> listPushMessage() throws Exception {
//		return msgMessageModelMapper.listPushMessage();
//	}

    @Override
    public int addMessage(MsgMessageModel message) throws Exception {

        return msgMessageModelMapper.insert(message);
    }

    @Override
    @Transactional(TransactionManagerName.partyTransactionManager)
    public int addMessageToRole(MsgMessageModel message, Integer roleId) {

        List<Integer> ids = iUserRole.getUserIdByRole(roleId);

        if (ids != null && ids.size() > 0) {
            for (Integer id : ids) {
                message.setReceiveUserid(id.toString());
                msgMessageModelMapper.insert(message);
            }
        }

        return 1;
    }

    @Override
    public int getNotReadMessageCountByReceiveUserid(int receiveUserid) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("receiveUserid", receiveUserid);
        map.put("isRead", false);
        return msgMessageModelMapper.selectMessageCount(map);
    }

    @Override
    @Transactional
    public MsgMessageModel getMessageById(Long messageId) {
        MsgMessageModel messageModel = new MsgMessageModel();
        messageModel.setMessageId(messageId);
        messageModel.setIsRead(true);
        msgMessageModelMapper.updateByPrimaryKeySelective(messageModel);
        return msgMessageModelMapper.selectByPrimaryKey(messageId);
    }

    @Override
    public MSGMessageListResponse listMessages(MSGMessageListRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (request.getMessageModel() != null) {
            if (request.getMessageModel().getReceiveUserid() != null
                    && !"".equals(request.getMessageModel().getReceiveUserid())) {
                map.put("receiveUserid", request.getMessageModel()
                        .getReceiveUserid());
            }
            if (request.getMessageModel().getIsRead() != null) {
                map.put("isRead", request.getMessageModel().getIsRead());
            }
        }
        UtilsBusiness.pubMapforSplitPage(request.getSplitPage(), map);
        List<MsgMessageModel> messageModels = msgMessageModelMapper
                .selectMessageList(map);
        int rowCount = msgMessageModelMapper.selectMessageCount(map);
        MSGMessageListResponse response = new MSGMessageListResponse();
        response.setMessages(messageModels);
        response.setSplitPage(UtilsBusiness.getSplitPageResponse(rowCount,
                request.getSplitPage().getPageSize(), request.getSplitPage()
                        .getPageNo()));
        return response;
    }


}
