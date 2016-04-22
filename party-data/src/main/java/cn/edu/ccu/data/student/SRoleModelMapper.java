package cn.edu.ccu.data.student;


import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.student.SRoleModel;

@PartyDB
public interface SRoleModelMapper {
    int deleteByPrimaryKey(Integer roleId);

    int insert(SRoleModel record);

    int insertSelective(SRoleModel record);

    SRoleModel selectByPrimaryKey(Integer roleId);

    int updateByPrimaryKeySelective(SRoleModel record);

    int updateByPrimaryKey(SRoleModel record);
}