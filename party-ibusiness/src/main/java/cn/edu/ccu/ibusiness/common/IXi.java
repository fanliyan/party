package cn.edu.ccu.ibusiness.common;

import cn.edu.ccu.model.common.XiModel;

import java.util.List;

/**
 * Created by kuangye on 2016/5/16.
 */
public interface IXi {

    List<XiModel> select();

    List<XiModel> getByDepartmentId(Integer id);

    XiModel getById(Integer id);



    boolean add(XiModel xiModel);

    boolean edit(XiModel xiModel);

    boolean delete(Integer id);
}
