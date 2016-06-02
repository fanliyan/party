package cn.edu.ccu.manage.controller.user;

import cn.edu.ccu.ibusiness.common.IDepartment;
import cn.edu.ccu.ibusiness.system.IRole;
import cn.edu.ccu.ibusiness.system.IUser;
import cn.edu.ccu.ibusiness.system.IUserRole;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.AuthList;
import cn.edu.ccu.manage.utils.AuthMethod;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.system.RUserRoleModel;
import cn.edu.ccu.model.system.RoleModel;
import cn.edu.ccu.model.user.UserListRequest;
import cn.edu.ccu.model.user.UserListResponse;
import cn.edu.ccu.model.user.UserModel;
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
import java.util.List;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/12.
 */
@Controller
@RequestMapping("/users")
@AuthController(moduleId = 1)
public class UserController extends BaseController {


    @Autowired
    private IUser iUser;
    @Autowired
    private IRole iRole;
    @Autowired
    private IUserRole iUserRole;


    @Autowired
    private IDepartment iDepartment;

    @AuthMethod
    @RequestMapping("/list")
    public ModelAndView Index(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                              UserModel user, SplitPageRequest pageRequest) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        UserModel loginUser = (UserModel) mav.getModel().get("loginUserModel");

        UserListRequest listRequest = new UserListRequest();
        listRequest.setSplitPageRequest(pageRequest);
        listRequest.setUserModel(user);

        //只有管理员能授权
        mav.addObject("isGrant", AuthList.isSuperAdmin(loginUser.getUserId()));

        UserListResponse listResponse = iUser.listBySplitPage(listRequest);
        mav.addObject("listResponse", listResponse);
        mav.addObject("user", user);

        mav.addObject("departmentlist", iDepartment.select());

        mav.setViewName("system/user/userList");
        return mav;
    }

    @AuthMethod
    @RequestMapping("/info")
    public ModelAndView info(HttpServletRequest httpRequest, HttpServletResponse httpResponse, Integer userId) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);
        UserModel user = iUser.getUserDetailById(userId);
        mav.addObject("user", user);
        mav.setViewName("system/user/userInfo");
        return mav;
    }

    @RequestMapping("/grantRole")
    public ModelAndView grantRole(HttpServletRequest httpRequest, HttpServletResponse httpResponse, Integer userId) throws Exception {

        ModelAndView mav = Common.getLoginModelAndView(httpRequest);
        UserModel loginUser = (UserModel) mav.getModel().get("loginUserModel");

        UserModel user = iUser.getUserById(userId);
        List<RoleModel> allRoles = iRole.list();
        List<RoleModel> userRoles = iRole.listRolesDetailByUserId(userId);
        user.setHasRoles(userRoles);
        mav.addObject("user", user);
        mav.addObject("allRoles", allRoles);
        mav.setViewName("system/user/grantUserRole");
        return mav;
    }

    @RequestMapping(value = "/editLock", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> editLock(HttpServletRequest request, UserModel user) throws Exception {
        Map<String, Object> map = new HashMap<>();
        int result;
        if (user.getStatus() == -1) {
            user.setLoginFailCount(0);
        }
        result = iUser.updateUser(user);
        map.put("success", result > 0);

        return map;
    }

    @RequestMapping(value = "/editRole", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> editRole(HttpServletRequest request, Integer userId, Integer roleId[], Byte level) throws Exception {
        Map<String, Object> map = new HashMap<>();
        ModelAndView mav = Common.getLoginModelAndView(request);
        UserModel loginUser = (UserModel) mav.getModel().get("loginUserModel");

        boolean flag = true;

        List<RoleModel> allRoles = iRole.list();
        for (int i = 0; roleId != null && i < roleId.length; i++) {
            //获取所选项 对应roleModel
            for (RoleModel roleModel : allRoles) {
                if (roleModel.getRoleId().equals(roleId[i])) {
                    //是否能手动分配
                    if (AuthList.contains(AuthList.UNREMOVABLE_ROLE, roleModel.getRoleId())) {
                        map.put("success", false);
                        map.put("message", roleModel.getName() + " 不能手动分配");
                        flag = false;
                        break;
                    }
                }
            }
        }
        if (flag) {
            iUserRole.editByUserRoleIds(userId, roleId, level, super.getRequestHead(request));
            map.put("success", true);
        }

        return map;
    }

    @RequestMapping(value = "/saveUser", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> save(HttpServletRequest request, UserModel user) throws Exception {
        Map<String, Object> map = new HashMap<>();

        int result = iUser.addUser(user);
        if (result > 0) {
            map.put("success", true);
        } else {
            map.put("success", false);
            map.put("message", "保存失败");
        }
        return map;
    }

    @RequestMapping("/add")
    public ModelAndView add(HttpServletRequest httpRequest, HttpServletResponse httpResponse, UserModel user, SplitPageRequest pageRequest) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);
        mav.setViewName("system/user/saveUser");
        return mav;
    }

    @RequestMapping("/edit")
    public ModelAndView edit(HttpServletRequest httpRequest, HttpServletResponse httpResponse, UserModel user, SplitPageRequest pageRequest) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);
        mav.setViewName("system/user/saveUser");
        return mav;
    }

}
