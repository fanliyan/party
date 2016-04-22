package cn.edu.ccu.school.utils;

import cn.edu.ccu.school.controller.BaseController;
import cn.edu.ccu.model.student.StudentModel;
import cn.edu.ccu.utils.common.StringHelper;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

public class AuthorityAnnotationInterceptor extends HandlerInterceptorAdapter {

    final Logger logger = LoggerFactory.getLogger(getClass());
    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        AuthController authController = null;
        AuthMethod authMethod;
        boolean result = false;

        // 方法注解
        HandlerMethod handler2 = (HandlerMethod) handler;
        authMethod = handler2.getMethodAnnotation(AuthMethod.class);

        Object controllerHandler = handler2.getBean();
        // 取controller注解
        if (controllerHandler instanceof BaseController) {
            authController = ((BaseController) handler2.getBean()).getClass().getAnnotation(AuthController.class);
        }
        Integer moduleId = -1;
        if (!StringHelper.isEmptyString(request.getParameter("moduleId")) && StringHelper.isEmptyString(request.getAttribute("message"))) {
            moduleId = Integer.valueOf(request.getParameter("moduleId"));
        }

        logger.debug("AuthorityAnnotationInterceptor", "start");

        // 未声明权限

        if (authController == null) {
            Message.showError(request, response, "此模块未做过权限设置，禁止访问，请联系移民帮技术部", false);
        } else if (authMethod != null && !authMethod.mustLogin()) {
            result = true;
        } else {
            // 未登录
            StudentModel loginUserModel = AuthHelper.getLoginUserModel(request);
            if (loginUserModel != null) {
                if (authController.moduleId() != -1) {
                    moduleId = authController.moduleId();
                }
                if (moduleId != -1) {// 说明有权限认证 或者是报表
                    // 检查模块权限
                    if (loginUserModel.getsRoleModel().getRoleId() != null && !loginUserModel.getsRoleModel().getRoleId().equals(moduleId)) {
                        Message.showError(request, response, "禁止访问！您无权访问此模块！", false);
                        return false;
                    } else {
//						// 当前ModuleId和GroupID写入Cookie
//						ModulesModel model = AuthHelper.getModel(loginUserModel, moduleId);
//						if (model != null) {
//							WebHelper.setCookie(response, "activeGroupMenu", model.getModuleGroupId().toString());
//							WebHelper.setCookie(response, "activeMenu", model.getModuleId().toString());
//						} else {
//							WebHelper.delCookie(response, "activeGroupMenu");
//							WebHelper.delCookie(response, "activeMenu");
//						}
                        result = true;
                    }
                } else {
                    result = true;
                }
            }
        }

        if (!result) {
            boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
            if (isAjax) {
                response.setCharacterEncoding("UTF-8");
                response.setContentType("application/json; charset=utf-8");
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("success", false);
                map.put("message", "请登录后再进行操作");
                OutputStream ps = null;
                try {
                    ps = response.getOutputStream();
                    ps.write(objectMapper.writeValueAsString(map).getBytes("UTF-8"));
                } catch (IOException e) {
                    //
                } finally {
                    if (ps != null) {
                        try {
                            ps.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
            } else {
                if (!response.isCommitted()) {
                    response.sendRedirect(request.getContextPath() + "/main/login?backurl=" + request.getRequestURI());
                }
            }
        }
        return result;
    }
}
