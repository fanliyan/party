package cn.edu.ccu.data.course;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.course.CourseWareModel;

import java.util.List;

@PartyDB
public interface CourseWareModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CourseWareModel record);

    int insertSelective(CourseWareModel record);

    CourseWareModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CourseWareModel record);

    int updateByPrimaryKey(CourseWareModel record);

    int deleteByCourseId(Integer id);

    List<CourseWareModel> selectByCourseId(Integer id);
}