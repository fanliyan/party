package cn.edu.ccu.manage.controller.exam;

import cn.edu.ccu.ibusiness.exam.IScore;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.AuthHelper;
import cn.edu.ccu.manage.utils.AuthMethod;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.exam.ScoreListResponse;
import cn.edu.ccu.model.student.StudentModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by kuangye on 2016/5/6.
 */
@Controller
@AuthController(moduleId = 16)
@RequestMapping("/score")
public class ScoreController extends BaseController {



    @Autowired
    private IScore iScore;

    @AuthMethod
    @RequestMapping(value = "/list")
    public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                             SplitPageRequest splitPageRequest,StudentModel studentModel) throws Exception{

        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        splitPageRequest.setReturnCount(true);
        ScoreListResponse response = iScore.scoreList(studentModel, splitPageRequest);

        mav.addObject("response", response);
        mav.setViewName("score/list");
        return mav;
    }
}
