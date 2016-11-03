package cn.edu.ccu.business.student;

import cn.edu.ccu.data.student.SRoleModelMapper;
import cn.edu.ccu.ibusiness.student.ISRole;
import cn.edu.ccu.model.student.SRoleModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by kuangye on 2016/4/24.
 */
@Service
public class SRoleBusiness implements ISRole {

    @Autowired
    private SRoleModelMapper sRoleModelMapper;

    public List<SRoleModel> list() throws Exception{
        return sRoleModelMapper.select();
    }

}
