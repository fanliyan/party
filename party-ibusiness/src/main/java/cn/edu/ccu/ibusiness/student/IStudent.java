package cn.edu.ccu.ibusiness.student;

import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.student.*;

/**
 * Created by Administrator on 2016/4/10.
 */
public interface IStudent {

    StudentModel getStudentById(Integer id);

    StudentModel getStudentDetailById(Integer id) ;

    StudentRegisterResponse register(StudentRegisterRequest request, RequestHead requestHead) throws Exception;

    StudentLoginResponse login(StudentLoginRequest request, RequestHead requestHead) throws Exception;

    boolean updatePassword(StudentModel studentModel, String oldPassword, String newPassword, RequestHead requestHead) throws Exception;


    StudentListResponse listByPage(StudentListRequest studentListRequest);

}
