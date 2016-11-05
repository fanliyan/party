package cn.edu.ccu.data.exam;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.exam.QuestionModel;

import java.util.List;
import java.util.Map;

@PartyDB
public interface QuestionModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(QuestionModel record);

    int insertSelective(QuestionModel record);

    QuestionModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(QuestionModel record);

    int updateByPrimaryKeyWithBLOBs(QuestionModel record);

    int updateByPrimaryKey(QuestionModel record);


    List<QuestionModel> selectWithUser(Map map);

    List<QuestionModel> select(Map map);

    List<QuestionModel> search(Map map);

    int count(Map map);


    List<QuestionModel> selectByIds(List<Integer> list);

    List<QuestionModel> selectDetailByIds(List<Integer> list);

    QuestionModel selectByMap(Map map);


    //=================================
    //考试用
    //有正确答案
    List<QuestionModel> selectByIdsWithRightAnswer(List<Integer> list);

    public List selectAllQuestion(Integer type) throws Exception;

    public List seacherQuestionByQuestion(String question) throws Exception;
}