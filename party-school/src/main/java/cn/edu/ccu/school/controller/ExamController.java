package cn.edu.ccu.school.controller;

import cn.edu.ccu.ibusiness.exam.IExam;
import cn.edu.ccu.ibusiness.exam.IQuestion;
import cn.edu.ccu.ibusiness.student.ISRole;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.exam.ExamListRequest;
import cn.edu.ccu.model.exam.ExamListResponse;
import cn.edu.ccu.model.exam.ExamModel;
import cn.edu.ccu.model.exam.QuestionStatus;
import cn.edu.ccu.model.student.StudentModel;
import cn.edu.ccu.school.utils.AuthController;
import cn.edu.ccu.school.utils.AuthHelper;
import cn.edu.ccu.school.utils.AuthMethod;
import cn.edu.ccu.utils.common.web.RequestHelper;
import cn.edu.ccu.utils.common.web.RequestParamHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/26.
 */
@Controller
@RequestMapping("/exam")
@AuthController(moduleId = -1)
public class ExamController extends BaseController {

    @Autowired
    private IExam iExam;

    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    @AuthMethod
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                             ExamModel examModel, SplitPageRequest pageRequest) throws Exception {

        ModelAndView mav = super.getModelAndView("/exam/list", httpRequest);

        ExamListRequest request = new ExamListRequest();
        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);
        examModel.setRoleId(studentModel.getsRoleModel().getRoleId());
        examModel.setStatus(QuestionStatus.PUBLIC);
        request.setExamModel(examModel);
        pageRequest.setReturnCount(true);
        request.setInTime(true);
        request.setSplitPageRequest(pageRequest);

        ExamListResponse response = iExam.splitByPage(request);
        mav.addObject("response", response);

        mav.addObject("question", examModel);
        mav.setViewName("/exam/list");
        return mav;
    }


    /**
     * 开始考试
     */
    @AuthMethod
    @RequestMapping("/start/{id}")
    public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                             @PathVariable("id") Integer id) throws Exception {

        ModelAndView mav = super.getModelAndView("/exam/list", httpRequest);

        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);

        Map<String, Object> map = iExam.startExam(studentModel.getId(), studentModel.getsRoleModel().getRoleId(), id);

        mav.addAllObjects(map);

        mav.setViewName("/exam/exam");
        return mav;
    }


    /**
     * 考试结束
     */
    @AuthMethod
    @RequestMapping("/end")
    public
    @ResponseBody
    Map<String, Object> end(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {

        Map<String, Object> map = new HashMap<>();

        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);

        Integer id = RequestParamHelper.getInteger(httpRequest, "examId");

        boolean tag = iExam.examEnd(studentModel.getId(), studentModel.getsRoleModel().getRoleId(), id, httpRequest);

        map.put("success", tag);

        return map;
    }


}
