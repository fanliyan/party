package cn.edu.ccu.school.controller;

import cn.edu.ccu.ibusiness.course.ICourse;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.course.CourseListRequest;
import cn.edu.ccu.model.course.CourseListResponse;
import cn.edu.ccu.model.course.CourseModel;
import cn.edu.ccu.model.student.StudentModel;
import cn.edu.ccu.school.utils.AuthController;
import cn.edu.ccu.school.utils.AuthHelper;
import cn.edu.ccu.school.utils.AuthMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2016/4/17.
 */
@Controller
@RequestMapping("/course")
@AuthController(moduleId = -1)
public class CourseController extends BaseController {


    @Autowired
    private ICourse iCourse;

    @AuthMethod
    @RequestMapping(value = "mycourselist", method = RequestMethod.GET)
    public ModelAndView mycourselist(HttpServletRequest httpRequest, HttpServletResponse httpResponse) {

        ModelAndView mav = super.getModelAndView("course/myCourseList", httpRequest);

        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);
        CourseListResponse response = iCourse.myCourseList(studentModel.getId());

        mav.addObject("response", response);
        return mav;
    }

    @AuthMethod
    @RequestMapping(value = "choose", method = RequestMethod.GET)
    public ModelAndView choose(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                               SplitPageRequest splitPageRequest, CourseModel courseModel) {

        ModelAndView mav = super.getModelAndView("course/chooseCourseList", httpRequest);

        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);
        CourseListResponse myCourseList = iCourse.myCourseList(studentModel.getId());

        //所有课程
        CourseListRequest courseListRequest = new CourseListRequest();
        courseListRequest.setCourseModel(courseModel);
        splitPageRequest.setReturnCount(true);
        courseListRequest.setSplitPageRequest(splitPageRequest);
        CourseListResponse response = iCourse.listByPage(courseListRequest, false);

        //标识已选课程
        if (response.getCourseModelList() != null && response.getCourseModelList().size() > 0
                && myCourseList.getCourseModelList() != null && myCourseList.getCourseModelList().size() > 0) {
            for (CourseModel course : response.getCourseModelList()) {
                for (CourseModel myCourse : myCourseList.getCourseModelList()) {
                    if (course.getCourseId().equals(myCourse.getCourseId()))
                        course.setIsChoose(true);
                }
            }
        }


        mav.addObject("response", response);
        return mav;
    }


    @AuthMethod
    @RequestMapping(value = "chooseCourse", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object>
    chooseCourse(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                 SplitPageRequest splitPageRequest, Integer id) {

        Map<String, Object> map = new HashMap<>();

        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);

        map.put("success", iCourse.chooseCourse(studentModel.getId(), id));

        return map;
    }


}
