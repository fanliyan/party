package cn.edu.ccu.data.course;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.course.CourseTypeModel;

import java.util.List;
import java.util.Map;

@PartyDB
public interface CourseTypeModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CourseTypeModel record);

    int insertSelective(CourseTypeModel record);

    CourseTypeModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CourseTypeModel record);

    int updateByPrimaryKey(CourseTypeModel record);

    List<CourseTypeModel> select(Map map);

    int count(Map map);

    public CourseTypeModel selectCourseType(int courseId) throws Exception;
}