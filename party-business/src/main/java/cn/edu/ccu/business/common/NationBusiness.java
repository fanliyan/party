package cn.edu.ccu.business.common;

import cn.edu.ccu.data.common.NationModelMapper;
import cn.edu.ccu.ibusiness.common.INation;
import cn.edu.ccu.model.common.NationModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2016/4/17.
 */
@Service
public class NationBusiness implements INation {

    @Autowired
    private NationModelMapper nationModelMapper;

    public List<NationModel> selectNationList() {
        return nationModelMapper.select();
    }
}
