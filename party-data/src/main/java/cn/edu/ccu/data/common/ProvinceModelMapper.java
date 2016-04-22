package cn.edu.ccu.data.common;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.common.ProvinceModel;

import java.util.List;

@PartyDB
public interface ProvinceModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ProvinceModel record);

    int insertSelective(ProvinceModel record);

    ProvinceModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ProvinceModel record);

    int updateByPrimaryKey(ProvinceModel record);

    List<ProvinceModel> select();

    ProvinceModel getProvinceByCode(String code);
}