package cn.edu.ccu.ibusiness.common;

import cn.edu.ccu.model.common.BannerConfigModel;

import java.util.List;

/**
 * Created by kuangye on 2016/5/10.
 */
public interface IBannerConfig {


    BannerConfigModel selectById(Integer id);

    List<BannerConfigModel> select();

    List<BannerConfigModel> selectByType(Integer type);

    boolean insert(BannerConfigModel bannerConfigModel);

    boolean update(BannerConfigModel bannerConfigModel);

    boolean delete(Integer id);

}
