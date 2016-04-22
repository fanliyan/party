package cn.edu.ccu.business.course;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.data.course.TaskModelMapper;
import cn.edu.ccu.ibusiness.course.ITask;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.course.TaskListRequest;
import cn.edu.ccu.model.course.TaskListResponse;
import cn.edu.ccu.model.course.TaskModel;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/4/22.
 */
@Service
public class TaskBusiness implements ITask {

    @Autowired
    private TaskModelMapper taskModelMapper;


    public TaskListResponse listByPage(TaskListRequest taskListRequest) {


        Map<String, Object> map = new HashMap<>();
        TaskModel taskModel = taskListRequest.getTaskModel();
        if (taskModel != null) {
            if (!StringExtention.isTrimNullOrEmpty(taskModel.getName())) {
                map.put("name", taskModel.getName());
            }
        }

        SplitPageRequest pageRequest = taskListRequest.getSplitPageRequest();
        UtilsBusiness.pubMapforSplitPage(pageRequest, map);

        TaskListResponse response = new TaskListResponse();

        List<TaskModel> list = taskModelMapper.select(map);
        response.setTaskModelList(list);

        if (taskListRequest.getSplitPageRequest() != null && taskListRequest.getSplitPageRequest().isReturnCount()) {
            int totalSize = taskModelMapper.count(map);
            response.setSplitPageResponse(UtilsBusiness.getSplitPageResponse(totalSize, pageRequest.getPageSize(), pageRequest.getPageNo()));
        }

        return response;
    }


    public boolean addTask(TaskModel taskModel) {

        if (taskModel != null) {

            if (StringExtention.isTrimNullOrEmpty(taskModel.getName()))
                throw new BusinessException("任务名称不能为空");
            if (!IntegerExtention.hasValueAndMaxZero(taskModel.getRoleId()))
                throw new BusinessException("任务角色不能为空");
            if (!IntegerExtention.hasValueAndMaxZero(taskModel.getTargetScore())
                    && !IntegerExtention.hasValueAndMaxZero(taskModel.getTargetTime()))
                throw new BusinessException("目标分数和时间不能同时为空");

            return taskModelMapper.insertSelective(taskModel) > 0;

        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean editTask(TaskModel taskModel) {

        if (taskModel != null && IntegerExtention.hasValueAndMaxZero(taskModel.getId())) {

            TaskModel task = taskModelMapper.selectByPrimaryKey(taskModel.getId());

            if (taskModel.getName() != null
                    && StringExtention.isTrimNullOrEmpty(taskModel.getName()))
                throw new BusinessException("任务名称不能为空");
            if (taskModel.getRoleId() != null &&
                    !IntegerExtention.hasValueAndMaxZero(taskModel.getRoleId()))
                throw new BusinessException("任务角色不能为空");

            return taskModelMapper.updateByPrimaryKeySelective(taskModel) > 0;

        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean deleteTask(Integer id) {
        if (IntegerExtention.hasValueAndMaxZero(id)) {
            return taskModelMapper.deleteByPrimaryKey(id) > 0;
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public TaskModel selectById(Integer id) {
        if (IntegerExtention.hasValueAndMaxZero(id)) {
            return taskModelMapper.selectByPrimaryKey(id);
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

}
