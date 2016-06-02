package cn.edu.ccu.data.common;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.common.XiModel;

import java.util.List;

@PartyDB
public interface XiModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(XiModel record);

    int insertSelective(XiModel record);

    XiModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(XiModel record);

    int updateByPrimaryKey(XiModel record);

    List<XiModel> select();
}