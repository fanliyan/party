package cn.edu.ccu.data.system;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.system.RUserRoleModel;
import cn.edu.ccu.model.system.RUserRoleModelKey;

import java.util.List;

@PartyDB
public interface RUserRoleModelMapper {
    int deleteByPrimaryKey(RUserRoleModelKey key);

    int insert(RUserRoleModel record);

    int insertSelective(RUserRoleModel record);

    RUserRoleModel selectByPrimaryKey(RUserRoleModelKey key);

    int updateByPrimaryKeySelective(RUserRoleModel record);

    int updateByPrimaryKey(RUserRoleModel record);

    List<RUserRoleModel> selectRolesByUserId(Integer userId);

    int deleteByUserId(Integer userId);

    List<Integer> selectUserIdByRole(Integer id);
}