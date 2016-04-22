package cn.edu.ccu.data.course;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.course.RCourseStudentModel;
import cn.edu.ccu.model.course.RCourseStudentModelKey;

import java.util.List;

@PartyDB
public interface RCourseStudentModelMapper {
    int deleteByPrimaryKey(RCourseStudentModelKey key);

    int insert(RCourseStudentModel record);

    int insertSelective(RCourseStudentModel record);

    RCourseStudentModel selectByPrimaryKey(RCourseStudentModelKey key);

    int updateByPrimaryKeySelective(RCourseStudentModel record);

    int updateByPrimaryKey(RCourseStudentModel record);


    List<Integer> selectCourseByStudentId(Integer id);
}