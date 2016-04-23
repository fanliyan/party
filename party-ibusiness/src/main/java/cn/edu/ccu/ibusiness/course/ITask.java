package cn.edu.ccu.ibusiness.course;

import cn.edu.ccu.model.course.TaskListRequest;
import cn.edu.ccu.model.course.TaskListResponse;
import cn.edu.ccu.model.course.TaskModel;

import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2016/4/22.
 */
public interface ITask {


    TaskListResponse listByPage(TaskListRequest taskListRequest);

    boolean addTask(TaskModel taskModel);

    boolean editTask(TaskModel taskModel);

    boolean deleteTask(Integer id);

    TaskModel selectById(Integer id);

    List<TaskModel> getTaskByRole(Integer roleId, Date startTime, Date endTime);


    List<TaskModel> getMyTaskDetail(Integer studentId);


}
