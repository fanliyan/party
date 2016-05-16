package cn.edu.ccu.manage.controller.student;

import cn.edu.ccu.ibusiness.common.IArea;
import cn.edu.ccu.ibusiness.common.ICity;
import cn.edu.ccu.ibusiness.common.INation;
import cn.edu.ccu.ibusiness.common.IProvince;
import cn.edu.ccu.ibusiness.student.ISRole;
import cn.edu.ccu.ibusiness.student.IStudent;
import cn.edu.ccu.ibusiness.student.IStudentRole;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.student.SRoleModel;
import cn.edu.ccu.model.student.StudentListRequest;
import cn.edu.ccu.model.student.StudentListResponse;
import cn.edu.ccu.model.student.StudentModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/16.
 */
@Controller
@RequestMapping("/student")
@AuthController(moduleId = 6)
public class StudentController extends BaseController {

    @Autowired
    private IStudent iStudent;
    @Autowired
    private ISRole isRole;
    @Autowired
    private IStudentRole iStudentRole;

    @Autowired
    private INation iNation;
    @Autowired
    private IProvince iProvince;
    @Autowired
    private ICity iCity;
    @Autowired
    private IArea iArea;


    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse, StudentModel studentModel, SplitPageRequest pageRequest) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        StudentListRequest listRequest = new StudentListRequest();
        listRequest.setSplitPageRequest(pageRequest);
        listRequest.setStudentModel(studentModel);

        StudentListResponse listResponse = iStudent.listByPage(listRequest);
        mav.addObject("listResponse", listResponse);
        mav.addObject("student", studentModel);

        mav.addObject("nationlist", iNation.selectNationList());
        mav.addObject("provincelist", iProvince.selectProvinceList());
        mav.addObject("citylist", iCity.selectCityList());
        mav.addObject("arealist", iArea.selectAreaList());

        mav.setViewName("student/list");
        return mav;
    }

    @RequestMapping("/info")
    public ModelAndView info(HttpServletRequest httpRequest, HttpServletResponse httpResponse, Integer userId) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);
        StudentModel user = iStudent.getStudentById(userId);

        mav.addObject("user", user);
        mav.setViewName("student/userInfo");
        return mav;
    }

    @RequestMapping("/grantRole")
    public ModelAndView grantRole(HttpServletRequest httpRequest, HttpServletResponse httpResponse, Integer userId) throws Exception {

        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        List<SRoleModel> roleModelList = isRole.list();
        SRoleModel userRole = iStudent.getStudentDetailById(userId).getsRoleModel();

        mav.addObject("userId", userId);
        mav.addObject("roleModel", userRole);
        mav.addObject("allRoles", roleModelList);
        mav.setViewName("student/grantUserRole");
        return mav;
    }

    @RequestMapping(value = "/editLock", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> editLock(HttpServletRequest request, StudentModel user) throws Exception {
        Map<String, Object> map = new HashMap<>();

        if (user.getStatus() == -1) {
            user.setLoginFailCount(0);
        }
       boolean result = iStudent.changeStatus(user.getId(),user.getStatus());
        map.put("success", result );

        return map;
    }

    @RequestMapping(value = "/editRole", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> editRole(HttpServletRequest request, Integer userId, Integer roleId) throws Exception {
        Map<String, Object> map = new HashMap<>();


        SRoleModel userRole = iStudent.getStudentDetailById(userId).getsRoleModel();
        boolean tag = iStudentRole.updateRole(userId, roleId, userRole.getRoleId());
        map.put("success", tag);

        return map;
    }
}
