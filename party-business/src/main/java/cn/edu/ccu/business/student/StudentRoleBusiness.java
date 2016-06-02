package cn.edu.ccu.business.student;

import cn.edu.ccu.data.TransactionManagerName;
import cn.edu.ccu.data.student.RStudentRoleModelMapper;
import cn.edu.ccu.data.student.SRoleModelMapper;
import cn.edu.ccu.data.student.StudentModelMapper;
import cn.edu.ccu.ibusiness.student.IStudent;
import cn.edu.ccu.ibusiness.student.IStudentRole;
import cn.edu.ccu.model.student.RStudentRoleModel;
import cn.edu.ccu.model.student.SRoleModel;
import cn.edu.ccu.model.student.StudentModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Created by kuangye on 2016/4/22.
 */
@Service
public class StudentRoleBusiness implements IStudentRole {

    @Autowired
    private SRoleModelMapper sRoleModelMapper;

    @Autowired
    private RStudentRoleModelMapper rStudentRoleModelMapper;

    @Autowired
    private StudentModelMapper studentModelMapper;

    public List<SRoleModel> studentRoleList() {
        return sRoleModelMapper.select();
    }


    @Transactional(TransactionManagerName.partyTransactionManager)
    public boolean updateRole(Integer userId, Integer roleId, Integer oldRole) {

        RStudentRoleModel rStudentRoleModel = new RStudentRoleModel();
        rStudentRoleModel.setStudentId(userId);
        rStudentRoleModel.setRoleId(oldRole);

        int i = rStudentRoleModelMapper.deleteByPrimaryKey(rStudentRoleModel);

        rStudentRoleModel.setRoleId(roleId);
        int j = rStudentRoleModelMapper.insertSelective(rStudentRoleModel);


//        设置时间 TODO 可以改进
        StudentModel studentModel = new StudentModel();
        studentModel.setId(userId);

        if(roleId==2)
            studentModel.setProbationaryMemberTime(new Date());
        if(roleId==3)
            studentModel.setCardCarryingMemberTime(new Date());

        studentModelMapper.updateByPrimaryKeySelective(studentModel);


        return i > 0 && j > 0;
    }
}
