package cn.edu.ccu.ibusiness.system;

import cn.edu.ccu.model.system.SysDictModel;

import java.util.List;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/12.
 */
public interface ISystemDict {
    List<SysDictModel> listByDictType(String dictType);

    Map<String,String> getDictMapByDictType(String dictType);
}
