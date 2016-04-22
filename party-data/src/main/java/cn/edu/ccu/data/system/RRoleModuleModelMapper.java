package cn.edu.ccu.data.system;


import cn.edu.ccu.model.system.RRoleModuleModel;
import cn.edu.ccu.model.system.RRoleModuleModelKey;
import cn.edu.ccu.data.PartyDB;

import java.util.List;

@PartyDB
public interface RRoleModuleModelMapper {
    int deleteByPrimaryKey(RRoleModuleModelKey key);

    int insert(RRoleModuleModel record);

    int insertSelective(RRoleModuleModel record);

    RRoleModuleModel selectByPrimaryKey(RRoleModuleModelKey key);

    int updateByPrimaryKeySelective(RRoleModuleModel record);

    int updateByPrimaryKey(RRoleModuleModel record);

    int deleteByRoleId(int roleId);

    List<RRoleModuleModel> selectByUserId(int userId);

    List<RRoleModuleModel> selectByRoleId(int roleId);
}