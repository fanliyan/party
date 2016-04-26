package cn.edu.ccu.business.exam;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.data.exam.ExamModelMapper;
import cn.edu.ccu.ibusiness.exam.IExam;
import cn.edu.ccu.ibusiness.exam.IQuestion;
import cn.edu.ccu.model.SplitPageResponse;
import cn.edu.ccu.model.exam.*;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created by kuangye on 2016/4/25.
 */
@Service
public class ExamBusiness implements IExam {

    @Autowired
    IQuestion iQuestion;

    @Autowired
    private ExamModelMapper examModelMapper;

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
}
