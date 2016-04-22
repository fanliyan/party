package cn.edu.ccu.school.controller;

import cn.edu.ccu.school.utils.AuthController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/error")
@AuthController(moduleId = -1)
public class ErrorController extends BaseController {

    @RequestMapping("/show")
    public ModelAndView Show(HttpServletRequest httpRequest, HttpServletResponse httpResponse) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("message",httpRequest.getAttribute("message"));
        mav.addObject("showBackButton", httpRequest.getAttribute("showBackButton"));
        mav.setViewName("common/error");
        return mav;
    }
}
