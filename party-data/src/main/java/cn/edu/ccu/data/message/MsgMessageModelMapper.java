package cn.edu.ccu.data.message;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.message.MsgMessageModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@PartyDB
public interface MsgMessageModelMapper {
    int deleteByPrimaryKey(Long messageId);

    int insert(MsgMessageModel record);

    int insertSelective(MsgMessageModel record);

    MsgMessageModel selectByPrimaryKey(Long messageId);

    int updateByPrimaryKeySelective(MsgMessageModel record);

    int updateByPrimaryKeyWithBLOBs(MsgMessageModel record);

    int updateByPrimaryKey(MsgMessageModel record);
    
    public int selectMessageListCount(int receiveUserid);
    
    public int selectMessageCount(Map<String, Object> map);
    
    public List<MsgMessageModel> selectMessageList(Map<String, Object> map);
    
//    List<PushNotificationModel> listPushMessage();
    


}