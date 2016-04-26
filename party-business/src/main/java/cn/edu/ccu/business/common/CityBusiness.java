package cn.edu.ccu.business.common;

import cn.edu.ccu.data.common.CityModelMapper;
import cn.edu.ccu.ibusiness.common.ICity;
import cn.edu.ccu.model.common.CityModel;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by kuangye on 2016/4/17.
 */
@Service
public class CityBusiness implements ICity {

    @Autowired
    private CityModelMapper cityModelMapper;

    public List<CityModel> selectCityList() {
        return cityModelMapper.select();
    }

    public List<CityModel> selectCityListByProvinceCode(String code) {
        if (!StringExtention.isTrimNullOrEmpty(code)) {
            return cityModelMapper.selectByProvinceCode(code);
        }
        return null;
    }

    public CityModel getCityByCode(String code) {
        if (!StringExtention.isTrimNullOrEmpty(code)) {
            return cityModelMapper.getCityByCode(code);
        }
        return null;
    }
}
