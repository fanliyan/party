package cn.edu.ccu.data.student;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.student.StuLogModel;

import java.util.List;
import java.util.Map;

@PartyDB
public interface StuLogModelMapper {
    int deleteByPrimaryKey(Integer logId);

    int insert(StuLogModel record);

    int insertSelective(StuLogModel record);

    StuLogModel selectByPrimaryKey(Integer logId);

    int updateByPrimaryKeySelective(StuLogModel record);

    int updateByPrimaryKeyWithBLOBs(StuLogModel record);

    int updateByPrimaryKey(StuLogModel record);

    List<StuLogModel> selectByMap(Map<String, Object> map);

    int selectByCount(Map<String, Object> map);

}