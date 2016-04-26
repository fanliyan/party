package cn.edu.ccu.manage.controller.course;

import cn.edu.ccu.ibusiness.course.ICourse;
import cn.edu.ccu.ibusiness.course.ICourseType;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.course.*;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
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
 * Created by kuangye on 2016/4/19.
 */
@Controller
@RequestMapping("/coursetype")
@AuthController(moduleId = 8)
public class CourseTypeController extends BaseController {

    @Autowired
    private ICourseType iCourseType;


    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                             CourseTypeModel courseTypeModel, SplitPageRequest pageRequest) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        CourseTypeListRequest request = new CourseTypeListRequest();
        request.setCourseTypeModel(courseTypeModel);
        pageRequest.setReturnCount(true);
        request.setSplitPageRequest(pageRequest);

        CourseTypeListResponse response = iCourseType.listByPage(request);
        mav.addObject("response", response);

        mav.addObject("courseType",courseTypeModel);
        mav.setViewName("/coursetype/courseTypeList");
        return mav;
    }

    @RequestMapping("/add")
    public ModelAndView addArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        mav.setViewName("coursetype/courseTypeEdit");
        return mav;
    }

    @RequestMapping("/edit")
    public ModelAndView editArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            Integer id) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        mav.addObject("courseType", iCourseType.selectById(id));

        mav.setViewName("coursetype/courseTypeEdit");
        return mav;
    }


    @RequestMapping(value = "/addOrUpdate", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> addOrUpdateArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            CourseTypeModel model) throws Exception {

        Map<String, Object> map = new HashMap<>();
        boolean i;
        if (httpRequest.getParameter("isUpdate") == null) {
            i = iCourseType.addCourseType(model);
        } else {
            i = iCourseType.updateCourseType(model);
        }
        map.put("success", i);

        return map;
    }

    @RequestMapping("/del")
    public
    @ResponseBody
    Map<String, Object> delArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            Integer id) throws Exception {

        boolean i = false;
        Map<String, Object> map = new HashMap<>();
        if (IntegerExtention.hasValueAndMaxZero(id)) {
            i = iCourseType.deleteCourseType(id);
        }
        map.put("success", i);

        return map;
    }


}
