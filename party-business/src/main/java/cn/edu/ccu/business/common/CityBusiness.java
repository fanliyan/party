package cn.edu.ccu.business.common;

import cn.edu.ccu.data.common.CityModelMapper;
import cn.edu.ccu.ibusiness.common.ICity;
import cn.edu.ccu.model.common.CityModel;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/17.
 */
@Service
public class CityBusiness implements ICity {

    @Autowired
    private CityModelMapper cityModelMapper;


    //静态化
    private static List<CityModel> cityList = new ArrayList<>();

    /* @PostConstruct */
    protected void init() {
        synchronized (cityList) {
            cityList = list();
        }
    }

    private  List<CityModel> list(){
        return cityModelMapper.select();
    }


    public List<CityModel> selectCityList() {

        if(cityList.size()<=0){
            this.init();
        }
        return cityList;
    }

    public List<CityModel> selectCityListByProvinceCode(String code) {
        if (!StringExtention.isTrimNullOrEmpty(code)) {

            List<CityModel> returnList = new ArrayList<>();

            if(cityList.size()<=0){
                this.init();
            }

            for(CityModel cityModel:cityList)
                if(cityModel.getProvincecode().equals(code))
                    returnList.add(cityModel);

            return returnList;
//            return cityModelMapper.selectByProvinceCode(code);
        }
        return null;
    }

    public CityModel getCityByCode(String code) {
        if (!StringExtention.isTrimNullOrEmpty(code)) {

            if(cityList.size()<=0){
                this.init();
            }

            for(CityModel cityModel:cityList)
                if(cityModel.getCode().equals(code))
                    return cityModel;

//            return cityModelMapper.getCityByCode(code);
        }
        return null;
    }
}
