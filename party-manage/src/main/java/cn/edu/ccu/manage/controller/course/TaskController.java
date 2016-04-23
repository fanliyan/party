package cn.edu.ccu.manage.controller.course;

import cn.edu.ccu.ibusiness.course.ITask;
import cn.edu.ccu.ibusiness.student.IStudentRole;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.course.TaskListRequest;
import cn.edu.ccu.model.course.TaskListResponse;
import cn.edu.ccu.model.course.TaskModel;
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
import java.util.Map;

/**
 * Created by Administrator on 2016/4/22.
 */
@Controller
@RequestMapping("/task")
@AuthController(moduleId = 9)
public class TaskController extends BaseController {

    @Autowired
    private ITask iTask;
    @Autowired
    private IStudentRole iStudentRole;

    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                             TaskModel taskModel, SplitPageRequest pageRequest,
                             String startTimeString,
                             String endTimeString) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        TaskListRequest request = new TaskListRequest();

        if (!StringExtention.isTrimNullOrEmpty(startTimeString))
            taskModel.setStartTime(sdf.parse(startTimeString));
        if (!StringExtention.isTrimNullOrEmpty(endTimeString))
            taskModel.setEndTime(sdf.parse(endTimeString));

        request.setTaskModel(taskModel);
        pageRequest.setReturnCount(true);
        request.setSplitPageRequest(pageRequest);

        TaskListResponse response = iTask.listByPage(request);
        mav.addObject("response", response);

        mav.addObject("taskModel", taskModel);
        mav.addObject("roleList", iStudentRole.studentRoleList());

        mav.setViewName("/task/taskList");
        return mav;
    }

    @RequestMapping("/add")
    public ModelAndView addTask(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        mav.addObject("roleList", iStudentRole.studentRoleList());
        mav.setViewName("task/taskEdit");
        return mav;
    }

    @RequestMapping("/edit")
    public ModelAndView editArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            Integer id) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        mav.addObject("task", iTask.selectById(id));
        mav.addObject("roleList", iStudentRole.studentRoleList());
        mav.setViewName("task/taskEdit");
        return mav;
    }


    @RequestMapping(value = "/addOrUpdate", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> addOrUpdateArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            TaskModel model,
            @RequestParam("startTimeString") String startTimeString,
            @RequestParam("endTimeString") String endTimeString) throws Exception {

        Map<String, Object> map = new HashMap<>();
        boolean i;

        //时间转换
        if (startTimeString != null)
            model.setStartTime(sdf.parse(startTimeString));
        if (endTimeString != null)
            model.setEndTime(sdf.parse(endTimeString));

        if (httpRequest.getParameter("isUpdate") == null) {
            i = iTask.addTask(model);
        } else {
            i = iTask.editTask(model);
        }
        map.put("success", i);

        return map;
    }

    @RequestMapping("/del")
    public
    @ResponseBody
    Map<String, Object> delArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            Integer id) throws Exception {

        boolean i = false;
        Map<String, Object> map = new HashMap<>();
        if (IntegerExtention.hasValueAndMaxZero(id)) {
            i = iTask.deleteTask(id);
        }
        map.put("success", i);

        return map;
    }

}
