package cn.edu.ccu.manage.controller.exam;

import cn.edu.ccu.ibusiness.exam.IExam;
import cn.edu.ccu.ibusiness.exam.IQuestion;
import cn.edu.ccu.ibusiness.student.ISRole;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.AuthHelper;
import cn.edu.ccu.manage.utils.AuthMethod;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.exam.*;
import cn.edu.ccu.model.user.UserModel;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/25.
 */
@Controller
@AuthController(moduleId = 13)
@RequestMapping("/exam")
public class ExamController extends BaseController {

    @Autowired
    private IExam iExam;
    @Autowired
    private IQuestion iQuestion;
    @Autowired
    private ISRole isRole;

    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    @AuthMethod
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                             ExamModel examModel, SplitPageRequest pageRequest) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        ExamListRequest request = new ExamListRequest();
        request.setExamModel(examModel);
        pageRequest.setReturnCount(true);
        request.setSplitPageRequest(pageRequest);
        request.setWithUser(true);
        ExamListResponse response = iExam.splitByPage(request);
        mav.addObject("response", response);

        mav.addObject("sRoleList", isRole.list());
        mav.addObject("question", examModel);
        mav.setViewName("/exam/list");
        return mav;
    }

    @AuthMethod
    @RequestMapping("/add")
    public ModelAndView add(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);


        mav.addObject("sRoleList", isRole.list());

        mav.setViewName("exam/edit");
        return mav;
    }

    @AuthMethod
    @RequestMapping("/edit")
    public ModelAndView edit(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            Integer id) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        mav.addObject("exam", iExam.getById(id));
        mav.addObject("sRoleList", isRole.list());

        mav.setViewName("exam/edit");
        return mav;
    }


    @AuthMethod
    @RequestMapping(value = "/addOrUpdate", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> addOrUpdate(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            ExamModelWithBLOBs model,
            String startTimeString,String endTimeString,
            String[] singleChoiceArray, String[] multipleChoiceArray, String[] tofArray) throws Exception {

        if(!StringExtention.isTrimNullOrEmpty(startTimeString))
            model.setStartTime(sdf.parse(startTimeString));
        if(!StringExtention.isTrimNullOrEmpty(endTimeString))
            model.setEndTime(sdf.parse(endTimeString));

        UserModel loginUserModel = AuthHelper.getLoginUserModel(httpRequest);
        model.setCreateUser(loginUserModel.getUserId());

        Map<String, Object> map = new HashMap<>();
        boolean i;
        if (httpRequest.getParameter("isUpdate") == null) {
            model.setCreateUser(loginUserModel.getUserId());
            i = iExam.addExam(model, singleChoiceArray, multipleChoiceArray, tofArray);
        } else {
            i = iExam.updateExam(model, singleChoiceArray, multipleChoiceArray, tofArray);
        }
        map.put("success", i);

        return map;
    }

    @RequestMapping("/del")
    public
    @ResponseBody
    Map<String, Object> del(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            Integer id) throws Exception {

        boolean i = false;
        Map<String, Object> map = new HashMap<>();
        if (IntegerExtention.hasValueAndMaxZero(id)) {
            i = iExam.deleteExam(id);
        }
        map.put("success", i);

        return map;
    }


    @RequestMapping(value = "/searchQuestion", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> searchQuestion(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            String text, Integer type) throws Exception {

        Map<String, Object> map = new HashMap<>();
        map.put("success", false);

        if (!StringExtention.isTrimNullOrEmpty(text)) {
            List<QuestionModel> questionModelList = iQuestion.searchQuestion(text, type);

            map.put("list", questionModelList);
            map.put("success", questionModelList != null && questionModelList.size() > 0);
        }

        return map;
    }

    @RequestMapping(value="selectAllQuestion")
    @ResponseBody
   public Map selectAllQuestion(@RequestParam(value="type") Integer type){
        Map reMap = new HashMap();
        try {
            Map map = iExam.selectAllQuestion(type);
            List questionList = (List)map.get("questionList");
            reMap.put("questionList", questionList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reMap;
    }

    @RequestMapping(value="/seacherQuestionByQuestion")
    @ResponseBody
    public Map seacherQuestionByQuestion(@RequestParam(value="question") String question, @RequestParam(value="type") Integer type){
        Map reMap = new HashMap();
        Map map = null;
        try {
            if(question != null && !question.equals("")) {
                map = iExam.seacherQuestionByQuestion(question);
            }else{
                map = iExam.selectAllQuestion(type);
            }
            List questionList = (List)map.get("questionList");
            reMap.put("questionList", questionList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reMap;
    }
}
