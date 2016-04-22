package cn.edu.ccu.data.course;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.course.CourseModel;

import java.util.List;
import java.util.Map;

@PartyDB
public interface CourseModelMapper {
    int deleteByPrimaryKey(Integer courseId);

    int insert(CourseModel record);

    int insertSelective(CourseModel record);

    CourseModel selectByPrimaryKey(Integer courseId);

    int updateByPrimaryKeySelective(CourseModel record);

    int updateByPrimaryKey(CourseModel record);


    List<CourseModel> select(Map map);

    int count(Map map);
}