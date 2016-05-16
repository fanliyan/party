package cn.edu.ccu.school.controller;

import cn.edu.ccu.ibusiness.exam.IQuestion;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.exam.QuestionListRequest;
import cn.edu.ccu.model.exam.QuestionListResponse;
import cn.edu.ccu.model.exam.QuestionModel;
import cn.edu.ccu.model.exam.QuestionStatus;
import cn.edu.ccu.model.student.StudentModel;
import cn.edu.ccu.school.utils.AuthController;
import cn.edu.ccu.school.utils.AuthHelper;
import cn.edu.ccu.school.utils.AuthMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/26.
 */
@Controller
@RequestMapping("/question")
@AuthController(moduleId = -1)
public class QuestionController extends BaseController {

    @Autowired
    private IQuestion iQuestion;


    @AuthMethod
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                             QuestionModel questionModel, SplitPageRequest pageRequest) throws Exception {

        ModelAndView mav = super.getModelAndView("/question/list", httpRequest);
        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);

        QuestionListRequest request = new QuestionListRequest();
        request.setQuestionModel(questionModel);
        pageRequest.setReturnCount(true);
        request.setSplitPageRequest(pageRequest);
//        request.setWithUserRole(true);

        questionModel.setRoleId(studentModel.getsRoleModel().getRoleId());
        questionModel.setStatus(QuestionStatus.PUBLIC);

        QuestionListResponse response = iQuestion.splitByPage(request);
        mav.addObject("response", response);

        mav.addObject("question", questionModel);
        mav.setViewName("/question/list");
        return mav;
    }


    @AuthMethod
    @RequestMapping(value = "/watch/{id}",method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String,Object> watch(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                             @PathVariable("id") Integer id, SplitPageRequest pageRequest) throws Exception {

        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);

        Map<String,Object>  map = new HashMap<>();
        QuestionModel model = new QuestionModel();
        model.setId(id);
        model.setStatus(QuestionStatus.PUBLIC);
        model.setRoleId(studentModel.getsRoleModel().getRoleId());

        QuestionModel questionModel = iQuestion.getByMap(model);
        map.put("question", questionModel);

        map.put("success", true);
        return map;
    }

}
