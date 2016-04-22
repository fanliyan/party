package cn.edu.ccu.ibusiness.course;

import cn.edu.ccu.model.course.CourseTypeListRequest;
import cn.edu.ccu.model.course.CourseTypeListResponse;
import cn.edu.ccu.model.course.CourseTypeModel;

import java.util.List;

/**
 * Created by Administrator on 2016/4/19.
 */
public interface ICourseType {

    CourseTypeModel selectById(Integer id);

    CourseTypeListResponse listByPage(CourseTypeListRequest courseTypeListRequest);

    List<CourseTypeModel> list();

    boolean addCourseType(CourseTypeModel courseTypeModel);

    boolean updateCourseType(CourseTypeModel courseTypeModel);

    boolean deleteCourseType(Integer id);
}
