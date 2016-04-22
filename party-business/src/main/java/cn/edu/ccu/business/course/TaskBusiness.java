package cn.edu.ccu.business.course;

import cn.edu.ccu.data.course.TaskModelMapper;
import cn.edu.ccu.ibusiness.course.ITask;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by Administrator on 2016/4/22.
 */
public class TaskBusiness implements ITask {

    @Autowired
    private TaskModelMapper taskModelMapper;





}
