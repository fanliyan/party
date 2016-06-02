package cn.edu.ccu.manage.controller.common;

import cn.edu.ccu.ibusiness.common.IDepartment;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.common.DepartmentModel;
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
 * Created by kuangye on 2016/5/18.
 */
@Controller
@RequestMapping("/department")
@AuthController(moduleId = 19)
public class DepartmentController extends BaseController {

    @Autowired
    private IDepartment iDepartment;

    /**
     *  列表
     */
    @RequestMapping("/list")
    public ModelAndView list(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {

        ModelAndView mav = Common.getLoginModelAndView(httpRequest);


        List<DepartmentModel> departmentModelList = iDepartment.select();

        mav.addObject("list", departmentModelList);

        mav.setViewName("department/list");
        return mav;
    }


    /**
     * 添加
     */
    @RequestMapping("/add")
    public ModelAndView addArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);


        mav.setViewName("department/edit");
        return mav;
    }


    /**
     * 编辑
     */
    @RequestMapping("/edit")
    public ModelAndView editArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            @RequestParam("id") Integer id) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);


        mav.addObject("department", iDepartment.getById(id));

        mav.setViewName("department/edit");
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
            DepartmentModel model) throws Exception {

        Map<String, Object> map = new HashMap<>();
        boolean i;

        if (httpRequest.getParameter("isUpdate") == null) {
            i = iDepartment.add(model);
        } else {
            i = iDepartment.edit(model);
        }
        map.put("success", i);

        return map;
    }


    /**
     * 删除
     */
    @RequestMapping("/del")
    public
    @ResponseBody
    Map<String, Object> del(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            Integer id) throws Exception {

        Map<String, Object> map = new HashMap<>();

        boolean i = iDepartment.delete(id);

        map.put("success", i);

        return map;
    }


}
