package cn.edu.ccu.data.common;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.common.NationModel;

import java.util.List;

@PartyDB
public interface NationModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(NationModel record);

    int insertSelective(NationModel record);

    NationModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(NationModel record);

    int updateByPrimaryKey(NationModel record);

   List<NationModel> select();
}