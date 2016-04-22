package cn.edu.ccu.model.course;

import cn.edu.ccu.model.SplitPageResponse;

import java.util.List;

/**
 * Created by Administrator on 2016/4/18.
 */
public class CourseListResponse {

    private List<CourseModel> courseModelList;

    private SplitPageResponse splitPageResponse;


    public List<CourseModel> getCourseModelList() {
        return courseModelList;
    }

    public void setCourseModelList(List<CourseModel> courseModelList) {
        this.courseModelList = courseModelList;
    }

    public SplitPageResponse getSplitPageResponse() {
        return splitPageResponse;
    }

    public void setSplitPageResponse(SplitPageResponse splitPageResponse) {
        this.splitPageResponse = splitPageResponse;
    }
}
