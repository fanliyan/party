package cn.edu.ccu.ibusiness.course;

import cn.edu.ccu.model.study.StudyLogModel;
import cn.edu.ccu.model.study.VideoStudyWSRequest;
import cn.edu.ccu.model.study.VideoStudyWSResponse;

import java.util.Date;
import java.util.List;

/**
 * Created by kuangye on 2016/4/20.
 */
public interface IStudy {


    String getHashCode(Integer studentId, Integer courseId, Integer wareId);


    void addOnlineList(StudyLogModel studyLogModel);

    void removeOnlineList(String sessionId);

    List<StudyLogModel> getOnlineList();

    int getOnlineCount();


    VideoStudyWSResponse pushContent(VideoStudyWSRequest videoStudyWSRequest);


    boolean isStudyingOtherThing(Integer courseId, Integer wareId, Integer userId);


    //按时间段算
    boolean calculateOneCourseStudy(Integer userId, Integer courseId, Date startTime,Date endTime);

}
