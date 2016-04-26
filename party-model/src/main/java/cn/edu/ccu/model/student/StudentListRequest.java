package cn.edu.ccu.model.student;

import cn.edu.ccu.model.SplitPageRequest;

import java.util.List;

/**
 * Created by kuangye on 2016/4/17.
 */
public class StudentListRequest {

    private StudentModel studentModel;

    private SplitPageRequest splitPageRequest;


    public StudentModel getStudentModel() {
        return studentModel;
    }

    public void setStudentModel(StudentModel studentModel) {
        this.studentModel = studentModel;
    }

    public SplitPageRequest getSplitPageRequest() {
        return splitPageRequest;
    }

    public void setSplitPageRequest(SplitPageRequest splitPageRequest) {
        this.splitPageRequest = splitPageRequest;
    }
}
