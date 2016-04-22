package cn.edu.ccu.model.student;

/**
 * Created by Administrator on 2016/4/11.
 */
public class StudentRegisterResponse {

   private Integer registerResult;

    private StudentModel studentModel;

    public StudentModel getStudentModel() {
        return studentModel;
    }

    public void setStudentModel(StudentModel studentModel) {
        this.studentModel = studentModel;
    }

    public Integer getRegisterResult() {
        return registerResult;
    }

    public void setRegisterResult(Integer registerResult) {
        this.registerResult = registerResult;
    }
}
