package cn.edu.ccu.ibusiness.course;

import cn.edu.ccu.model.course.CourseListRequest;
import cn.edu.ccu.model.course.CourseListResponse;
import cn.edu.ccu.model.course.CourseModel;
import cn.edu.ccu.model.course.CourseWareModel;

/**
 * Created by Administrator on 2016/4/18.
 */
public interface ICourse {


    CourseModel selectById(Integer id);

    CourseModel selectDetailById(Integer id);

    CourseListResponse listByPage(CourseListRequest courseListRequest,boolean withCourseWare);

    CourseListResponse myCourseList(Integer id);

    boolean addCourse(CourseModel courseModel,String[] courseWare);

    boolean updateCourse(CourseModel courseModel,String[] courseWare);

    boolean deleteCourse(Integer id);

    //选课
    boolean chooseCourse(Integer studentId,Integer courseId);


    //是否有选该课程
    void checkCourse(Integer studentId, Integer courseId);


     CourseWareModel getWareById(Integer id) ;
}
