package cn.edu.ccu.model.student;

import cn.edu.ccu.model.SplitPageResponse;

import java.util.List;

/**
 * Created by kuangye on 2016/4/17.
 */
public class StudentListResponse {

    private List<StudentModel> studentModelList;

    private SplitPageResponse splitPageResponse;


    public List<StudentModel> getStudentModelList() {
        return studentModelList;
    }

    public void setStudentModelList(List<StudentModel> studentModelList) {
        this.studentModelList = studentModelList;
    }

    public SplitPageResponse getSplitPageResponse() {
        return splitPageResponse;
    }

    public void setSplitPageResponse(SplitPageResponse splitPageResponse) {
        this.splitPageResponse = splitPageResponse;
    }
}
