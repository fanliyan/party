package cn.edu.ccu.data.system;


import cn.edu.ccu.model.system.ModuleGroupModel;
import cn.edu.ccu.data.PartyDB;

import java.util.List;

@PartyDB
public interface ModuleGroupModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ModuleGroupModel record);

    int insertSelective(ModuleGroupModel record);

    ModuleGroupModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ModuleGroupModel record);

    int updateByPrimaryKey(ModuleGroupModel record);

    List<ModuleGroupModel> list();
}