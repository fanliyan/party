package cn.edu.ccu.data.common;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.common.NotificationModel;
import cn.edu.ccu.model.common.NotificationModelWithBLOBs;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@PartyDB
public interface NotificationModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(NotificationModelWithBLOBs record);

    int insertSelective(NotificationModelWithBLOBs record);

    NotificationModelWithBLOBs selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(NotificationModelWithBLOBs record);

    int updateByPrimaryKeyWithBLOBs(NotificationModelWithBLOBs record);

    int updateByPrimaryKey(NotificationModel record);


    NotificationModelWithBLOBs getByRoleAndDepartment(@Param("roleId")Integer roleId,@Param("departmentId") Integer departmentId);

    List<NotificationModelWithBLOBs> select(Integer id);
}