package cn.edu.ccu.model.course;

import cn.edu.ccu.model.SplitPageRequest;

/**
 * Created by Administrator on 2016/4/19.
 */
public class CourseTypeListRequest {

    private CourseTypeModel courseTypeModel;

    private SplitPageRequest splitPageRequest;

    public CourseTypeModel getCourseTypeModel() {
        return courseTypeModel;
    }

    public void setCourseTypeModel(CourseTypeModel courseTypeModel) {
        this.courseTypeModel = courseTypeModel;
    }

    public SplitPageRequest getSplitPageRequest() {
        return splitPageRequest;
    }

    public void setSplitPageRequest(SplitPageRequest splitPageRequest) {
        this.splitPageRequest = splitPageRequest;
    }
}
