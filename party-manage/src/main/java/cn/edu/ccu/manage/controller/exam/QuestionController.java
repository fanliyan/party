package cn.edu.ccu.manage.controller.exam;

import cn.edu.ccu.ibusiness.exam.IQuestion;
import cn.edu.ccu.ibusiness.student.ISRole;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.AuthHelper;
import cn.edu.ccu.manage.utils.AuthMethod;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.exam.QuestionListRequest;
import cn.edu.ccu.model.exam.QuestionListResponse;
import cn.edu.ccu.model.exam.QuestionModel;
import cn.edu.ccu.model.user.UserModel;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
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
 * Created by kuangye on 2016/4/24.
 */
@Controller
@AuthController(moduleId = 12)
@RequestMapping("/question")
public class QuestionController extends BaseController{


    @Autowired
    private IQuestion iQuestion;
    @Autowired
    private ISRole isRole;

    @AuthMethod
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                             QuestionModel questionModel, SplitPageRequest pageRequest) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        QuestionListRequest request = new QuestionListRequest();
        request.setQuestionModel(questionModel);
        pageRequest.setReturnCount(true);
        request.setSplitPageRequest(pageRequest);
        request.setWithUserRole(true);
        QuestionListResponse response = iQuestion.splitByPage(request);
        mav.addObject("response", response);

        mav.addObject("sRoleList", isRole.list());
        mav.addObject("question", questionModel);
        mav.setViewName("/question/list");
        return mav;
    }

    @AuthMethod
    @RequestMapping("/add")
    public ModelAndView add(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);


        mav.addObject("sRoleList", isRole.list());

        mav.setViewName("question/edit");
        return mav;
    }

    @AuthMethod
    @RequestMapping("/edit")
    public ModelAndView edit(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            Integer id) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        mav.addObject("question", iQuestion.getById(id));
        mav.addObject("sRoleList", isRole.list());

        mav.setViewName("question/edit");
        return mav;
    }


    @AuthMethod
    @RequestMapping(value = "/addOrUpdate", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> addOrUpdate(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            QuestionModel model,String[] answerNameArray, String[] rightAnswerArray) throws Exception {

        UserModel loginUserModel = AuthHelper.getLoginUserModel(httpRequest);

        Map<String, Object> map = new HashMap<>();
        boolean i;
        if (httpRequest.getParameter("isUpdate") == null) {
            model.setCreateUser(loginUserModel.getUserId());
            i = iQuestion.addQuestion(model,answerNameArray,rightAnswerArray);
        } else {
            i = iQuestion.updateQuestion(model,answerNameArray,rightAnswerArray);
        }
        map.put("success", i);

        return map;
    }

    @AuthMethod
    @RequestMapping("/del")
    public
    @ResponseBody
    Map<String, Object> del(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            Integer id) throws Exception {

        boolean i = false;
        Map<String, Object> map = new HashMap<>();
        if (IntegerExtention.hasValueAndMaxZero(id)) {
            i = iQuestion.deleteQuestion(id);
        }
        map.put("success", i);

        return map;
    }
}
