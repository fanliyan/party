package cn.edu.ccu.business.common;

import cn.edu.ccu.data.common.ProvinceModelMapper;
import cn.edu.ccu.ibusiness.common.IProvince;
import cn.edu.ccu.model.common.ProvinceModel;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by kuangye on 2016/4/17.
 */
@Service
public class ProvinceBusiness implements IProvince {

    @Autowired
    private ProvinceModelMapper provinceModelMapper;


    private static List<ProvinceModel> provinceList = new ArrayList<>();

    /* @PostConstruct */
    protected void init() {
        synchronized (provinceList) {
            provinceList = list();
        }
    }

    private List<ProvinceModel> list() {
        return provinceModelMapper.select();
    }


    public List<ProvinceModel> selectProvinceList() {

        if(provinceList.size()<=0){
            this.init();
        }
        return provinceList;
    }


    public ProvinceModel getProvinceByCode(String code) {
        if(!StringExtention.isTrimNullOrEmpty(code)){

            if(provinceList.size()<=0){
                this.init();
            }

            for(ProvinceModel provinceModel:provinceList)
                if(provinceModel.getCode().equals(code))
                    return provinceModel;

//            return provinceModelMapper.getProvinceByCode(code);
        }
        return null;
    }
}
