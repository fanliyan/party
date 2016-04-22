package cn.edu.ccu.school.controller.websocket;

import cn.edu.ccu.ibusiness.course.IStudy;
import cn.edu.ccu.model.study.StudyLogModel;
import cn.edu.ccu.model.study.VideoStudyRequestCode;
import cn.edu.ccu.model.study.VideoStudyWSRequest;
import cn.edu.ccu.model.study.VideoStudyWSResponse;
import cn.edu.ccu.utils.common.LogHelper;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.socket.server.standard.SpringConfigurator;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by kuangye on 2016/4/20.
 */

@ServerEndpoint(value = "/study/websocket", configurator = SpringConfigurator.class)
public class CourseStudyWebSocketHandler {


    //当前在线人数session列表(循环发消息用)
    private static Map<String, Session> sessionList = new ConcurrentHashMap<>();

    private final IStudy iStudy;

    private static ObjectMapper mapper = new ObjectMapper();

    @Autowired
    public CourseStudyWebSocketHandler(IStudy iStudy) {
        this.iStudy = iStudy;
    }

    /**
     * 建立连接
     */
    @OnOpen
    public void onOpen(Session session) {
        try {
            //1：有连接建立就检查是否有session失效
            removeSession();
            //添加在线人数列表
            sessionList.put(session.getId(), session);

            System.out.println("=========================="+session.getId()+"===start=========");

        } catch (Exception e) {
            LogHelper.Error("======>>websocket onOpen 业务处理error::" + e.getMessage());
        }
    }

    /**
     * 连接关闭
     */
    @OnClose
    public void onClose(Session session) {
        try {
            sessionList.remove(session.getId());
            iStudy.removeOnlineList(session.getId());


            System.out.println("=========================="+session.getId()+"===end=========");

        } catch (Exception e) {
            LogHelper.Error("======>>websocket onClose 业务处理error::" + e.getMessage());
        }
    }

    /**
     * 收到客户端消息后调用的方法
     *
     * @param message 客户端发送过来的消息
     * @param session 可选的参数
     */
    @OnMessage
    public void onMessage(String message, Session session) {
        try {
            //1：每次进入先移除失效的session
            removeSession();
            //2：参数处理
            VideoStudyWSRequest request = reqJsonParam2Object(message);
            if (null == request) return;

            //3: 心跳消息检测
            if (VideoStudyRequestCode.PING_PONG.equals(request.getCode())) {
                processPingPong(message, session, request);
                return;
            }

            //4：用户进入逻辑处理 (会发一条空消息
            if (StringUtils.isEmpty(request.getMessage())) {
                //4-1：建立session和用户的关系
                this.setOnlineList(session, request);
                //4-2：给所有在线用户推送在线人数消息
                this.pushOnlineUserCount(message);
            }


            //5:消息推送内部业务逻辑处理
            boolean returnFlag = this.processBusiness(message, session, request);
            if (returnFlag) return;

//            6：给当前所有在线人员推送消息
//            pushAllUserMessage(message,request);

        } catch (Exception e) {
            LogHelper.Error("======>>websocket onMessage 业务处理error::" + e.getMessage());
        }
    }

    /**
     * 发生错误时调用
     *
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error) {
        //logger.error("======>>websocket的onError被调用，sessionid="+session.getId());
        //error.printStackTrace();
    }


    /**
     * 移除失效session
     **/
    private void removeSession() {
        for (Map.Entry<String, Session> entry : sessionList.entrySet()) {
            Session usersession = entry.getValue();
            if (usersession == null || !usersession.isOpen()) {
                sessionList.remove(entry.getKey());
                iStudy.removeOnlineList(usersession.getId());
            }
        }
    }

