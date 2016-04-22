package cn.edu.ccu.school.controller;

import cn.edu.ccu.ibusiness.course.ICourse;
import cn.edu.ccu.ibusiness.course.IStudy;
import cn.edu.ccu.model.course.CourseModel;
import cn.edu.ccu.model.course.CourseWareModel;
import cn.edu.ccu.model.student.StudentModel;
import cn.edu.ccu.school.utils.AuthController;
import cn.edu.ccu.school.utils.AuthHelper;
import cn.edu.ccu.school.utils.AuthMethod;
import cn.edu.ccu.school.utils.Message;
import cn.edu.ccu.utils.common.SecurityHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by ky on 2016/4/20.
 */

@Controller
@AuthController(moduleId = -1)
public class StudyController extends BaseController {


    @Autowired
    private ICourse iCourse;

    @Autowired
    private IStudy iStudy;


    @AuthMethod
    @RequestMapping(value = "/study/{courseId}/{wareId}", method = RequestMethod.GET)
    public ModelAndView start(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                              @PathVariable("courseId") Integer courseId, @PathVariable("wareId") Integer wareId) {

        ModelAndView mav = super.getModelAndView("course/study", httpRequest);

        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);

        //校验
        iCourse.checkCourse(studentModel.getId(), courseId);
        //是否在学习其他课程
        boolean tag = iStudy.isStudyingOtherThing(courseId, wareId, studentModel.getId());
        if(tag){
            Message.showError(httpRequest,httpResponse,"您已经在学习其他课程！");
        }

        //获取课程
        CourseModel courseModel = iCourse.selectById(courseId);
        CourseWareModel courseWareModel = iCourse.getWareById(wareId);

        mav.addObject("course", courseModel);
        mav.addObject("courseWare", courseWareModel);


        try {
            String encodeKey = iStudy.getHashCode(studentModel.getId(), courseId, wareId);
            mav.addObject("hashcode", encodeKey);
        } catch (Exception e) {
        }

        return mav;
    }


    @AuthMethod
    @RequestMapping(value = "/study/check/{courseId}/{wareId}", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object>
    check(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
          @PathVariable("courseId") Integer courseId, @PathVariable("wareId") Integer wareId) {

        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);

        boolean tag = iStudy.isStudyingOtherThing(courseId, wareId, studentModel.getId());

        Map<String, Object> map = new HashMap<>();
        map.put("success", tag);

        return map;
    }


}
