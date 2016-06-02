package cn.edu.ccu.manage.controller.common;

import cn.edu.ccu.ibusiness.common.IBranch;
import cn.edu.ccu.ibusiness.common.IXi;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.common.BranchModel;
import cn.edu.ccu.model.common.XiModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
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
@RequestMapping("/branch")
@AuthController(moduleId = -1)
public class BranchController extends BaseController {

    @Autowired
    private IBranch iBranch;

    /**
     *  列表
     */
    @RequestMapping("/list/{id}")
    public ModelAndView list(@PathVariable("id")Integer id,
            HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {

        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        List<BranchModel> branchModelList = iBranch.getByDepartmentId(id);

        mav.addObject("list", branchModelList);
        mav.addObject("id",id);

        mav.setViewName("branch/list");
        return mav;
    }


    /**
     * 添加
     */
    @RequestMapping("/add/{id}")
    public ModelAndView addArticleCategoriesType(@PathVariable("id")Integer id,
            HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        mav.addObject("id",id);
        mav.setViewName("branch/edit");
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

       BranchModel branchModel =  iBranch.getById(id);
        mav.addObject("branch", branchModel);

        mav.addObject("id",branchModel.getDepartmentId());

        mav.setViewName("branch/edit");
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
            BranchModel model) throws Exception {

        Map<String, Object> map = new HashMap<>();
        boolean i;

        if (httpRequest.getParameter("isUpdate") == null) {
            i = iBranch.add(model);
        } else {
            i = iBranch.edit(model);
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

        boolean i = iBranch.delete(id);

        map.put("success", i);

        return map;
    }


}
