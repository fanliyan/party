package cn.edu.ccu.model.course;

import cn.edu.ccu.model.SplitPageRequest;

import java.util.List;

/**
 * Created by Administrator on 2016/4/18.
 */
public class CourseListRequest {

    private List<Integer> ids;

    private CourseModel courseModel;

    private SplitPageRequest splitPageRequest;

    public List<Integer> getIds() {
        return ids;
    }

    public void setIds(List<Integer> ids) {
        this.ids = ids;
    }

    public CourseModel getCourseModel() {
        return courseModel;
    }

    public void setCourseModel(CourseModel courseModel) {
        this.courseModel = courseModel;
    }

    public SplitPageRequest getSplitPageRequest() {
        return splitPageRequest;
    }

    public void setSplitPageRequest(SplitPageRequest splitPageRequest) {
        this.splitPageRequest = splitPageRequest;
    }
}
