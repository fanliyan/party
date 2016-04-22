package cn.edu.ccu.model.course;

import cn.edu.ccu.model.SplitPageResponse;

import java.util.List;

/**
 * Created by Administrator on 2016/4/19.
 */
public class CourseTypeListResponse {

    private List<CourseTypeModel> courseTypeModelList;

    private SplitPageResponse splitPageResponse;

    public List<CourseTypeModel> getCourseTypeModelList() {
        return courseTypeModelList;
    }

    public void setCourseTypeModelList(List<CourseTypeModel> courseTypeModelList) {
        this.courseTypeModelList = courseTypeModelList;
    }

    public SplitPageResponse getSplitPageResponse() {
        return splitPageResponse;
    }

    public void setSplitPageResponse(SplitPageResponse splitPageResponse) {
        this.splitPageResponse = splitPageResponse;
    }
}
