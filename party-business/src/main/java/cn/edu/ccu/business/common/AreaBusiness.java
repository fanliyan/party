package cn.edu.ccu.business.common;

import cn.edu.ccu.data.common.AreaModelMapper;
import cn.edu.ccu.ibusiness.common.IArea;
import cn.edu.ccu.model.common.AreaModel;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by kuangye on 2016/4/17.
 */
@Service
public class AreaBusiness implements IArea {

    @Autowired
    private AreaModelMapper areaModelMapper;


    //静态化
    private static List<AreaModel> areaList = new ArrayList<>();

    /* @PostConstruct */
    protected void init() {
        synchronized (areaList) {
            areaList = list();
        }
    }

    private  List<AreaModel> list(){
       return areaModelMapper.select();
    }

    public List<AreaModel> selectAreaList() {

        if(areaList.size()<=0){
            this.init();
        }
        return areaList;
    }

    public List<AreaModel> selectAreaListByCityCode(String code) {
        if (!StringExtention.isTrimNullOrEmpty(code)) {

            List<AreaModel> returnList = new ArrayList<>();

            if(areaList.size()<=0){
                this.init();
            }

            for(AreaModel areaModel:areaList)
                if(areaModel.getCitycode().equals(code))
                    returnList.add(areaModel);

            return returnList;

//            return areaModelMapper.selectByCityCode(code);
        }
        return null;
    }

    public AreaModel getAreaByCode(String code) {
        if (!StringExtention.isTrimNullOrEmpty(code)) {
            List<AreaModel> returnList = new ArrayList<>();

            if(areaList.size()<=0){
                this.init();
            }

            for(AreaModel areaModel:areaList)
                if(areaModel.getCode().equals(code))
                    return areaModel;

//            return areaModelMapper.getAreaByCode(code);
        }
        return null;
    }
}
