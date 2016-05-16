package cn.edu.ccu.school.controller;

import cn.edu.ccu.ibusiness.exam.IExam;
import cn.edu.ccu.ibusiness.statistic.IStatistic;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.exam.ExamListRequest;
import cn.edu.ccu.model.exam.ExamListResponse;
import cn.edu.ccu.model.exam.ExamModel;
import cn.edu.ccu.model.exam.QuestionStatus;
import cn.edu.ccu.model.student.StudentModel;
import cn.edu.ccu.school.utils.AuthController;
import cn.edu.ccu.school.utils.AuthHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by kuangye on 2016/4/30.
 */
@Controller
@AuthController(moduleId = -1)
public class StatisticController extends BaseController {


    @Autowired
    private IStatistic iStatistic;

    @RequestMapping("/statistic")
    public ModelAndView statistic(HttpServletRequest httpRequest, HttpServletResponse httpResponse) {

        ModelAndView mav = super.getModelAndView("/statistic/statistic", httpRequest);



        //不分页
        //完成课程排行榜
        mav.addObject("courseTop", iStatistic.getCourseCountTopStudent(null));

        //视频观看排行榜
        mav.addObject("watchTop", iStatistic.getCourseWatchCount());

        return mav;
    }


}
