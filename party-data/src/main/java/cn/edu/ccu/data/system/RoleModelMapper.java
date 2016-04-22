package cn.edu.ccu.data.system;


import cn.edu.ccu.model.system.RoleModel;
import cn.edu.ccu.data.PartyDB;

import java.util.List;

@PartyDB
public interface RoleModelMapper {
    int deleteByPrimaryKey(Integer roleId);

    int insert(RoleModel record);

    int insertSelective(RoleModel record);

    RoleModel selectByPrimaryKey(Integer roleId);

    int updateByPrimaryKeySelective(RoleModel record);

    int updateByPrimaryKey(RoleModel record);



    List<RoleModel> selectRolesDetailByUserId(Integer userId);

    List<RoleModel> selectRolesByUserId(Integer userId);

    List<RoleModel> list();

    List<RoleModel> selectByRoleName(String name);
}