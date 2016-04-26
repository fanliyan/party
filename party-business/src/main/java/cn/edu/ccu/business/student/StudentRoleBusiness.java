package cn.edu.ccu.business.student;

import cn.edu.ccu.data.student.RStudentRoleModelMapper;
import cn.edu.ccu.data.student.SRoleModelMapper;
import cn.edu.ccu.ibusiness.student.IStudentRole;
import cn.edu.ccu.model.student.SRoleModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by kuangye on 2016/4/22.
 */
@Service
public class StudentRoleBusiness implements IStudentRole {

    @Autowired
    private SRoleModelMapper sRoleModelMapper;

    public List<SRoleModel> studentRoleList() {
        return sRoleModelMapper.select();
    }
}
