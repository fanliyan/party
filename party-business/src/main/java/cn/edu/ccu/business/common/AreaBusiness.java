package cn.edu.ccu.business.common;

import cn.edu.ccu.data.common.AreaModelMapper;
import cn.edu.ccu.ibusiness.common.IArea;
import cn.edu.ccu.model.common.AreaModel;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by kuangye on 2016/4/17.
 */
@Service
public class AreaBusiness implements IArea {

    @Autowired
    private AreaModelMapper areaModelMapper;

    public List<AreaModel> selectAreaList() {
        return areaModelMapper.select();
    }

    public List<AreaModel> selectAreaListByCityCode(String code) {
        if (!StringExtention.isTrimNullOrEmpty(code)) {
            return areaModelMapper.selectByCityCode(code);
        }
        return null;
    }

    public AreaModel getAreaByCode(String code) {
        if (!StringExtention.isTrimNullOrEmpty(code)) {
            return areaModelMapper.getAreaByCode(code);
        }
        return null;
    }
}
