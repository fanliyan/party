package cn.edu.ccu.business.exam;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.data.exam.ScoreModelMapper;
import cn.edu.ccu.ibusiness.exam.IScore;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.SplitPageResponse;
import cn.edu.ccu.model.exam.ScoreListResponse;
import cn.edu.ccu.model.exam.ScoreModel;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.student.StudentModel;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.StringHelper;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/26.
 */
@Service
public class ScoreBusiness implements IScore {

    @Autowired
    private ScoreModelMapper scoreModelMapper;

    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");

    //返回已考试次数
    public int getHasTestedTime(Integer userId, Integer examId) {

        if (IntegerExtention.hasValueAndMaxZero(userId) && IntegerExtention.hasValueAndMaxZero(examId)) {

            Map<String, Object> map = new HashMap<>();
            map.put("userId", userId);
            map.put("examId", examId);

            return scoreModelMapper.checkIsTested(map);
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    //获取 最近一次的该考试
    public ScoreModel getLastestExam(Integer userId, Integer examId) {

        if (IntegerExtention.hasValueAndMaxZero(userId) && IntegerExtention.hasValueAndMaxZero(examId)) {

            Map<String, Object> map = new HashMap<>();
            map.put("userId", userId);
            map.put("examId", examId);

            return scoreModelMapper.getLastestExam(map);
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


    public String startExam(Integer userId, Integer examId, Date startTime) {

        if (IntegerExtention.hasValueAndMaxZero(userId) && IntegerExtention.hasValueAndMaxZero(examId)) {

            ScoreModel scoreModel = new ScoreModel();
            scoreModel.setExamId(examId);
            scoreModel.setUserId(userId);

            if (startTime != null) {
                scoreModel.setStartTime(startTime);
            } else {
                scoreModel.setStartTime(new Date());
            }

            //自定义主键
            String id = ScoreBusiness.generateId();
            scoreModel.setId(id);
            int i = scoreModelMapper.insertSelective(scoreModel);
            if (i > 0) {
                return id;
            }
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


    public ScoreModel getById(String id) {

        if (!StringExtention.isTrimNullOrEmpty(id)) {
            return scoreModelMapper.selectByPrimaryKey(id);
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean updateScore(ScoreModel scoreModel) {

        if (scoreModel != null && !StringExtention.isTrimNullOrEmpty(scoreModel.getId())) {
            return scoreModelMapper.updateByPrimaryKeySelective(scoreModel) > 0;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


    private static String generateId() {
        return sdf.format(new Date()) + StringHelper.getStringRandom(3);
    }


    public ScoreListResponse myScoreList(Integer userId, SplitPageRequest splitPageRequest) {

        if (IntegerExtention.hasValueAndMaxZero(userId)) {
            ScoreListResponse response = new ScoreListResponse();

            Map<String, Object> map = new HashMap<>();

            map.put("userId", userId);

            UtilsBusiness.pubMapforSplitPage(splitPageRequest, map);


            List<ScoreModel> scoreModelList = scoreModelMapper.select(map);

            response.setScoreModelList(scoreModelList);

            if (splitPageRequest != null && splitPageRequest.isReturnCount()) {
                int rowCount = scoreModelMapper.count(map);

                SplitPageResponse pageResponse = UtilsBusiness.getSplitPageResponse(
                        rowCount, splitPageRequest.getPageSize(), splitPageRequest.getPageNo());
                response.setSplitPageResponse(pageResponse);
            }

            return response;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public ScoreListResponse scoreList(StudentModel studentModel, SplitPageRequest splitPageRequest) {


        ScoreListResponse response = new ScoreListResponse();

        Map<String, Object> map = new HashMap<>();
        if (IntegerExtention.hasValueAndMaxZero(studentModel.getId()))
            map.put("userId", studentModel.getId());
        if (!StringExtention.isTrimNullOrEmpty(studentModel.getName()))
            map.put("studentName", studentModel.getName());

        UtilsBusiness.pubMapforSplitPage(splitPageRequest, map);


        List<ScoreModel> scoreModelList = scoreModelMapper.select(map);

        response.setScoreModelList(scoreModelList);

        if (splitPageRequest != null && splitPageRequest.isReturnCount()) {
            int rowCount = scoreModelMapper.count(map);

            SplitPageResponse pageResponse = UtilsBusiness.getSplitPageResponse(
                    rowCount, splitPageRequest.getPageSize(), splitPageRequest.getPageNo());
            response.setSplitPageResponse(pageResponse);
        }

        return response;


    }


}
