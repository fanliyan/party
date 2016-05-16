package cn.edu.ccu.data.study;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.common.TableModel;
import cn.edu.ccu.model.study.StudyLogModel;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;

@PartyDB
public interface StudyLogModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(StudyLogModel record);

    int insertSelective(StudyLogModel record);

    StudyLogModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(StudyLogModel record);

    int updateByPrimaryKey(StudyLogModel record);


    int selectIsInStudy(
            @Param("courseId") Integer courseId,@Param("wareId") Integer wareId,@Param("userId") Integer userId);

    List<StudyLogModel> selectLogByCode(
            @Param("courseId") Integer courseId, @Param("wareId") Integer wareId, @Param("userId") Integer userId,
            @Param("code") Integer code,@Param("startTime") Date startTime,@Param("endTime") Date endTime);




    //统计相关

    //统计学生学习课程数
    List<TableModel> studyCourseTop(Map map);

    //统计课程观看次数
    List<TableModel> watchCount();

}