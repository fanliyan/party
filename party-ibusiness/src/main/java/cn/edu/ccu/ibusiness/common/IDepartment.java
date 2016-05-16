package cn.edu.ccu.ibusiness.common;


import cn.edu.ccu.model.common.DepartmentModel;

import java.util.List;

/**
 * Created by kuangye on 2016/5/16.
 */
public interface IDepartment {

    List<DepartmentModel> select();

    DepartmentModel getById(Integer id);


}
