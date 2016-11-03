package cn.edu.ccu.manage.controller.student;

import cn.edu.ccu.data.student.SRoleModelMapper;
import cn.edu.ccu.ibusiness.course.ICourse;
import cn.edu.ccu.ibusiness.course.ICourseType;
import cn.edu.ccu.ibusiness.srolecourse.ISroleCourse;
import cn.edu.ccu.ibusiness.student.ISRole;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.course.CourseListRequest;
import cn.edu.ccu.model.course.CourseListResponse;
import cn.edu.ccu.model.course.CourseModel;
import cn.edu.ccu.model.srolecourse.SroleCourse;
import cn.edu.ccu.model.student.SRoleModel;
import com.fasterxml.jackson.databind.deser.Deserializers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static javafx.scene.input.KeyCode.R;

/**
 * Created by Fanliyan on 2016/10/25.
 */
@Controller
@RequestMapping(value="/srole")
@AuthController(moduleId = 6)
public class SRoleController extends BaseController{

    @Autowired
    private ISRole isRole;
    @Autowired
    private ICourse iCourse;
    @Autowired
    private ISroleCourse iSroleCourse;

    @RequestMapping(value="/showAllSRole")
    public ModelAndView showAllSRole(HttpServletRequest httpRequest){
        ModelAndView mav = null;
        try {
              mav = Common.getLoginModelAndView(httpRequest);
            List<SRoleModel> SRoleModel = isRole.list();
            mav.addObject("SRoleModel", SRoleModel);
            mav.setViewName("student/s_role/s_roleList");

        } catch (Exception e) {
            e.printStackTrace();
        }
        return mav;
    }

    @RequestMapping(value="/grantSRoleCourse")
    public ModelAndView grantSRoleCourse(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                                         CourseModel courseModel, SplitPageRequest pageRequest, @RequestParam(value="sroleId") int sroleId){
        ModelAndView mav = null;
        try {
            mav = Common.getLoginModelAndView(httpRequest);
            CourseListRequest request = new CourseListRequest();
            request.setCourseModel(courseModel);
            pageRequest.setReturnCount(true);
            request.setSplitPageRequest(pageRequest);
            CourseListResponse response = iCourse.listByPage(request, false);

            List courseIdList = iSroleCourse.selectCourseId(sroleId);

            mav.addObject("response", response);
            mav.addObject("courseIdListId", courseIdList);
            mav.addObject("sroleId", sroleId);
            mav.setViewName("student/s_role/grantSRoleCourse");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mav;
    }

    @RequestMapping(value="addoredit")
    @ResponseBody
    public Map AddOrEdit(@RequestParam(value="courseId") List<Integer> courseIds, @RequestParam(value="sroleId") int sroleId){
        Map reMap = new HashMap();
        try {
            Map map = iSroleCourse.addOrEdit(courseIds, sroleId);
            boolean b = (boolean)map.get("result");
            if(b == true){
                reMap.put("result", true);
            }else if(b == false){
                reMap.put("result", false);
                reMap.put("message", "更新失败！");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reMap;
    }
}
