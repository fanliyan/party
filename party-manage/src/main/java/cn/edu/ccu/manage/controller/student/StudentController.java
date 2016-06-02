package cn.edu.ccu.manage.controller.student;

import cn.edu.ccu.ibusiness.common.*;
import cn.edu.ccu.ibusiness.student.ISRole;
import cn.edu.ccu.ibusiness.student.IStudent;
import cn.edu.ccu.ibusiness.student.IStudentRole;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.AuthHelper;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.student.SRoleModel;
import cn.edu.ccu.model.student.StudentListRequest;
import cn.edu.ccu.model.student.StudentListResponse;
import cn.edu.ccu.model.student.StudentModel;
import cn.edu.ccu.model.user.UserModel;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
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
    private IDepartment iDepartment;


    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                             StudentListRequest listRequest, StudentModel studentModel, SplitPageRequest pageRequest,
                             Boolean isDownload) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        //maybe empty string
        if (StringExtention.isTrimNullOrEmpty(listRequest.getCityCode()))
            listRequest.setCityCode(null);
        if (StringExtention.isTrimNullOrEmpty(listRequest.getProvinceCode()))
            listRequest.setProvinceCode(null);
        if (StringExtention.isTrimNullOrEmpty(studentModel.getAreaCode()))
            studentModel.setAreaCode(null);

        pageRequest.setReturnCount(true);
        listRequest.setSplitPageRequest(pageRequest);
        listRequest.setStudentModel(studentModel);


        if (isDownload != null && isDownload) {
            listRequest.setSplitPageRequest(null);
            mav.setViewName("student/download");

            // 设置response参数，可以打开下载页面
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-SSS");
            httpResponse.reset();
            httpResponse.setContentType("application/vnd.ms-excel;charset=utf-8");
            httpResponse.setHeader("Content-Disposition", "attachment;filename=" + new String(("学生信息" + sdf.format(new Date()) + ".xls").getBytes(), "iso-8859-1"));
        } else {
            mav.setViewName("student/list");
            mav.addObject("student", studentModel);

            mav.addObject("nationlist", iNation.selectNationList());
            mav.addObject("provincelist", iProvince.selectProvinceList());


            mav.addObject("departmentlist", iDepartment.select());
        }

        mav.addObject("request", listRequest);


        UserModel loginUserModel = AuthHelper.getLoginUserModel(httpRequest);

        StudentListResponse listResponse = iStudent.listByPage(listRequest, loginUserModel.getUserId());

        mav.addObject("listResponse", listResponse);

        return mav;
    }

    @RequestMapping("/info")
    public ModelAndView info(HttpServletRequest httpRequest, HttpServletResponse httpResponse, Integer userId) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);
        StudentModel user = iStudent.getStudentDetailById(userId);

        mav.addObject("user", user);
        mav.setViewName("student/userInfo");
        return mav;
    }

    @RequestMapping("/edit")
    public ModelAndView edit(HttpServletRequest httpRequest, HttpServletResponse httpResponse, Integer userId) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        StudentModel user = iStudent.getStudentDetailById(userId);
        mav.addObject("user", user);


        mav.addObject("nationlist", iNation.selectNationList());
        mav.addObject("provincelist", iProvince.selectProvinceList());
        mav.addObject("departmentlist", iDepartment.select());

        mav.setViewName("student/saveUser");
        return mav;
    }

    @RequestMapping(value = "/saveUser", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> saveUser(HttpServletRequest request, StudentModel user, String birthdayString,
                                 String keyActiveMemberTimeString, String probationaryMemberTimeString,
                                 String cardCarryingMemberTimeString) throws Exception {
        Map<String, Object> map = new HashMap<>();

        if (!StringExtention.isTrimNullOrEmpty(birthdayString))
            user.setBirthday(sdf.parse(birthdayString));
        if (!StringExtention.isTrimNullOrEmpty(keyActiveMemberTimeString))
            user.setKeyActiveMemberTime(sdf.parse(keyActiveMemberTimeString));
        if (!StringExtention.isTrimNullOrEmpty(probationaryMemberTimeString))
            user.setProbationaryMemberTime(sdf.parse(probationaryMemberTimeString));
        if (!StringExtention.isTrimNullOrEmpty(cardCarryingMemberTimeString))
            user.setCardCarryingMemberTime(sdf.parse(cardCarryingMemberTimeString));


        boolean result = iStudent.updateStudent(user);
        map.put("success", result);

        return map;
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
        boolean result = iStudent.changeStatus(user.getId(), user.getStatus());
        map.put("success", result);

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


    @RequestMapping(value = "/del", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> del(HttpServletRequest request, Integer id) throws Exception {
        Map<String, Object> map = new HashMap<>();

        boolean tag = iStudent.del(id);
        map.put("success", tag);

        return map;
    }
}
