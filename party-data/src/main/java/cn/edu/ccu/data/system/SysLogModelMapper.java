package cn.edu.ccu.data.system;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.system.SysLogModel;

import java.util.List;
import java.util.Map;

@PartyDB
public interface SysLogModelMapper {
    int deleteByPrimaryKey(Integer logId);

    int insert(SysLogModel record);

    int insertSelective(SysLogModel record);

    SysLogModel selectByPrimaryKey(Integer logId);

    int updateByPrimaryKeySelective(SysLogModel record);

    int updateByPrimaryKeyWithBLOBs(SysLogModel record);

    int updateByPrimaryKey(SysLogModel record);

    List<SysLogModel> selectByMap(Map<String, Object> map);

    int selectByCount(Map<String, Object> map);
}