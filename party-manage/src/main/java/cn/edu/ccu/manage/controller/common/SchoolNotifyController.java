package cn.edu.ccu.manage.controller.common;

import cn.edu.ccu.ibusiness.common.ISchoolNotification;
import cn.edu.ccu.ibusiness.student.IStudentRole;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.common.NotificationModel;
import cn.edu.ccu.model.student.SRoleModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kuangye on 2016/5/11.
 */
@Controller
@AuthController(moduleId = 18)
@RequestMapping("/schoolnotify")
public class SchoolNotifyController extends BaseController{

    @Autowired
    IStudentRole iStudentRole;
    @Autowired
    ISchoolNotification iSchoolNotification;

    /**
     * 列表
     */
    @RequestMapping("/list")
    public ModelAndView list(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {

        ModelAndView mav = Common.getLoginModelAndView(httpRequest);


        List<SRoleModel> sRoleModelList = iStudentRole.studentRoleList();

        List<NotificationModel> notificationModelList = iSchoolNotification.getNotification();


        mav.addObject("roleList", sRoleModelList);
        mav.addObject("notifyList", notificationModelList);

        mav.setViewName("schoolnotify/list");
        return mav;
    }


    /**
     * 保存 添加/编辑 banner
     */
    @RequestMapping("/addOrUpdate")
    public
    @ResponseBody
    Map<String, Object> addOrUpdateArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            NotificationModel model) throws Exception {

        Map<String, Object> map = new HashMap<>();
        boolean i = iSchoolNotification.updateNotification(model);
        map.put("success", i);

        return map;
    }


}
