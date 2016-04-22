package cn.edu.ccu.ibusiness.common;

import cn.edu.ccu.model.common.ProvinceModel;

import java.util.List;

/**
 * Created by Administrator on 2016/4/17.
 */
public interface IProvince {

    List<ProvinceModel> selectProvinceList();

    ProvinceModel getProvinceByCode(String code);

}
