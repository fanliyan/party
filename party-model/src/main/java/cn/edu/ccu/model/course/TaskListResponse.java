package cn.edu.ccu.model.course;

import cn.edu.ccu.model.SplitPageResponse;

import java.util.List;

/**
 * Created by kuangye on 2016/4/22.
 */
public class TaskListResponse {


    private List<TaskModel> taskModelList;

    private SplitPageResponse splitPageResponse;


    public List<TaskModel> getTaskModelList() {
        return taskModelList;
    }

    public void setTaskModelList(List<TaskModel> taskModelList) {
        this.taskModelList = taskModelList;
    }

    public SplitPageResponse getSplitPageResponse() {
        return splitPageResponse;
    }

    public void setSplitPageResponse(SplitPageResponse splitPageResponse) {
        this.splitPageResponse = splitPageResponse;
    }
}
