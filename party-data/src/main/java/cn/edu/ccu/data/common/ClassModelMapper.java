package cn.edu.ccu.data.common;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.common.ClassModel;

import java.util.List;

@PartyDB
public interface ClassModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ClassModel record);

    int insertSelective(ClassModel record);

    ClassModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ClassModel record);

    int updateByPrimaryKey(ClassModel record);

    List<ClassModel> select();
}