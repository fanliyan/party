package cn.edu.ccu.school.controller;

import cn.edu.ccu.ibusiness.exam.IScore;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.exam.ScoreListResponse;
import cn.edu.ccu.model.student.StudentModel;
import cn.edu.ccu.school.utils.AuthController;
import cn.edu.ccu.school.utils.AuthHelper;
import cn.edu.ccu.school.utils.AuthMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by kuangye on 2016/5/4.
 */
@Controller
@AuthController(moduleId = -1)
@RequestMapping("/profile")
public class ProfileController extends BaseController {


    @Autowired
    private IScore iScore;

    @AuthMethod
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse, SplitPageRequest splitPageRequest) {

        ModelAndView mav = super.getModelAndView("profile/list", httpRequest);

        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);

        splitPageRequest.setReturnCount(true);
        ScoreListResponse response = iScore.myScoreList(studentModel.getId(), splitPageRequest);

        mav.addObject("response", response);
        return mav;
    }

}
