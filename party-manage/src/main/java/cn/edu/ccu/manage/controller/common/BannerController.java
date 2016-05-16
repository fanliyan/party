package cn.edu.ccu.manage.controller.common;

import cn.edu.ccu.ibusiness.common.IBannerConfig;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.common.BannerConfigModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
@AuthController(moduleId = 17)
@RequestMapping("/banner")
public class BannerController extends BaseController {

    @Autowired
    IBannerConfig iBannerConfig;

    /**
     * BANNER 列表
     */
    @RequestMapping("/list")
    public ModelAndView list(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {

        ModelAndView mav = Common.getLoginModelAndView(httpRequest);


        List<BannerConfigModel> bannerConfigModelList = iBannerConfig.select();

        mav.addObject("bannerList", bannerConfigModelList);

        mav.setViewName("banner/bannerList");
        return mav;
    }


    /**
     * 添加 BANNER
     */
    @RequestMapping("/add")
    public ModelAndView addArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);


        mav.setViewName("banner/bannerEdit");
        return mav;
    }


    /**
     * 编辑 BANNER
     */
    @RequestMapping("/edit")
    public ModelAndView editArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            @RequestParam("id") Integer id) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);


        mav.addObject("banner", iBannerConfig.selectById(id));

        mav.setViewName("banner/bannerEdit");
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
            BannerConfigModel model) throws Exception {

        Map<String, Object> map = new HashMap<>();
        boolean i;

        if (httpRequest.getParameter("isUpdate") == null) {
            i = iBannerConfig.insert(model);
        } else {
            i = iBannerConfig.update(model);
        }
        map.put("success", i);

        return map;
    }


    /**
     * 删除 banner
     */
    @RequestMapping("/del")
    public
    @ResponseBody
    Map<String, Object> del(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            Integer id) throws Exception {

        Map<String, Object> map = new HashMap<>();

        boolean i = iBannerConfig.delete(id);

        map.put("success", i);

        return map;
    }
}
