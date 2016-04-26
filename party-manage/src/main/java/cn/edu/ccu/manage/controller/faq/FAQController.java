package cn.edu.ccu.manage.controller.faq;

import cn.edu.ccu.ibusiness.faq.IFAQ;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.AuthHelper;
import cn.edu.ccu.manage.utils.AuthMethod;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.faq.FAQListRequest;
import cn.edu.ccu.model.faq.FAQListResponse;
import cn.edu.ccu.model.faq.FAQModel;
import cn.edu.ccu.model.faq.FAQStatus;
import cn.edu.ccu.model.student.StudentModel;
import cn.edu.ccu.model.user.UserModel;
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
 * Created by kuangye on 2016/4/23.
 */
@Controller
@RequestMapping("/faq")
@AuthController(moduleId = 11)
public class FAQController extends BaseController {


    @Autowired
    private IFAQ ifaq;

    @AuthMethod
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                             Integer askId, String question, SplitPageRequest pageRequest) throws Exception {

        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        FAQListRequest faqListRequest = new FAQListRequest();
        FAQModel faqModel = new FAQModel();
        faqModel.setQuestion(question);
        faqModel.setAskUserId(askId);
        faqModel.setStatus(FAQStatus.ASK);
        faqListRequest.setFaqModel(faqModel);
        pageRequest.setReturnCount(true);
        faqListRequest.setSplitPageRequest(pageRequest);
        faqListRequest.setWithUser(true);

        FAQListResponse response = ifaq.select(faqListRequest);

        mav.addObject("response", response);
        return mav;
    }


    @AuthMethod
    @RequestMapping(value = "/answer", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> askQuestion(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                                   Integer id, String answer) {

        Map<String, Object> map = new HashMap<>();
        UserModel userModel = AuthHelper.getLoginUserModel(httpRequest);

        FAQModel faqModel = new FAQModel();
        faqModel.setId(id);
        faqModel.setAnswer(answer);
        faqModel.setAnswerUserId(userModel.getUserId());

        boolean tag = ifaq.answerAQuestion(faqModel);

        map.put("success", tag);
        return map;
    }

}
