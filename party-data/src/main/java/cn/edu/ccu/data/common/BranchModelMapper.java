package cn.edu.ccu.data.common;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.common.BranchModel;

import java.util.List;

@PartyDB
public interface BranchModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BranchModel record);

    int insertSelective(BranchModel record);

    BranchModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BranchModel record);

    int updateByPrimaryKey(BranchModel record);

    List<BranchModel> select();
}