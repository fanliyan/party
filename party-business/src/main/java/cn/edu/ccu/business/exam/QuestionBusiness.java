package cn.edu.ccu.business.exam;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.data.exam.QuestionModelMapper;
import cn.edu.ccu.ibusiness.exam.IQuestion;
import cn.edu.ccu.model.SplitPageResponse;
import cn.edu.ccu.model.exam.*;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.*;

/**
 * Created by kuangye on 2016/4/23.
 * <p>
 * 问题规则：
 * 答案 为json 字符串组成类型为 List<ChoiceModel>  choice 为键值对 name-value
 * 正确答案为该键值对 value 值
 * 多选则正确答案为List<value>
 * 判断如单选 list size 为 2
 */
@Service
public class QuestionBusiness implements IQuestion {


    @Autowired
    private QuestionModelMapper questionModelMapper;

    private static ObjectMapper objectMapper = new ObjectMapper();

    /**
     * 由于问题有三种类型
     * 列表仅展示问题名
     */

    public QuestionListResponse splitByPage(QuestionListRequest questionListRequest) {

        QuestionListResponse response = new QuestionListResponse();

        Map<String, Object> map = new HashMap<>();
        UtilsBusiness.pubMapforSplitPage(questionListRequest.getSplitPageRequest(), map);

        QuestionModel questionModel = questionListRequest.getQuestionModel();
        if (questionModel != null) {
            if (questionModel.getType() != null) {
                map.put("type", questionModel.getType());
            }
            if (questionModel.getStatus() != null) {
                map.put("status", questionModel.getStatus());
            }
            if (questionModel.getName() != null) {
                map.put("name", questionModel.getName());
            }
            if (questionModel.getCreateUser() != null) {
                map.put("userId", questionModel.getCreateUser());
            }
            if (questionModel.getWeight() != null) {
                map.put("weight", questionModel.getWeight());
            }
            if (questionModel.getRoleId() != null) {
                map.put("roleId", questionModel.getRoleId());
            }
            if (questionModel.getScore() != null) {
                map.put("score", questionModel.getScore());
            }
        }
        if (questionListRequest.isInTime()) {
            map.put("inTime", new Date());
        }

        List<QuestionModel> questionModelList;
        if (questionListRequest.isWithUserRole()) {
            questionModelList = questionModelMapper.selectWithUser(map);
        } else {
            questionModelList = questionModelMapper.select(map);
        }

        response.setQuestionModelList(questionModelList);

        if (questionListRequest.getSplitPageRequest() != null && questionListRequest.getSplitPageRequest().isReturnCount()) {
            int rowCount = questionModelMapper.count(map);

            SplitPageResponse pageResponse = UtilsBusiness.getSplitPageResponse(
                    rowCount, questionListRequest.getSplitPageRequest().getPageSize(), questionListRequest.getSplitPageRequest().getPageNo());
            response.setSplitPageResponse(pageResponse);
        }

        return response;
    }


