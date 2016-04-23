package cn.edu.ccu.school.controller;

import cn.edu.ccu.ibusiness.course.ITask;
import cn.edu.ccu.model.course.TaskModel;
import cn.edu.ccu.model.student.StudentModel;
import cn.edu.ccu.school.utils.AuthController;
import cn.edu.ccu.school.utils.AuthHelper;
import cn.edu.ccu.school.utils.AuthMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by Administrator on 2016/4/22.
 */
@Controller
@AuthController(moduleId = -1)
@RequestMapping("/task")
public class TaskController extends BaseController {


    @Autowired
    private ITask iTask;

    //我的任务
    @AuthMethod
    @RequestMapping("/mytask")
    public ModelAndView myTask(HttpServletRequest httpRequest, HttpServletResponse httpResponse) {

        ModelAndView mav = super.getModelAndView("/task/myTask", httpRequest);
        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);

        List<TaskModel> taskModelList = iTask.getMyTaskDetail(studentModel.getId());

        mav.addObject("taskModelList", taskModelList);
        return mav;
    }

}
