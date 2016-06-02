package cn.edu.ccu.manage.controller.sensitiveword;

import cn.edu.ccu.ibusiness.word.ISensitiveWords;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.AuthMethod;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.word.SensitiveWordListResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/28.
 */
@Controller
@RequestMapping("/sensitiveword")
@AuthController(moduleId = 15)
public class SensitiveWordController extends BaseController {

@Autowired
private ISensitiveWords iSensitiveWords;

    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                                String name, SplitPageRequest pageRequest) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        pageRequest.setReturnCount(true);
        SensitiveWordListResponse listResponse=iSensitiveWords.list(pageRequest,name);

        mav.addObject("name",name);
        mav.addObject("response", listResponse);

        mav.setViewName("word/list");
        return mav;
    }

    @AuthMethod
    @RequestMapping(value = "/add",method = RequestMethod.POST)
    public @ResponseBody
    Map<String,Object> add(String name) throws Exception {

        Map<String,Object> map = new HashMap<>();

        map.put("success",iSensitiveWords.add(name));
        return map;
    }

    @AuthMethod
    @RequestMapping(value = "/del",method = RequestMethod.POST)
    public @ResponseBody
    Map<String,Object> del(Integer id) throws Exception {

        Map<String,Object> map = new HashMap<>();

        map.put("success",iSensitiveWords.delete(id));
        return map;
    }
}
