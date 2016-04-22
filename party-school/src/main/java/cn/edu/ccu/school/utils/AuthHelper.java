package cn.edu.ccu.school.utils;


import cn.edu.ccu.ibusiness.student.IStudent;
import cn.edu.ccu.ibusiness.system.ISysLog;
import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.student.StudentModel;
import cn.edu.ccu.model.system.LogType;
import cn.edu.ccu.utils.common.web.WebHelper;
import cn.edu.ccu.utils.common.SecurityHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class AuthHelper {

    private static ISysLog iLog;
    private static IStudent iStudent;

    @Autowired
    public void setILog(ISysLog iLog) {
        AuthHelper.iLog = iLog;
    }

    @Autowired
    public void setIStudent(IStudent iStudent) {
        AuthHelper.iStudent = iStudent;
    }

    public static StudentModel getLoginUserModel(HttpServletRequest request) {
        StudentModel userModel = null;
        // 先判断Session
        HttpSession session = request.getSession();
        if (session.getAttribute("LoginUser") == null) {
            String cookie = WebHelper.getCookie(request, "LoginUser");
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
                            userModel = iStudent.getStudentById(Integer.parseInt(cookies[0]));
                        }
                    }
                }

            }
        } else {
            userModel = (StudentModel) session.getAttribute("LoginUser");

        }
        return userModel;
    }

    public static boolean isLoginSystem(HttpServletRequest request) throws Exception {
        return getLoginUserModel(request) != null;
    }

    public static void setLoginUser(HttpServletRequest request, HttpServletResponse response, StudentModel loginUserModel) throws Exception {
        RequestHead requestHead = new RequestHead();
        requestHead.setUserIp(WebHelper.getIp(request));
        if (loginUserModel != null) {
            String cookieValue = String.format("%s|%s|%s",
                    loginUserModel.getId(),
                    WebHelper.getIp(request),
                    request.getHeader("user-agent")
            );
            cookieValue = SecurityHelper.desEncrypt(cookieValue, WebProperties.getSecurityKey());

            WebHelper.setCookie(response, "LoginUser", cookieValue);

            HttpSession session = request.getSession();
            session.setAttribute("LoginUser", loginUserModel);
        }
    }

    public static void refreshLoginUser(Integer userid, HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestHead requestHead = new RequestHead();
        requestHead.setUserIp(WebHelper.getIp(request));
        StudentModel userModel = iStudent.getStudentById(userid);
        setLoginUser(request, response, userModel);
    }

    public static void delLoginUser(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        session.removeAttribute("LoginUser");
        WebHelper.delCookie(response, "LoginUser");
    }


}
