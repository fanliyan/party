package cn.edu.ccu.business.common;

import cn.edu.ccu.data.common.NationModelMapper;
import cn.edu.ccu.ibusiness.common.INation;
import cn.edu.ccu.model.common.AreaModel;
import cn.edu.ccu.model.common.NationModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by kuangye on 2016/4/17.
 */
@Service
public class NationBusiness implements INation {

    @Autowired
    private NationModelMapper nationModelMapper;


    private static List<NationModel> nationList = new ArrayList<>();

    /* @PostConstruct */
    protected void init() {
        synchronized (nationList) {
            nationList = list();
        }
    }

    private List<NationModel> list() {
       return nationModelMapper.select();
    }

    public List<NationModel> selectNationList() {
        if (nationList.size() <= 0) {
            this.init();
        }
        return nationList;
    }
}
