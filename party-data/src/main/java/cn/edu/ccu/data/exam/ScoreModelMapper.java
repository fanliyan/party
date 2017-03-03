package cn.edu.ccu.data.exam;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.exam.ScoreModel;

import java.util.List;
import java.util.Map;

@PartyDB
public interface ScoreModelMapper {
    String deleteByPrimaryKey(String id);

    int insert(ScoreModel record);

    int insertSelective(ScoreModel record);

    ScoreModel selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(ScoreModel record);

    int updateByPrimaryKeyWithBLOBs(ScoreModel record);

    int updateByPrimaryKey(ScoreModel record);

    //检查已考试次数
    int checkIsTested(Map map);

    ScoreModel getLastestExam(Map map);


    List<ScoreModel> select(Map map);

    int count(Map map);

    int deleteByExamId(int id) throws Exception;
}