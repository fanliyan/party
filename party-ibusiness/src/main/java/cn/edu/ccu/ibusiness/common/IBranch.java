package cn.edu.ccu.ibusiness.common;

import cn.edu.ccu.model.common.BranchModel;

import java.util.List;

/**
 * Created by kuangye on 2016/5/16.
 */
public interface IBranch {

    List<BranchModel> select();

    BranchModel getByDepartmentId(Integer id);

    BranchModel getById(Integer id);
}
