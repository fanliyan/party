package cn.edu.ccu.manage.controller.common;

import cn.edu.ccu.ibusiness.common.IBranch;
import cn.edu.ccu.ibusiness.common.IDepartment;
import cn.edu.ccu.ibusiness.common.ISchoolNotification;
import cn.edu.ccu.ibusiness.student.IStudentRole;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.AuthHelper;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.common.BranchModel;
import cn.edu.ccu.model.common.DepartmentModel;
import cn.edu.ccu.model.common.NotificationModel;
import cn.edu.ccu.model.common.NotificationModelWithBLOBs;
import cn.edu.ccu.model.student.SRoleModel;
import cn.edu.ccu.model.user.DepartmentType;
import cn.edu.ccu.model.user.UserModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kuangye on 2016/5/11.
 */
@Controller
@AuthController(moduleId = 18)
@RequestMapping("/schoolnotify")
public class SchoolNotifyController extends BaseController {

    @Autowired
    IStudentRole iStudentRole;
    @Autowired
    ISchoolNotification iSchoolNotification;
    @Autowired
    IDepartment iDepartment;
    @Autowired
    IBranch iBranch;


    /**
     * 列表
     */
    @RequestMapping("/list")
    public ModelAndView list(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {

        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        UserModel loginUserModel = AuthHelper.getLoginUserModel(httpRequest);

        List<DepartmentModel> departmentModelList;

        //通知权限设置
        //查看单一角色
        if (loginUserModel.getDepartmentType().equals(DepartmentType.SCHOOL)) {
            departmentModelList = iDepartment.select();
        } else {

            Integer branchId = loginUserModel.getBranchId();

            BranchModel branchModel = iBranch.getById(branchId);
            DepartmentModel departmentModel = iDepartment.getById(branchModel.getDepartmentId());

            departmentModelList = new ArrayList<>();
            departmentModelList.add(departmentModel);
        }

        mav.addObject("list", departmentModelList);

        mav.setViewName("schoolnotify/list1");
        return mav;
    }


    /**
     * 列表
     */
    @RequestMapping("/list/{id}")
    public ModelAndView list1(@PathVariable("id") Integer id,
                              HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {

        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        //判断角色
        UserModel loginUserModel = AuthHelper.getLoginUserModel(httpRequest);

        //
        if (loginUserModel.getDepartmentType().equals(DepartmentType.BRANCH)) {
            mav.addObject("inputName", "extraContent");
            mav.addObject("isBranch", true);
        } else {
            mav.addObject("inputName", "content");
        }


        DepartmentModel departmentModel = iDepartment.getById(id);
        mav.addObject("department", departmentModel);


        List<SRoleModel> roleList = iStudentRole.studentRoleList();
        mav.addObject("roleList", roleList);


        List<NotificationModelWithBLOBs> notifyList = iSchoolNotification.getNotificationByDepartment(id);
        mav.addObject("notifyList", notifyList);

        mav.setViewName("schoolnotify/list");
        return mav;
    }


    /**
     * 保存 添加/编辑
     */
    @RequestMapping("/addOrUpdate")
    public
    @ResponseBody
    Map<String, Object> addOrUpdateArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            NotificationModelWithBLOBs model) throws Exception {

        Map<String, Object> map = new HashMap<>();
        boolean i = iSchoolNotification.updateNotification(model);
        map.put("success", i);

        return map;
    }


}
