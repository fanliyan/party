package cn.edu.ccu.data.common;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.common.CityModel;

import java.util.List;

@PartyDB
public interface CityModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CityModel record);

    int insertSelective(CityModel record);

    CityModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CityModel record);

    int updateByPrimaryKey(CityModel record);

    List<CityModel> select();

    List<CityModel> selectByProvinceCode(String code);

    CityModel getCityByCode(String code);
}