    /**
     * 入参处理
     **/
    private VideoStudyWSRequest reqJsonParam2Object(String param) {
        VideoStudyWSRequest request = null;
        if (StringUtils.isEmpty(param)) {
            LogHelper.Error("======>>聊天发送参数为空");
            return null;
        }
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            request = objectMapper.readValue(param, VideoStudyWSRequest.class);
        } catch (Exception e) {
            LogHelper.Error("======>>聊天发送参数json转换对象出错,参数为：" + param);
            e.printStackTrace();
        }
        return request;
    }


    /**
     * json串添加元素
     **/
    private String addJsonElement(String sourceStr, String newStr) {
        StringBuilder jsonStr = new StringBuilder(sourceStr);
        jsonStr.delete(sourceStr.length() - 1, sourceStr.length());
        jsonStr.append(",").append(newStr).append("}");
        return jsonStr.toString();
    }

    /**
     * 关联session和用户
     **/
    private synchronized void setOnlineList(Session session, VideoStudyWSRequest request) {
        //过滤（解决同一个用户开多个页面可以产生多个session问题） 删除老的
        List<StudyLogModel> onlineList = iStudy.getOnlineList();
        if (!CollectionUtils.isEmpty(onlineList)) {
            Iterator<StudyLogModel> iter = onlineList.iterator();
            while (iter.hasNext()) {
                StudyLogModel record = iter.next();
                if (record.getUserId().equals(request.getUserId())) {
                    sessionList.remove(session.getId());
                    iStudy.removeOnlineList(record.getSessionId());
                }
            }
        }

        StudyLogModel studyLogModel = new StudyLogModel();
        studyLogModel.setUserId(request.getUserId());
        studyLogModel.setCourseId(request.getCourseId());
        studyLogModel.setWareId(request.getWareId());
        studyLogModel.setSessionId(session.getId());

        //插入
        iStudy.addOnlineList(studyLogModel);
    }

    /**
     * 推送在线人数
     **/
    private void pushOnlineUserCount(String message) {
        for (Map.Entry<String, Session> entry : sessionList.entrySet()) {
            Session usersession = entry.getValue();
            if (usersession != null && usersession.isOpen()) {
                try {
                    StringBuilder str = new StringBuilder();
                    str.append("\"content\":\"" + iStudy.getOnlineCount() + "\",\"code\":\"1\"");
                    String jsonStr = addJsonElement(message, str.toString());
                    usersession.getBasicRemote().sendText(jsonStr);
                } catch (Exception e) {
                    LogHelper.Error("======>>空消息人数发送异常，sessionid=" + usersession.getId());
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * 消息推送内部业务逻辑处理(入参校验等)
     **/
    private boolean processBusiness(String message, Session session, VideoStudyWSRequest request) {
        boolean returnFlag = false;
        try {

            //检查
            this.checkStatus(session,request);

            VideoStudyWSResponse resp = iStudy.pushContent(request);

            if (resp.getCode() > 0) {
                StringBuilder str = new StringBuilder();
                str.append("\"code\":\"" + resp.getCode() + "\",\"message\": \"" + resp.getMessage() + "\"");
                String jsonStr = addJsonElement(message, str.toString());
                session.getBasicRemote().sendText(jsonStr);
                returnFlag = true;
            }

        } catch (Exception e1) {
            LogHelper.Error("======>>消息推送业务处理异常");
            e1.printStackTrace();
            returnFlag = true;
        }
        return returnFlag;
    }

    /**
     * 心跳检测
     * [同时监听在线状态]
     **/
    private void processPingPong(String message, Session session, VideoStudyWSRequest request) {
        try {

            //在线状态监测
            this.checkStatus(session, request);

            StringBuilder str = new StringBuilder();
            str.append("\"code\":\"1\",\"message\": \"" + "" + "\"");
            String jsonStr = addJsonElement(message, str.toString());
            session.getBasicRemote().sendText(jsonStr);
        } catch (Exception e1) {
            LogHelper.Error("======>>PingPong心跳检测消息推送异常");
            e1.printStackTrace();
        }
    }

    //(需要确保你在看
    private void checkStatus(Session session, VideoStudyWSRequest request) {

        try {

            boolean tag = false;

            if (IntegerExtention.hasValueAndMaxZero(request.getUserId())
                    && IntegerExtention.hasValueAndMaxZero(request.getCourseId())
                    && IntegerExtention.hasValueAndMaxZero(request.getWareId())
                    && !StringExtention.isTrimNullOrEmpty(request.getDuration())
                    && !StringExtention.isTrimNullOrEmpty(request.getTimestamp())

                    && IntegerExtention.hasValueAndMaxZero(request.getCode())
                    && !StringExtention.isTrimNullOrEmpty(request.getHashcode())) {

                //code 一致
                String hashcode = request.getHashcode();
                String code = iStudy.getHashCode(request.getUserId(), request.getCourseId(), request.getWareId());
                if (!hashcode.equals(code)) {
                    tag = true;
                }

                //时间不超过 3 second
                long systemTime = System.currentTimeMillis();
                Long requestTime = Long.parseLong(request.getTimestamp());
                if (Math.abs(systemTime - requestTime) / (1000) > 3) {
                    tag = true;
                }

            } else {
                tag = true;
            }

            if (tag) {
                StringBuilder str = new StringBuilder();
                str.append("{\"code\":\"-1\",\"message\": \"" + "操作异常" + "\"}");
                session.getBasicRemote().sendText(str.toString());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     * 给当前所有在线人员推送消息
     **/
//    private void pushAllUserMessage(String message, ChatPushContentRequest request) {
//        //语音处理，如果是语音要把原内容地址替换为上传音频文件的存放地址
//        if ("1".equals(request.getContentType())) {
//            try {
//                JsonNode node = mapper.readTree(message);
//                JsonNode content = node.get("content");
//                message = message.replace(content.asText(), request.getContent());
//            } catch (Exception e1) {
//                message = message.replace("", request.getContent());//有异常替换成空，保障前台业务正常
//                LogHelper.Error("======>>给所有在线聊天人员发送消息json转换异常， message=:" + message);
//            }
//        }
//        //数据处理
//        StringBuilder str = new StringBuilder();
//        str.append("\"chatContentSeq\":\"" + request.getChatContentSeq() + "\",\"messageType\":\"" + ChatMessageType.CHAT_MESSAGE + "\",\"resultCode\":\"1\",\"resultMessage\": \"" + "" + "\"");
//        //str.append("\"resultCode\":\"1\",\"resultMessage\": \"" +""+"\"");
//
//        String jsonStr = addJsonElement(message, str.toString());
//
//        for (Map.Entry<String, Session> entry : sessionList.entrySet()) {
//            Session usersession = entry.getValue();
//            if (usersession != null && usersession.isOpen()) {
//                try {
//                    usersession.getBasicRemote().sendText(jsonStr);
//                } catch (Exception e) {
//                    LogHelper.Error("======>>发送聊天信息异常，sessionid= " + usersession.getId() + " message=:" + message);
//                }
//            }
//        }
//    }

    /**
     * 给当前所有在线人员推送回复消息
     **/
//    private void pushReplyMessage(String message, ChatPushContentRequest request) {
//        //1：获取原消息id
//        Integer contentSeq = null;
//        ChatLecture chatContent = null;
//        try {
//            ChatPushContentRequest msgReq = mapper.readValue(message, ChatPushContentRequest.class);
//            contentSeq = msgReq.getChatContentSeq();
//            //由消息id获取原消息内容
//            chatContent = iChatLecture.getChatContentBySeq(contentSeq);
//            msgReq.setChatContentSeq(request.getChatContentSeq());
//            msgReq.setMessageType(ChatMessageType.CHAT_MESSAGE);
//            message = mapper.writeValueAsString(msgReq);
//        } catch (Exception e1) {
//            LogHelper.Error("======>>给所有在线聊天人员发送回复消息json转换异常， message=:" + message);
//        }
//        ;
//        StringBuilder str = new StringBuilder();
//        str.append("\"resultCode\":\"1\",\"resultMessage\": \"" + "" + "\"");
//
//        //2：处理返回消息
//        if (null != chatContent) {
//            StringBuilder oldContent = new StringBuilder();
//            oldContent.append("{");
//            oldContent.append("\"participantId\":\"" + chatContent.getParticipantId() + "\",\"content\": \"" + chatContent.getContent() + "\"");
//            oldContent.append("}");
//            str.append(",\"oldContent\": " + oldContent.toString() + "");
//        }
//        String jsonStr = addJsonElement(message, str.toString());
//        //3：发送回复消息
//        for (Map.Entry<String, Session> entry : sessionList.entrySet()) {
//            Session usersession = entry.getValue();
//            if (usersession != null && usersession.isOpen()) {
//                try {
//                    usersession.getBasicRemote().sendText(jsonStr);
//                } catch (Exception e) {
//                    LogHelper.Error("======>>发送聊天信息异常，sessionid= " + usersession.getId() + " message=:" + message);
//                }
//            }
//        }
//    }


}
