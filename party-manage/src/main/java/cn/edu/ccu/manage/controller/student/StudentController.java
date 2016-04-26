package cn.edu.ccu.manage.controller.student;

import cn.edu.ccu.ibusiness.common.IArea;
import cn.edu.ccu.ibusiness.common.ICity;
import cn.edu.ccu.ibusiness.common.INation;
import cn.edu.ccu.ibusiness.common.IProvince;
import cn.edu.ccu.ibusiness.student.IStudent;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
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

        mav.addObject("nationlist",iNation.selectNationList());
        mav.addObject("provincelist",iProvince.selectProvinceList());
        mav.addObject("citylist",iCity.selectCityList());
        mav.addObject("arealist",iArea.selectAreaList());

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

//    @RequestMapping("/grantRole")
//    public ModelAndView grantRole(HttpServletRequest httpRequest, HttpServletResponse httpResponse, Integer userId) throws Exception {
//
//        ModelAndView mav = Common.getLoginModelAndView(httpRequest);
//        UserModel loginUser = (UserModel) mav.getModel().get("loginUserModel");
//
//        UserModel user = iUser.getUserById(userId);
//        List<RoleModel> allRoles = iRole.list();
//        List<RoleModel> userRoles = iRole.listRolesDetailByUserId(userId);
//        user.setHasRoles(userRoles);
//        mav.addObject("user", user);
//        mav.addObject("allRoles", allRoles);
//        mav.setViewName("system/user/grantUserRole");
//        return mav;
//    }

//    @RequestMapping(value = "/editLock", method = RequestMethod.POST)
//    public
//    @ResponseBody
//    Map<String, Object> editLock(HttpServletRequest request, UserModel user) throws Exception {
//        Map<String, Object> map = new HashMap<>();
//        int result;
//        if (user.getStatus() == -1) {
//            user.setLoginFailCount(0);
//        }
//        result = iStudent.updateUser(user);
//        map.put("success", result > 0);
//
//        return map;
//    }
//
//    @RequestMapping(value = "/editRole", method = RequestMethod.POST)
//    public
//    @ResponseBody
//    Map<String, Object> editRole(HttpServletRequest request, Integer userId, Integer roleId[], Byte level) throws Exception {
//        Map<String, Object> map = new HashMap<>();
//        ModelAndView mav = Common.getLoginModelAndView(request);
//        UserModel loginUser = (UserModel) mav.getModel().get("loginUserModel");
//
//        boolean flag = true;
//
//        List<RoleModel> allRoles = iRole.list();
//        for (int i = 0; roleId != null && i < roleId.length; i++) {
//            //获取所选项 对应roleModel
//            for (RoleModel roleModel : allRoles) {
//                if (roleModel.getRoleId().equals(roleId[i])) {
//                    //是否能手动分配
//                    if (AuthList.contains(AuthList.UNREMOVABLE_ROLE, roleModel.getRoleId())) {
//                        map.put("success", false);
//                        map.put("message", roleModel.getName() + " 不能手动分配");
//                        flag = false;
//                        break;
//                    }
//                }
//            }
//        }
//        if (flag) {
//            iUserRole.editByUserRoleIds(userId, roleId, level, super.getRequestHead(request));
//            map.put("success", true);
//        }
//
//        return map;
//    }
}
