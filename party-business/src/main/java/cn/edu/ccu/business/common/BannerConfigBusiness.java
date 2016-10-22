package cn.edu.ccu.business.common;

import cn.edu.ccu.data.common.BannerConfigModelMapper;
import cn.edu.ccu.ibusiness.common.IBannerConfig;
import cn.edu.ccu.model.common.BannerConfigModel;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by kuangye on 2016/5/10.
 */
@Service
public class BannerConfigBusiness implements IBannerConfig {

    @Autowired
    private BannerConfigModelMapper bannerConfigModelMapper;

    public BannerConfigModel selectById(Integer id) {

        if (IntegerExtention.hasValueAndMaxZero(id)) {
            return bannerConfigModelMapper.selectByPrimaryKey(id);
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public List<BannerConfigModel> select(){

            return bannerConfigModelMapper.select();
    }

    public List<BannerConfigModel> selectByType(Integer type) {

        if (IntegerExtention.hasValueAndMaxZero(type)) {
            return bannerConfigModelMapper.getByType(type);
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean insert(BannerConfigModel bannerConfigModel) {

        if (bannerConfigModel != null) {

            if (StringExtention.isTrimNullOrEmpty(bannerConfigModel.getPic()))
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            if (StringExtention.isTrimNullOrEmpty(bannerConfigModel.getUrl()))
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            if (bannerConfigModel.getType() == null || bannerConfigModel.getType() < 0)
                throw new BusinessException(ErrorCodeEnum.requestParamError);

            return bannerConfigModelMapper.insertSelective(bannerConfigModel) > 0;
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean update(BannerConfigModel bannerConfigModel) {

        if (bannerConfigModel != null && IntegerExtention.hasValueAndMaxZero(bannerConfigModel.getId())) {

            return bannerConfigModelMapper.updateByPrimaryKeySelective(bannerConfigModel) > 0;
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean delete(Integer id) {
        if (IntegerExtention.hasValueAndMaxZero(id)) {

            return bannerConfigModelMapper.deleteByPrimaryKey(id) > 0;
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


}
