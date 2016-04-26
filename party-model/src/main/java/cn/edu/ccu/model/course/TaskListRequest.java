package cn.edu.ccu.model.course;

import cn.edu.ccu.model.SplitPageRequest;

/**
 * Created by kuangye on 2016/4/22.
 */
public class TaskListRequest {

    private TaskModel taskModel;

    private SplitPageRequest splitPageRequest;


    public TaskModel getTaskModel() {
        return taskModel;
    }

    public void setTaskModel(TaskModel taskModel) {
        this.taskModel = taskModel;
    }

    public SplitPageRequest getSplitPageRequest() {
        return splitPageRequest;
    }

    public void setSplitPageRequest(SplitPageRequest splitPageRequest) {
        this.splitPageRequest = splitPageRequest;
    }
}
