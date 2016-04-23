package cn.edu.ccu.school.controller;

import cn.edu.ccu.ibusiness.faq.IFAQ;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.faq.FAQListRequest;
import cn.edu.ccu.model.faq.FAQListResponse;
import cn.edu.ccu.model.faq.FAQModel;
import cn.edu.ccu.model.faq.FAQStatus;
import cn.edu.ccu.model.student.StudentModel;
import cn.edu.ccu.school.utils.AuthController;
import cn.edu.ccu.school.utils.AuthHelper;
import cn.edu.ccu.school.utils.AuthMethod;
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
 * Created by Administrator on 2016/4/23.
 */
@Controller
@RequestMapping("/faq")
@AuthController(moduleId = -1)
public class FAQController extends BaseController {


    @Autowired
    private IFAQ ifaq;

    @AuthMethod
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                            Integer askId,String question, SplitPageRequest pageRequest){

        ModelAndView mav = super.getModelAndView("/faq/list",httpRequest);

        FAQListRequest faqListRequest = new FAQListRequest();
        FAQModel faqModel = new FAQModel();
        faqModel.setQuestion(question);
        faqModel.setAskUserId(askId);
        faqModel.setStatus(FAQStatus.ANSWERED);
        faqListRequest.setFaqModel(faqModel);
        pageRequest.setReturnCount(true);
        faqListRequest.setWithUser(true);
        faqListRequest.setSplitPageRequest(pageRequest);

        FAQListResponse response = ifaq.select(faqListRequest);

        mav.addObject("response",response);
        return mav;
    }


    @AuthMethod
    @RequestMapping(value = "/askquestion",method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String,Object> askQuestion(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                                   String question){

        Map<String,Object> map = new HashMap<>();
        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);

        FAQModel faqModel = new FAQModel();
        faqModel.setQuestion(question);
        faqModel.setAskUserId(studentModel.getId());

        boolean tag = ifaq.askAQuestion(faqModel);

        map.put("success",tag);
        return map;
    }

}
