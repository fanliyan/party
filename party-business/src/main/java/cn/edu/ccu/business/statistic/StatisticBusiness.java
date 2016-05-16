package cn.edu.ccu.business.statistic;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.data.exam.ExamModelMapper;
import cn.edu.ccu.data.study.StudyLogModelMapper;
import cn.edu.ccu.ibusiness.statistic.IStatistic;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.common.TableModel;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/30.
 */
@Service
public class StatisticBusiness implements IStatistic {

    @Autowired
    private StudyLogModelMapper studyLogModelMapper;
    @Autowired
    private ExamModelMapper examModelMapper;


    public List<TableModel> getCourseCountTopStudent(SplitPageRequest splitPageRequest) {

        Map<String, Object> map = new HashMap<>();

        //TODO 分页排序会有问题 暂不用
        if (splitPageRequest != null) {
            UtilsBusiness.pubMapforSplitPage(splitPageRequest, map);
        }

        return studyLogModelMapper.studyCourseTop(map);
    }

    public List<TableModel> getCourseWatchCount(){
        return studyLogModelMapper.watchCount();
    }











    public List<TableModel> getExamTopStudent(Integer roleId, Integer examId, SplitPageRequest splitPageRequest) {

        if (IntegerExtention.hasValueAndMaxZero(roleId) && IntegerExtention.hasValueAndMaxZero(examId)) {
            Map<String, Object> map = new HashMap<>();

            map.put("roleId", roleId);
            map.put("examId", examId);

            return examModelMapper.getAExamTop(map);
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

}
