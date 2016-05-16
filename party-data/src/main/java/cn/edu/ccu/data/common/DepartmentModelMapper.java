package cn.edu.ccu.data.common;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.common.DepartmentModel;

import java.util.List;

@PartyDB
public interface DepartmentModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(DepartmentModel record);

    int insertSelective(DepartmentModel record);

    DepartmentModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(DepartmentModel record);

    int updateByPrimaryKey(DepartmentModel record);

    List<DepartmentModel> select();
}