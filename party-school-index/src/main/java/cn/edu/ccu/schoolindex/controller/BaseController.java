package cn.edu.ccu.schoolindex.controller;

import cn.edu.ccu.schoolindex.utils.WebProperties;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.utils.common.LogHelper;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;


public class BaseController {

    private Logger logger = Logger.getLogger(this.getClass());
    ObjectMapper objectMapper = new ObjectMapper();


    ModelAndView getModelAndView(String name, HttpServletRequest httpRequest) {
        ModelAndView mav = new ModelAndView(name);

//        mav.addObject("isFromApp", AppHelper.isFromApp(httpRequest));
//        mav.addObject("platform", AppHelper.getPlatForm(httpRequest));

        return mav;
    }



    @ExceptionHandler
    public void ExceptionProcess(HttpServletRequest request, HttpServletResponse response, Exception ex) {

        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        boolean isDebug = WebProperties.getIsDebug();

        Map<String, Object> map = new HashMap<>();
        map.put("success", false);
        if (ex instanceof BusinessException) {
            BusinessException be = (BusinessException) ex;
            map.put("message", be.getMessage());
        } else {

            if (!isDebug) {
//                iLog.addLog(LogType.Execption, ex.toString(), getRequestHead(request));
                logger.error(ex);
                map.put("message", "应用程序程序异常");
            } else {
                map.put("message", "[debug状态开启]" + ex.getMessage());
            }
        }

        LogHelper.Error(ex.getMessage(), ex);

        if (isAjax) {
            OutputStream ps = null;
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/json; charset=utf-8");
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
            try {
                response.sendRedirect(request.getContextPath()+"/html/error.html");
            }catch (IOException e){
                e.printStackTrace();
            }
        }
    }


}
