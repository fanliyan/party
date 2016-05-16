package cn.edu.ccu.data.common;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.common.BannerConfigModel;

import java.util.List;

@PartyDB
public interface BannerConfigModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BannerConfigModel record);

    int insertSelective(BannerConfigModel record);

    BannerConfigModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BannerConfigModel record);

    int updateByPrimaryKey(BannerConfigModel record);

    List<BannerConfigModel> getByType(Integer type);

    List<BannerConfigModel> select();
}