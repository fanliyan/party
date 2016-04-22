package cn.edu.ccu.index.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by ky on 2016/4/15.
 */
@Controller
public class MainController extends BaseController {

    @RequestMapping("/")
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response){

        ModelAndView mav = super.getModelAndView("index",request);

        return mav;
    }

}
