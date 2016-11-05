package cn.edu.ccu.business.exam;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.data.exam.ExamModelMapper;
import cn.edu.ccu.data.exam.QuestionModelMapper;
import cn.edu.ccu.ibusiness.exam.IExam;
import cn.edu.ccu.ibusiness.exam.IQuestion;
import cn.edu.ccu.ibusiness.exam.IScore;
import cn.edu.ccu.model.SplitPageResponse;
import cn.edu.ccu.model.exam.*;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import cn.edu.ccu.utils.common.web.HttpRequestHelper;
import cn.edu.ccu.utils.common.web.RequestParamHelper;
import cn.edu.ccu.utils.common.web.WebHelper;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by kuangye on 2016/4/25.
 */
@Service
public class ExamBusiness implements IExam {

    @Autowired
    IQuestion iQuestion;
    @Autowired
    IScore iScore;

    @Autowired
    private ExamModelMapper examModelMapper;
    @Autowired
    private QuestionModelMapper questionModelMapper;


    private static ObjectMapper objectMapper = new ObjectMapper();

// 本来准备加密 后来觉得没必要
//    private static final String examKey = "&|^exam@";


    public ExamListResponse splitByPage(ExamListRequest examListRequest) {

        ExamListResponse response = new ExamListResponse();

        Map<String, Object> map = new HashMap<>();
        UtilsBusiness.pubMapforSplitPage(examListRequest.getSplitPageRequest(), map);

        ExamModel examModel = examListRequest.getExamModel();
        if (examModel != null) {
            if (examModel.getStatus() != null) {
                map.put("status", examModel.getStatus());
            }
            if (examModel.getName() != null) {
                map.put("name", examModel.getName());
            }
            if (examModel.getType() != null) {
                map.put("type", examModel.getType());
            }
            if (examModel.getCreateUser() != null) {
                map.put("userId", examModel.getCreateUser());
            }
            if (examModel.getRoleId() != null) {
                map.put("roleId", examModel.getRoleId());
            }
            if (examModel.getScore() != null) {
                map.put("score", examModel.getScore());
            }

            if (examModel.getStartTime() != null) {
                map.put("startTime", examModel.getStartTime());
            }
            if (examModel.getEndTime() != null) {
                map.put("endTime", examModel.getEndTime());
            }
        }
        if (examListRequest.isInTime()) {
            map.put("inTime", new Date());
        }

        List<ExamModel> examModelList;
        if (examListRequest.isWithUser()) {
            examModelList = examModelMapper.selectWithUser(map);
        } else {
            examModelList = examModelMapper.select(map);
        }

        response.setExamModelList(examModelList);

        if (examListRequest.getSplitPageRequest() != null && examListRequest.getSplitPageRequest().isReturnCount()) {
            int rowCount = examModelMapper.count(map);

            SplitPageResponse pageResponse = UtilsBusiness.getSplitPageResponse(
                    rowCount, examListRequest.getSplitPageRequest().getPageSize(), examListRequest.getSplitPageRequest().getPageNo());
            response.setSplitPageResponse(pageResponse);
        }

        return response;

    }

