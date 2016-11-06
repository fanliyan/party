package cn.edu.ccu.ibusiness.exam;

import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.exam.ScoreListResponse;
import cn.edu.ccu.model.exam.ScoreModel;
import cn.edu.ccu.model.student.StudentModel;

import java.util.Date;

/**
 * Created by kuangye on 2016/4/26.
 */
public interface IScore {

    int getHasTestedTime(Integer userId, Integer examId);

    ScoreModel getLastestExam(Integer userId, Integer examId);

    String startExam(Integer userId, Integer examId, Date startTime);

    ScoreModel getById(String id);


    boolean updateScore(ScoreModel scoreModel);


    ScoreListResponse myScoreList(Integer userId, SplitPageRequest splitPageRequest);

    ScoreListResponse scoreList(Integer departmentId, Integer xiId, Integer classId, String examName, StudentModel studentModel, SplitPageRequest splitPageRequest);


}
