package cn.edu.ccu.ibusiness.exam;

import cn.edu.ccu.model.exam.QuestionListRequest;
import cn.edu.ccu.model.exam.QuestionListResponse;
import cn.edu.ccu.model.exam.QuestionModel;

import java.util.List;

/**
 * Created by kuangye on 2016/4/23.
 */
public interface IQuestion {

    QuestionListResponse splitByPage(QuestionListRequest questionListRequest);

    QuestionModel getById(Integer id);

    QuestionModel getByMap(QuestionModel questionModel);

    boolean addQuestion(QuestionModel questionModel, String[] answerNameArray, String[] rightAnswerArray);

    boolean updateQuestion(QuestionModel questionModel, String[] answerNameArray, String[] rightAnswerArray);

    boolean deleteQuestion(Integer id);


    List<QuestionModel> getByIds(List<Integer> ids, boolean getDetail);

    //根据 关键字+类型 搜索问题
    List<QuestionModel> searchQuestion(String text, Integer type);


    //考试用
    List<QuestionModel> getByIdsForExam(List<Integer> ids, boolean getRightAnswer);

}
