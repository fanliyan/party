package cn.edu.ccu.business.student;

import cn.edu.ccu.data.TransactionManagerName;
import cn.edu.ccu.data.student.RStudentRoleModelMapper;
import cn.edu.ccu.data.student.SRoleModelMapper;
import cn.edu.ccu.ibusiness.student.IStudentRole;
import cn.edu.ccu.model.student.RStudentRoleModel;
import cn.edu.ccu.model.student.SRoleModel;
import cn.edu.ccu.model.student.StudentModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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


        return i > 0 && j > 0;
    }
}
