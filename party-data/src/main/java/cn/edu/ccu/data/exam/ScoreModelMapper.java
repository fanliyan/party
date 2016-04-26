package cn.edu.ccu.data.exam;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.exam.ScoreModel;

@PartyDB
public interface ScoreModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ScoreModel record);

    int insertSelective(ScoreModel record);

    ScoreModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ScoreModel record);

    int updateByPrimaryKeyWithBLOBs(ScoreModel record);

    int updateByPrimaryKey(ScoreModel record);
}