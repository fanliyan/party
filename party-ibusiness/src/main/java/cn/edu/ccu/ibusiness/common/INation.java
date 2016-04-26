package cn.edu.ccu.ibusiness.common;

import cn.edu.ccu.model.common.NationModel;

import java.util.List;

/**
 * Created by kuangye on 2016/4/17.
 */
public interface INation {

    List<NationModel> selectNationList();
}
