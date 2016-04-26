package cn.edu.ccu.ibusiness.common;

import cn.edu.ccu.model.common.CityModel;

import java.util.List;

/**
 * Created by kuangye on 2016/4/17.
 */
public interface ICity {

    List<CityModel> selectCityList();

    List<CityModel> selectCityListByProvinceCode(String code);

    CityModel getCityByCode(String code);

}