    //查询详情 包括 各种题目 + 题目数 等等 (不包括答案 正确答案)
    public ExamModelWithBLOBs getById(Integer id) {

        if (IntegerExtention.hasValueAndMaxZero(id)) {

            ExamModelWithBLOBs examModelWithBLOBs = examModelMapper.selectByPrimaryKey(id);

            String singleChoiceString = examModelWithBLOBs.getSingleChoice();

            String multipleChoiceString = examModelWithBLOBs.getMultipleChoice();

            String tofString = examModelWithBLOBs.getTof();

            if (!StringExtention.isTrimNullOrEmpty(singleChoiceString)) {
                List<QuestionModel> singleChoiceList = iQuestion.getByIds(this.stringToList(singleChoiceString), false);

                examModelWithBLOBs.setSingleChoiceList(singleChoiceList);
            }
            if (!StringExtention.isTrimNullOrEmpty(multipleChoiceString)) {
                List<QuestionModel> multipleChoiceList = iQuestion.getByIds(this.stringToList(multipleChoiceString), false);

                examModelWithBLOBs.setMultipleChoiceList(multipleChoiceList);
            }
            if (!StringExtention.isTrimNullOrEmpty(tofString)) {
                List<QuestionModel> tofList = iQuestion.getByIds(this.stringToList(tofString), false);

                examModelWithBLOBs.setTofList(tofList);
            }

            return examModelWithBLOBs;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    //查询详情 包括 各种题目 + 题目数 等等
    public ExamModelWithBLOBs getDetailById(Integer id) {

        if (IntegerExtention.hasValueAndMaxZero(id)) {

            ExamModelWithBLOBs examModelWithBLOBs = examModelMapper.selectByPrimaryKey(id);

            String singleChoiceString = examModelWithBLOBs.getSingleChoice();

            String multipleChoiceString = examModelWithBLOBs.getMultipleChoice();

            String tofString = examModelWithBLOBs.getTof();

            if (StringExtention.isTrimNullOrEmpty(singleChoiceString)) {
                List<QuestionModel> singleChoiceList = iQuestion.getByIds(this.stringToList(singleChoiceString), true);

                examModelWithBLOBs.setSingleChoiceList(singleChoiceList);
            }
            if (StringExtention.isTrimNullOrEmpty(multipleChoiceString)) {
                List<QuestionModel> multipleChoiceList = iQuestion.getByIds(this.stringToList(multipleChoiceString), true);

                examModelWithBLOBs.setMultipleChoiceList(multipleChoiceList);
            }
            if (StringExtention.isTrimNullOrEmpty(tofString)) {
                List<QuestionModel> tofList = iQuestion.getByIds(this.stringToList(tofString), true);

                examModelWithBLOBs.setTofList(tofList);
            }

            return examModelWithBLOBs;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


    public boolean addExam(ExamModelWithBLOBs examModelWithBLOBs,
                           String[] singleChoiceArray, String[] multipleChoiceArray, String[] tofArray) {

        if (examModelWithBLOBs != null) {

            if ((singleChoiceArray == null || singleChoiceArray.length == 0)
                    && (multipleChoiceArray == null || multipleChoiceArray.length == 0)
                    && (tofArray == null || tofArray.length == 0)) {
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            }

            if (StringExtention.isTrimNullOrEmpty(examModelWithBLOBs.getName()))
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            if (examModelWithBLOBs.getScore() == null || examModelWithBLOBs.getScore() < 0)
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            if (!IntegerExtention.hasValueAndMaxZero(examModelWithBLOBs.getTime()))
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            if (!IntegerExtention.hasValueAndMaxZero(examModelWithBLOBs.getCreateUser()))
                throw new BusinessException(ErrorCodeEnum.requestParamError);


            if (singleChoiceArray != null && singleChoiceArray.length > 0) {
                String singleChoiceString = this.listToString(singleChoiceArray);
                examModelWithBLOBs.setSingleChoice(singleChoiceString);
            }
            if (multipleChoiceArray != null && multipleChoiceArray.length > 0) {
                String multipleChoiceString = this.listToString(multipleChoiceArray);
                examModelWithBLOBs.setMultipleChoice(multipleChoiceString);
            }
            if (tofArray != null && tofArray.length > 0) {
                String tofString = this.listToString(tofArray);
                examModelWithBLOBs.setTof(tofString);
            }

            return examModelMapper.insertSelective(examModelWithBLOBs) > 0;

        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean updateExam(ExamModelWithBLOBs examModelWithBLOBs, String[] singleChoiceArray, String[] multipleChoiceArray, String[] tofArray) {

        if (examModelWithBLOBs != null && IntegerExtention.hasValueAndMaxZero(examModelWithBLOBs.getId())) {

            if ((singleChoiceArray == null || singleChoiceArray.length == 0)
                    && (multipleChoiceArray == null || multipleChoiceArray.length == 0)
                    && (tofArray == null || tofArray.length == 0)) {
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            }

            if (examModelWithBLOBs.getName() != null && StringExtention.isTrimNullOrEmpty(examModelWithBLOBs.getName()))
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            if (examModelWithBLOBs.getScore() != null && examModelWithBLOBs.getScore() < 0)
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            if (examModelWithBLOBs.getTime() != null && examModelWithBLOBs.getTime() < 0)
                throw new BusinessException(ErrorCodeEnum.requestParamError);


            String singleChoiceString = this.listToString(singleChoiceArray);
            examModelWithBLOBs.setSingleChoice(singleChoiceString);

            String multipleChoiceString = this.listToString(multipleChoiceArray);
            examModelWithBLOBs.setMultipleChoice(multipleChoiceString);

            String tofString = this.listToString(tofArray);
            examModelWithBLOBs.setTof(tofString);

            return examModelMapper.updateByPrimaryKeySelective(examModelWithBLOBs) > 0;

        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean deleteExam(Integer id) {
        return false;
    }


    private List<Integer> stringToList(String ids) {

        if (StringExtention.isTrimNullOrEmpty(ids))
            throw new BusinessException(ErrorCodeEnum.requestParamError);

        List<Integer> idList = new ArrayList<>();

        String[] list = ids.split(",");
        for (String a : list)
            idList.add(Integer.parseInt(a));

        return idList;

    }

    private String listToString(String[] ids) {

        if (ids != null && ids.length > 0) {
            StringBuilder sb = new StringBuilder();
            for (String a : ids)
                sb.append(a).append(",");

            if (sb.length() > 0)
                return sb.substring(0, sb.length() - 1);
        }
        return "";
    }


    //TODO 暂时无限制同时考试数量 （但单个考试 不会冲突
    public Map<String, Object> startExam(Integer userId, Integer roleId, Integer examId) {

        if (IntegerExtention.hasValueAndMaxZero(userId)
                && IntegerExtention.hasValueAndMaxZero(roleId)
                && IntegerExtention.hasValueAndMaxZero(examId)) {

            //此次考试Id 不用存
            String unionId = null;

            Map<String, Object> map = new HashMap<>();

            map.put("id", examId);
            map.put("roleId", roleId);
            //确保在时间内
            map.put("inTime", new Date());

            ExamModelWithBLOBs examModelWithBLOBs = examModelMapper.selectByMap(map);

            if (examModelWithBLOBs != null) {
                //判断是否可以考试
                if (examModelWithBLOBs.getType().equals(ExamType.ONCE)) {
                    int times = iScore.getHasTestedTime(userId, examId);
                    if (times > 1) {
                        throw new BusinessException("该考试您已完成，无法考试。");
                    }
                }
                //查询最后一次考试是否完成，
                // 1 如果在时间内 未完成 则继续考试
                // 2 如果在时间外 则重新开始
                ScoreModel scoreModel = iScore.getLastestExam(userId, examId);
                if (scoreModel != null) {
                    //未结束
                    if (scoreModel.getEndTime() == null) {
                        Calendar startTime = Calendar.getInstance();
                        startTime.setTime(scoreModel.getStartTime());
                        //加上考试时间
                        startTime.add(Calendar.MINUTE, examModelWithBLOBs.getTime());

                        //说明继续
                        if (startTime.compareTo(Calendar.getInstance()) > 0) {
                            unionId = scoreModel.getId();
                            //开考时间
                            examModelWithBLOBs.setStartTime(scoreModel.getStartTime());
                            //结束时间
                            examModelWithBLOBs.setEndTime(startTime.getTime());
                        }
                    } else {
                        //否则又可以考
                        if(examModelWithBLOBs.getType().equals(ExamType.ONCE)) {
                            //已结束！
                            throw new BusinessException("您的考试已完成，无法再次开始！");
                        }
                    }
                }

                //新建考试
                if (unionId == null) {

                    //这个时间为准
                    Date date = new Date();
                    //代表的是这次开考时间~~~~~~~~~
                    examModelWithBLOBs.setStartTime(date);
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(date);
                    calendar.add(Calendar.MINUTE, examModelWithBLOBs.getTime());
                    //结束时间
                    examModelWithBLOBs.setEndTime(calendar.getTime());

                    unionId = iScore.startExam(userId, examId, date);
                }


                //题目数据转换处理
                String singleChoiceString = examModelWithBLOBs.getSingleChoice();

                String multipleChoiceString = examModelWithBLOBs.getMultipleChoice();

                String tofString = examModelWithBLOBs.getTof();

                if (!StringExtention.isTrimNullOrEmpty(singleChoiceString)) {
                    List<QuestionModel> singleChoiceList = iQuestion.getByIdsForExam(this.stringToList(singleChoiceString), false);

                    //提高考试随机性 变换 题目顺序
                    Collections.shuffle(singleChoiceList);

                    for(QuestionModel questionModel:singleChoiceList)
                        Collections.shuffle(questionModel.getChoiceModelList());

                    examModelWithBLOBs.setSingleChoiceList(singleChoiceList);
                }
                if (!StringExtention.isTrimNullOrEmpty(multipleChoiceString)) {
                    List<QuestionModel> multipleChoiceList = iQuestion.getByIdsForExam(this.stringToList(multipleChoiceString), false);

                    //提高考试随机性 变换 题目顺序
                    Collections.shuffle(multipleChoiceList);

                    for(QuestionModel questionModel:multipleChoiceList)
                        Collections.shuffle(questionModel.getChoiceModelList());

                    examModelWithBLOBs.setMultipleChoiceList(multipleChoiceList);
                }
                if (!StringExtention.isTrimNullOrEmpty(tofString)) {
                    List<QuestionModel> tofList = iQuestion.getByIdsForExam(this.stringToList(tofString), false);

                    //提高考试随机性 变换 题目顺序
                    Collections.shuffle(tofList);

                    //提高考试随机性 变换 答案顺序
                    for(QuestionModel questionModel:tofList)
                        Collections.shuffle(questionModel.getChoiceModelList());

                    examModelWithBLOBs.setTofList(tofList);
                }


                examModelWithBLOBs.setSingleChoice(null);
                examModelWithBLOBs.setMultipleChoice(null);
                examModelWithBLOBs.setTof(null);


                Map<String, Object> result = new HashMap<>();
                result.put("exam", examModelWithBLOBs);
                result.put("unionId", unionId);

                return result;

            } else {
                throw new BusinessException("无该考试 或 不在考试时间内，请确认后重试！");
            }
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


    //结束考试
    public boolean examEnd(Integer userId, Integer roleId, Integer examId, HttpServletRequest httpRequest) {

        //获取考试标识
        String unionId = RequestParamHelper.getString(httpRequest, "unionId");

        //考试结束时间
        Calendar endTime = Calendar.getInstance();

        if (IntegerExtention.hasValueAndMaxZero(userId)
                && IntegerExtention.hasValueAndMaxZero(roleId)
                && IntegerExtention.hasValueAndMaxZero(examId)
                && !StringExtention.isTrimNullOrEmpty(unionId)) {

            //获取考试详情
            ScoreModel scoreModel = iScore.getById(unionId);

            if (scoreModel != null) {

                if (scoreModel.getEndTime() != null) {
                    throw new BusinessException("考试已结束，请勿重复提交！");
                }

                //获取试卷信息
                Map<String, Object> map = new HashMap<>();
                map.put("id", examId);
                map.put("roleId", roleId);

                ExamModelWithBLOBs examModelWithBLOBs = examModelMapper.selectByMap(map);

                if (examModelWithBLOBs != null) {

                    //确保在时间内
                    // 由于是提交 设置 结束提交时间 从 结束时间 + 考试时间
                    Calendar startTime = Calendar.getInstance();
                    startTime.setTime(scoreModel.getStartTime());

                    // TODO 冗余 2 分钟
                    if (endTime.getTimeInMillis() - startTime.getTimeInMillis() > (examModelWithBLOBs.getTime()+2) * 60 * 1000) {
                        throw new BusinessException("该考试已结束，无法提交！");
                    }


                    //处理考试信息

                    ExamResultModel examResultModel = new ExamResultModel();


                    Double totalScore;

                    Map<String, List<String>> detail = new HashMap<>();


                    //题目数据转换处理
                    String singleChoiceString = examModelWithBLOBs.getSingleChoice();

                    String multipleChoiceString = examModelWithBLOBs.getMultipleChoice();

                    String tofString = examModelWithBLOBs.getTof();


                    Double sScore = 0.0;
                    if (!StringExtention.isTrimNullOrEmpty(singleChoiceString)) {
                        List<QuestionModel> singleChoiceList = iQuestion.getByIdsForExam(this.stringToList(singleChoiceString), true);
                        //开始判分
                        if (singleChoiceList != null && singleChoiceList.size() > 0) {
                            for (QuestionModel questionModel : singleChoiceList) {

                                String name = questionModel.getId().toString();
                                String value = RequestParamHelper.getString(httpRequest, name);
                                //只有一个答案
                                if (questionModel.getRightAnswerList().get(0).equals(value)) {
                                    sScore += questionModel.getScore();
                                }

                                //记录考试详情
                                List<String> answer = new ArrayList<>();
                                if (value != null)
                                    answer.add(value);
                                detail.put(name, answer);
                            }
                        }
                    }

                    Double mScore = 0.0;
                    if (!StringExtention.isTrimNullOrEmpty(multipleChoiceString)) {
                        List<QuestionModel> multipleChoiceList = iQuestion.getByIdsForExam(this.stringToList(multipleChoiceString), true);
                        //开始判分
                        if (multipleChoiceList != null && multipleChoiceList.size() > 0) {
                            for (QuestionModel questionModel : multipleChoiceList) {

                                String name = questionModel.getId().toString();
                                String[] values = httpRequest.getParameterValues(name);
                                //多个答案
                                List<String> rightAnswer = questionModel.getRightAnswerList();
                                //答案长度相等 且都相同时 为正确
                                if (values != null && rightAnswer.size() == values.length) {

                                    Object[] rightAnswerArray = rightAnswer.toArray();
                                    Arrays.sort(rightAnswerArray, new Comparator<Object>() {
                                        @Override
                                        public int compare(Object o1, Object o2) {
                                            return o1.toString().compareTo(o2.toString());
                                        }
                                    });
                                    Arrays.sort(values);
                                    int count = 0;

                                    for (int i = 0; i < rightAnswerArray.length; i++) {
                                        if (rightAnswerArray[i].equals(values[i])) {
                                            count++;
                                        }
                                    }
                                    if (count == rightAnswerArray.length) {
                                        mScore += questionModel.getScore();
                                    }
                                }

                                //记录考试详情
                                List<String> answer = new ArrayList<>();
                                if (values != null)
                                    for (String a : values)
                                        answer.add(a);
                                detail.put(name, answer);
                            }
                        }
                    }

                    Double tScore = 0.0;
                    if (!StringExtention.isTrimNullOrEmpty(tofString)) {
                        List<QuestionModel> tofList = iQuestion.getByIdsForExam(this.stringToList(tofString), true);
                        //开始判分
                        if (tofList != null && tofList.size() > 0) {
                            for (QuestionModel questionModel : tofList) {

                                String name = questionModel.getId().toString();
                                String value = RequestParamHelper.getString(httpRequest, name);

                                if (questionModel.getRightAnswerList().get(0).equals(value)) {
                                    tScore += questionModel.getScore();
                                }

                                //记录考试详情
                                List<String> answer = new ArrayList<>();
                                if (value != null)
                                    answer.add(value);
                                detail.put(name, answer);
                            }
                        }
                    }

                    totalScore = sScore + mScore + tScore;

                    examResultModel.setTofScore(totalScore);
                    examResultModel.setSingleChoiceScore(sScore);
                    examResultModel.setMultipleChoiceScore(mScore);

                    examResultModel.setTotalScore(tScore);
                    examResultModel.setDetail(detail);

                    String text = null;
                    try {
                        text = objectMapper.writeValueAsString(examResultModel);
                    } catch (Exception e) {
                    }

                    //保存
                    ScoreModel model = new ScoreModel();
                    model.setId(unionId);
                    model.setEndTime(endTime.getTime());
                    model.setDetail(text);
                    model.setScore(totalScore);

                    return iScore.updateScore(model);

                } else {
                    throw new BusinessException("考试提交失败：错误的提交");
                }


            } else {
                throw new BusinessException("试卷提交异常，请检查是否正确开始考试");
            }
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    @Override
    public Map selectAllQuestion(Integer type) throws Exception {
        Map reMap = new HashMap();
        List questionList = questionModelMapper.selectAllQuestion(type);
        reMap.put("questionList", questionList);
        return reMap;
    }

    @Override
    public Map seacherQuestionByQuestion(String question) throws Exception {
        Map reMap = new HashMap();
        List questionList = questionModelMapper.seacherQuestionByQuestion(question);
        reMap.put("questionList", questionList);
        return reMap;
    }
}
