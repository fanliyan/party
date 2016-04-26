package cn.edu.ccu.business.course;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.data.course.TaskModelMapper;
import cn.edu.ccu.ibusiness.course.ICourse;
import cn.edu.ccu.ibusiness.course.IStudy;
import cn.edu.ccu.ibusiness.course.ITask;
import cn.edu.ccu.ibusiness.student.IStudent;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.course.*;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.student.StudentModel;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/22.
 */
@Service
public class TaskBusiness implements ITask {

    @Autowired
    private IStudent iStudent;
    @Autowired
    private ICourse iCourse;
    @Autowired
    private IStudy iStudy;

    @Autowired
    private TaskModelMapper taskModelMapper;


    public TaskListResponse listByPage(TaskListRequest taskListRequest) {


        Map<String, Object> map = new HashMap<>();
        TaskModel taskModel = taskListRequest.getTaskModel();
        if (taskModel != null) {
            if (!StringExtention.isTrimNullOrEmpty(taskModel.getName())) {
                map.put("name", taskModel.getName());
            }
            if (IntegerExtention.hasValueAndMaxZero(taskModel.getRoleId())) {
                map.put("roleId", taskModel.getName());
            }
            if (taskModel.getStartTime() != null) {
                map.put("startTime", taskModel.getStartTime());
            }
            if (taskModel.getEndTime() != null) {
                map.put("endTime", taskModel.getEndTime());
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


    public List<TaskModel> getTaskByRole(Integer roleId, Date startTime, Date endTime) {

        Map<String, Object> map = new HashMap<>();

        if (IntegerExtention.hasValueAndMaxZero(roleId)) {
            if (startTime != null) {
                map.put("startTime", startTime);
            }
            if (endTime != null) {
                map.put("endTime", endTime);
            }

            return taskModelMapper.selectByRole(map);
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


    private List<TaskModel> getMyTaskDetailByRoleId(Integer roleId, Date time) {

        Map<String, Object> map = new HashMap<>();

        if (IntegerExtention.hasValueAndMaxZero(roleId)) {

            map.put("id", roleId);

            if (time != null)
                map.put("time", time);

            return taskModelMapper.selectByRole(map);
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public List<TaskModel> getMyTaskDetail(Integer studentId) {


        if (IntegerExtention.hasValueAndMaxZero(studentId)) {

            StudentModel studentModel = iStudent.getStudentDetailById(studentId);
            if (studentModel != null && IntegerExtention.hasValueAndMaxZero(studentModel.getsRoleModel().getRoleId())) {

                //获取我的任务 近期任务
                List<TaskModel> taskModelList = this.getMyTaskDetailByRoleId(studentModel.getsRoleModel().getRoleId(),
                        new Date());

                //获取我的课程
                List<CourseModel> courseModelList = iCourse.myCourseList(studentId).getCourseModelList();

                //计算每个任务完成情况
                if (taskModelList != null) {
                    for (TaskModel taskModel : taskModelList) {

                        //taget
                        int score = taskModel.getTargetScore() == null ? 0 : taskModel.getTargetScore();
                        int time = taskModel.getTargetTime() == null ? 0 : taskModel.getTargetTime();

                        double myScore = 0, myTime = 0;

                        for (CourseModel courseModel : courseModelList) {

                            boolean tag = iStudy.calculateOneCourseStudy(
                                    studentId, courseModel.getCourseId(), taskModel.getStartTime(), taskModel.getEndTime());
                            //finished
                            if (tag) {
                                myScore += courseModel.getScore();
                                // second !
                                myTime += Double.parseDouble(courseModel.getTime());
                            }
                        }

                        //满足其一就行
                        if (myScore >= score || myTime / 60 >= time) {
                            taskModel.setFinish(true);
                        }
                    }
                }

                return taskModelList;
            }
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


}
