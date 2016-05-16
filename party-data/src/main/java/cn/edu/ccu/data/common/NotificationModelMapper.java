package cn.edu.ccu.data.common;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.common.NotificationModel;

import java.util.List;

@PartyDB
public interface NotificationModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(NotificationModel record);

    int insertSelective(NotificationModel record);

    NotificationModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(NotificationModel record);

    int updateByPrimaryKeyWithBLOBs(NotificationModel record);

    int updateByPrimaryKey(NotificationModel record);

    NotificationModel getByRoleId(Integer roleId);

    List<NotificationModel> select();

}