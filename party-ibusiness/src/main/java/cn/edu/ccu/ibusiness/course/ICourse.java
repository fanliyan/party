package cn.edu.ccu.ibusiness.course;

import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.course.CourseListRequest;
import cn.edu.ccu.model.course.CourseListResponse;
import cn.edu.ccu.model.course.CourseModel;
import cn.edu.ccu.model.course.CourseWareModel;
import cn.edu.ccu.utils.common.extention.IntegerExtention;

import java.util.List;

/**
 * Created by kuangye on 2016/4/18.
 */
public interface ICourse {


    CourseModel selectById(Integer id);

    CourseModel selectDetailById(Integer id);

    CourseListResponse listByPage(CourseListRequest courseListRequest,boolean withCourseWare);

    CourseListResponse myCourseList(Integer id, SplitPageRequest splitPageRequest);

    boolean addCourse(CourseModel courseModel,String[] courseWare);

    boolean updateCourse(CourseModel courseModel,String[] courseWare);

    boolean deleteCourse(Integer id);

    //选课
    boolean chooseCourse(Integer studentId,Integer courseId);


    //是否有选该课程
    void checkCourse(Integer studentId, Integer courseId);


     CourseWareModel getWareById(Integer id) ;


    List<CourseWareModel> getWareListByCourseId(Integer courseId);
}
