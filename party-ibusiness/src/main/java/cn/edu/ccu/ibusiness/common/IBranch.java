package cn.edu.ccu.ibusiness.common;

import cn.edu.ccu.model.common.BranchModel;

import java.util.List;

/**
 * Created by kuangye on 2016/5/16.
 */
public interface IBranch {

    List<BranchModel> select();

    List<BranchModel> getByDepartmentId(Integer id);

    BranchModel getById(Integer id);



    boolean add(BranchModel branchModel);

    boolean edit(BranchModel branchModel);

    boolean delete(Integer id);
}
