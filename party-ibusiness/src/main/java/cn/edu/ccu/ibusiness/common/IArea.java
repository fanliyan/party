package cn.edu.ccu.ibusiness.common;

import cn.edu.ccu.model.common.AreaModel;

import java.util.List;

/**
 * Created by Administrator on 2016/4/17.
 */
public interface IArea {

    List<AreaModel> selectAreaList();

    List<AreaModel> selectAreaListByCityCode(String code);

    AreaModel getAreaByCode(String code);
}
