package cn.edu.ccu.data.system;


import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.system.ModuleModel;

import java.util.List;

@PartyDB
public interface ModuleModelMapper {
    int deleteByPrimaryKey(Integer moduleId);

    int insert(ModuleModel record);

    int insertSelective(ModuleModel record);

    ModuleModel selectByPrimaryKey(Integer moduleId);

    int updateByPrimaryKeySelective(ModuleModel record);

    int updateByPrimaryKey(ModuleModel record);

    List<ModuleModel> selectByUserId(Integer userid);

    List<ModuleModel> SelectByRoleId(Integer roleId);

    List<ModuleModel> list();
}