    //根据不同类型 用json 转换
    public QuestionModel getById(Integer id) {

        if (IntegerExtention.hasValueAndMaxZero(id)) {

            QuestionModel questionModel = questionModelMapper.selectByPrimaryKey(id);
            this.changeJsonToList(questionModel);

            return questionModel;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


    //根据不同类型 用json 转换
    public QuestionModel getByMap(QuestionModel questionModel) {

        if (questionModel != null && IntegerExtention.hasValueAndMaxZero(questionModel.getId())) {

            Map<String, Object> map = new HashMap<>();
            map.put("id", questionModel.getId());
            if (questionModel.getStatus() != null)
                map.put("status", questionModel.getStatus());
            if (IntegerExtention.hasValueAndMaxZero(questionModel.getRoleId()))
                map.put("roleId", questionModel.getRoleId());

            QuestionModel model = questionModelMapper.selectByMap(map);
            this.changeJsonToList(model);

            return model;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean addQuestion(QuestionModel questionModel, String[] answerNameArray, String[] rightAnswerArray) {

        try {

            QuestionModel model = new QuestionModel();

            if (StringExtention.isTrimNullOrEmpty(questionModel.getName()))
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            if (StringExtention.isTrimNullOrEmpty(questionModel.getQuestion()))
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            if (!IntegerExtention.hasValueAndMaxZero(questionModel.getType()))
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            if (questionModel.getScore() < 0)
                throw new BusinessException(ErrorCodeEnum.requestParamError);

            if (!IntegerExtention.hasValueAndMaxZero(answerNameArray.length))
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            if (!IntegerExtention.hasValueAndMaxZero(rightAnswerArray.length))
                throw new BusinessException(ErrorCodeEnum.requestParamError);


            model.setName(questionModel.getName());
            model.setQuestion(questionModel.getQuestion());
            model.setType(questionModel.getType());
            model.setStatus(questionModel.getStatus());
            model.setCreateUser(questionModel.getCreateUser());
            model.setScore(questionModel.getScore());

            List<String> rightAnswerList = new ArrayList<>();

            List<Choice> choiceList = new ArrayList<>();

            int i = 1;
            String choiceListString, rightAnswerString = null;

            switch (questionModel.getType()) {
                //单选
                case QuestionType.SINGLE_CHOICE:
                    //每个选项加入 同时自定义value值
                    for (String name : answerNameArray) {
                        Choice choice = new Choice();
                        choice.setName(name);
                        choice.setValue(String.valueOf(i));
                        choiceList.add(choice);

                        //单项答案
                        if (name.equals(rightAnswerArray[0]))
                            rightAnswerString = String.valueOf(i);

                        i++;
                    }

                    choiceListString = objectMapper.writeValueAsString(choiceList);

                    model.setAnswers(choiceListString);
                    //单个正确答案
                    model.setRightAnswer(rightAnswerString);

                    break;

                //多选
                case QuestionType.MULTIPLE_CHOICE:

                    //每个选项加入 同时自定义value值
                    for (String name : answerNameArray) {
                        Choice choice = new Choice();
                        choice.setName(name);
                        choice.setValue(String.valueOf(i));

                        //同时加入正确答案 每个正确答案加入
                        for (String answer : rightAnswerArray) {
                            if (answer.equals(name)) {
                                rightAnswerList.add(String.valueOf(i));
                            }
                        }

                        choiceList.add(choice);
                        i++;
                    }

                    choiceListString = objectMapper.writeValueAsString(choiceList);
                    model.setAnswers(choiceListString);

                    //多个正确答案
                    rightAnswerString = objectMapper.writeValueAsString(rightAnswerList);
                    model.setRightAnswer(rightAnswerString);


                    break;

                //判断
                case QuestionType.TRUE_OR_FALSE:

                    //每个选项加入 同时自定义value值 只有两个
                    for (String name : answerNameArray) {
                        Choice choice = new Choice();
                        choice.setName(name);
                        choice.setValue(String.valueOf(i));

                        //同时加入正确答案 只有一个答案
                        if (name.equals(rightAnswerArray[0])) {
                            rightAnswerString = String.valueOf(i);
                        }

                        choiceList.add(choice);
                        i++;
                    }

                    choiceListString = objectMapper.writeValueAsString(choiceList);
                    model.setAnswers(choiceListString);

                    //单个正确答案
                    model.setRightAnswer(rightAnswerString);

                    break;
            }


            return questionModelMapper.insertSelective(model) > 0;

        } catch (Exception e) {
        }

        return false;
    }

    public boolean updateQuestion(QuestionModel questionModel, String[] answerNameArray, String[] rightAnswerArray) {
        try {

            if (questionModel != null && IntegerExtention.hasValueAndMaxZero(questionModel.getId())) {
                QuestionModel model = new QuestionModel();

                if (questionModel.getName() != null && StringExtention.isTrimNullOrEmpty(questionModel.getName()))
                    throw new BusinessException(ErrorCodeEnum.requestParamError);
                if (questionModel.getName() != null && StringExtention.isTrimNullOrEmpty(questionModel.getQuestion()))
                    throw new BusinessException(ErrorCodeEnum.requestParamError);
                if (!IntegerExtention.hasValueAndMaxZero(questionModel.getType()))
                    throw new BusinessException(ErrorCodeEnum.requestParamError);
                if (questionModel.getScore() != null && questionModel.getScore() < 0)
                    throw new BusinessException(ErrorCodeEnum.requestParamError);

                if (answerNameArray != null && answerNameArray.length == 0)
                    throw new BusinessException(ErrorCodeEnum.requestParamError);
                if (rightAnswerArray != null && rightAnswerArray.length == 0)
                    throw new BusinessException(ErrorCodeEnum.requestParamError);

                model.setId(questionModel.getId());
                model.setName(questionModel.getName());
                model.setQuestion(questionModel.getQuestion());
                model.setType(questionModel.getType());
                model.setStatus(questionModel.getStatus());
                model.setScore(questionModel.getScore());

                List<String> rightAnswerList = new ArrayList<>();

                List<Choice> choiceList = new ArrayList<>();

                int i = 1;
                String choiceListString, rightAnswerString = null;


                //TODO 以下代码似乎无这样写必要 如果 选项 答案 分开修改则需要修改
                switch (questionModel.getType()) {
                    //单选
                    case QuestionType.SINGLE_CHOICE:

                        if (answerNameArray != null && answerNameArray.length > 0) {
                            //每个选项加入 同时自定义value值
                            for (String name : answerNameArray) {
                                Choice choice = new Choice();
                                choice.setName(name);
                                choice.setValue(String.valueOf(i));
                                choiceList.add(choice);

                                if (rightAnswerArray != null && rightAnswerArray.length > 0) {
                                    //单项答案
                                    if (name.equals(rightAnswerArray[0])) {
                                        rightAnswerString = String.valueOf(i);
                                        //单个正确答案
                                        model.setRightAnswer(rightAnswerString);
                                    }
                                }

                                i++;
                            }

                            choiceListString = objectMapper.writeValueAsString(choiceList);

                            model.setAnswers(choiceListString);
                        }

                        break;

                    //多选
                    case QuestionType.MULTIPLE_CHOICE:

                        if (answerNameArray != null && answerNameArray.length > 0) {
                            //每个选项加入 同时自定义value值
                            for (String name : answerNameArray) {
                                Choice choice = new Choice();
                                choice.setName(name);
                                choice.setValue(String.valueOf(i));


                                if (rightAnswerArray != null && rightAnswerArray.length > 0) {
                                    //同时加入正确答案 每个正确答案加入
                                    for (String answer : rightAnswerArray) {
                                        if (answer.equals(name)) {
                                            rightAnswerList.add(String.valueOf(i));
                                        }
                                    }
                                }

                                choiceList.add(choice);
                                i++;
                            }

                            choiceListString = objectMapper.writeValueAsString(choiceList);
                            model.setAnswers(choiceListString);

                            if (rightAnswerArray != null && rightAnswerArray.length > 0) {
                                //多个正确答案
                                rightAnswerString = objectMapper.writeValueAsString(rightAnswerList);
                                model.setRightAnswer(rightAnswerString);
                            }
                        }
                        break;

                    //判断
                    case QuestionType.TRUE_OR_FALSE:

                        //每个选项加入 同时自定义value值 只有两个
                        for (String name : answerNameArray) {
                            Choice choice = new Choice();
                            choice.setName(name);
                            choice.setValue(String.valueOf(i));

                            //同时加入正确答案 只有一个答案
                            if (name.equals(rightAnswerArray[0])) {
                                rightAnswerString = String.valueOf(i);
                            }

                            choiceList.add(choice);
                            i++;
                        }

                        choiceListString = objectMapper.writeValueAsString(choiceList);
                        model.setAnswers(choiceListString);

                        //单个正确答案
                        model.setRightAnswer(rightAnswerString);

                        break;
                }


                return questionModelMapper.updateByPrimaryKeySelective(model) > 0;
            }
        } catch (Exception e) {
        }

        return false;
    }

    public boolean deleteQuestion(Integer id) {

        if (IntegerExtention.hasValueAndMaxZero(id)) {
            return questionModelMapper.deleteByPrimaryKey(id) > 0;
        }

        return false;
    }


    public List<QuestionModel> getByIds(List<Integer> ids, boolean getDetail) {

        if (ids == null || ids.size() == 0)
            throw new BusinessException(ErrorCodeEnum.requestParamError);

        List<QuestionModel> questionModelList;

        if (getDetail) {


            questionModelList = questionModelMapper.selectDetailByIds(ids);

            for (QuestionModel questionModel : questionModelList)
                this.changeJsonToList(questionModel);

            return questionModelList;

        } else {
            questionModelList = questionModelMapper.selectByIds(ids);

            return questionModelList;
        }

    }

    //根据不同类型 用json 转换 (默认返回正确答案
    private void changeJsonToList(QuestionModel questionModel) {
        this.changeJsonToList(questionModel, true);
    }


    //根据不同类型 用json 转换
    private void changeJsonToList(QuestionModel questionModel, boolean getRightAnswer) {
        try {
            if (questionModel != null) {

                //都得读
                List<Choice> choiceList = objectMapper.readValue(questionModel.getAnswers(),
                        new TypeReference<List<Choice>>() {
                        });


                List<String> rightAnswerList = new ArrayList<>();

                switch (questionModel.getType()) {
                    //单选
                    case QuestionType.SINGLE_CHOICE:

                        questionModel.setChoiceModelList(choiceList);

                        if (getRightAnswer) {
                            //单个正确答案
                            rightAnswerList.add(questionModel.getRightAnswer());
                        }

                        questionModel.setRightAnswerList(rightAnswerList);

                        return;

                        //多选
                    case QuestionType.MULTIPLE_CHOICE:

                        questionModel.setChoiceModelList(choiceList);

                        if (getRightAnswer) {
                            //多个正确答案
                            rightAnswerList = objectMapper.readValue(questionModel.getRightAnswer(),
                                    new TypeReference<List<String>>() {
                                    });
                            questionModel.setRightAnswerList(rightAnswerList);
                        }


                        return;

                        //判断
                    case QuestionType.TRUE_OR_FALSE:

                        questionModel.setChoiceModelList(choiceList);

                        if (getRightAnswer) {
                            //单个正确答案
                            rightAnswerList.add(questionModel.getRightAnswer());

                            questionModel.setRightAnswerList(rightAnswerList);
                        }

                        return;
                }
            }
        } catch (IOException e) {
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    //  通过 name 或 ID 或 题目 + 类型 查询
    public List<QuestionModel> searchQuestion(String text, Integer type) {

        if (StringExtention.isTrimNullOrEmpty(text) || !IntegerExtention.hasValueAndMaxZero(type))
            throw new BusinessException(ErrorCodeEnum.requestParamError);

        Map<String, Object> map = new HashMap<>();
        map.put("text", text);
        map.put("type", type);
        return questionModelMapper.select(map);
    }


    public List<QuestionModel> getByIdsForExam(List<Integer> ids, boolean getRightAnswer) {

        if (ids != null && ids.size() > 0) {
            List<QuestionModel> questionModelList = questionModelMapper.selectByIdsWithRightAnswer(ids);

            for (QuestionModel questionModel : questionModelList)
                this.changeJsonToList(questionModel, getRightAnswer);

            return questionModelList;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }
}
