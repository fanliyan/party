package cn.edu.ccu.business.common;

import cn.edu.ccu.data.common.ProvinceModelMapper;
import cn.edu.ccu.ibusiness.common.IProvince;
import cn.edu.ccu.model.common.ProvinceModel;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2016/4/17.
 */
@Service
public class ProvinceBusiness implements IProvince {

    @Autowired
    private ProvinceModelMapper provinceModelMapper;

    public List<ProvinceModel> selectProvinceList() {
        return provinceModelMapper.select();
    }


    public ProvinceModel getProvinceByCode(String code) {
        if(!StringExtention.isTrimNullOrEmpty(code)){
            return provinceModelMapper.getProvinceByCode(code);
        }
        return null;
    }
}
