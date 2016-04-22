package cn.edu.ccu.data.common;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.common.AreaModel;

import java.util.List;

@PartyDB
public interface AreaModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(AreaModel record);

    int insertSelective(AreaModel record);

    AreaModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(AreaModel record);

    int updateByPrimaryKey(AreaModel record);

    List<AreaModel> select();

    List<AreaModel> selectByCityCode(String code);

    AreaModel getAreaByCode(String code);
}