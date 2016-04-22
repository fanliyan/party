package cn.edu.ccu.model.student;

/**
 * Created by Administrator on 2016/4/11.
 */
public class StudentLoginResponse {

    private Integer loginResult;

    private StudentModel studentModel;

    public Integer getLoginResult() {
        return loginResult;
    }

    public void setLoginResult(Integer loginResult) {
        this.loginResult = loginResult;
    }

    public StudentModel getStudentModel() {
        return studentModel;
    }

    public void setStudentModel(StudentModel studentModel) {
        this.studentModel = studentModel;
    }
}
