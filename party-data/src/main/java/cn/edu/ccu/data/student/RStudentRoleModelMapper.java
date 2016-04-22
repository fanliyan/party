package cn.edu.ccu.data.student;


import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.student.RStudentRoleModel;
import cn.edu.ccu.model.student.RStudentRoleModelKey;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@PartyDB
public interface RStudentRoleModelMapper {
    int deleteByPrimaryKey(RStudentRoleModelKey key);

    int insert(RStudentRoleModel record);

    int insertSelective(RStudentRoleModel record);

    RStudentRoleModel selectByPrimaryKey(RStudentRoleModelKey key);

    int updateByPrimaryKeySelective(RStudentRoleModel record);

    int updateByPrimaryKey(RStudentRoleModel record);

    Integer selectRoleIdByStudentId(@Param("studentId") Integer id);

}