package cn.edu.ccu.manage.utils;


import cn.edu.ccu.ibusiness.system.ISysLog;
import cn.edu.ccu.ibusiness.system.IUser;
import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.system.LogType;
import cn.edu.ccu.model.system.ModuleModel;
import cn.edu.ccu.model.user.UserModel;
import cn.edu.ccu.utils.common.SecurityHelper;
import cn.edu.ccu.utils.common.web.WebHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class AuthHelper {

    private static ISysLog iLog;
    private static IUser iUser;

    @Autowired
    public void setILog(ISysLog iLog) {
        AuthHelper.iLog = iLog;
    }

    @Autowired
    public void setIUser(IUser iUser) {
        AuthHelper.iUser = iUser;
    }

    public static UserModel getLoginUserModel(HttpServletRequest request) {
        UserModel userModel = null;
        // 先判断Session
        HttpSession session = request.getSession();
        if (session.getAttribute("manageLoginUser") == null) {
            String cookie = WebHelper.getCookie(request, "manageLoginUser");
            if (cookie != null && !cookie.equals("")) {
                // 如果有Cookie，解密
                cookie = SecurityHelper.desDecrypt(cookie, WebProperties.getSecurityKey());
                if (cookie != null && !cookie.equals("")) {
                    // 根据IP和UserAgent判断是否为伪造的Cookie
                    String[] cookies = cookie.split("\\|");
                    if (cookies.length == 3) {
                        if (!WebHelper.getIp(request).equals(cookies[1]) || !request.getHeader("user-agent").equals(cookies[2])) {
                            iLog.addLog(LogType.LoginFail, String.format("伪造Cookie登录！用户ID:%s", cookies[0]), WebHelper.getIp(request));

                            throw new BusinessException("异常登录状态，非法操作，您的操作已经被记录");
                        } else {
                            RequestHead requestHead = new RequestHead();
                            requestHead.setUserIp(WebHelper.getIp(request));
                            userModel = iUser.getUserById(Integer.parseInt(cookies[0]));
                        }
                    }
                }

            }
        } else {
            userModel = (UserModel) session.getAttribute("manageLoginUser");

        }
        return userModel;
    }

    public static boolean isLogin(HttpServletRequest request) throws Exception {
        return getLoginUserModel(request) != null;
    }

    public static void setLoginUser(HttpServletRequest request, HttpServletResponse response, UserModel loginUserModel) throws Exception {
        RequestHead requestHead = new RequestHead();
        requestHead.setUserIp(WebHelper.getIp(request));
        if (loginUserModel != null) {
            String cookieValue = String.format("%s|%s|%s",
                    loginUserModel.getUserId(),
                    WebHelper.getIp(request),
                    request.getHeader("user-agent")
            );
            cookieValue = SecurityHelper.desEncrypt(cookieValue, WebProperties.getSecurityKey());

            WebHelper.setCookie(response, "manageLoginUser", cookieValue);

            HttpSession session = request.getSession();
            session.setAttribute("manageLoginUser", loginUserModel);
        }
    }

    public static void refreshLoginUser(Integer userid, HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestHead requestHead = new RequestHead();
        requestHead.setUserIp(WebHelper.getIp(request));
        UserModel userModel = iUser.getUserDetailById(userid);
        setLoginUser(request, response, userModel);
    }

    public static void delLoginUser(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        session.removeAttribute("LoginUser");
        WebHelper.delCookie(response, "LoginUser");
    }


    public static boolean hasModule(UserModel userModel, int moduleid) {
        boolean resultValue = false;
        if (userModel != null && userModel.getHasModules() != null) {
            for (ModuleModel moduleModel : userModel.getHasModules())
                if (moduleModel.getModuleId().equals(moduleid))
                    resultValue = true;
        }
        return resultValue;
    }

    public static ModuleModel getModel(UserModel userModel, int moduleid) {
        if (userModel == null || userModel.getHasModules() == null) {
            return null;
        } else {
            for (ModuleModel moduleModel : userModel.getHasModules())
                if (moduleModel.getModuleId().equals(moduleid))
                    return moduleModel;
        }

        return null;
    }

}
