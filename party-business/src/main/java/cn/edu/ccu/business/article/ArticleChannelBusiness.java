package cn.edu.ccu.business.article;

import cn.edu.ccu.data.TransactionManagerName;
import cn.edu.ccu.data.article.ArticleChannelModelMapper;
import cn.edu.ccu.ibusiness.article.IArticleChannel;
import cn.edu.ccu.model.article.ArticleChannelModel;
import cn.edu.ccu.model.common.NestableModel;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by kuangye on 2015/11/11.
 */
@Service
public class ArticleChannelBusiness implements IArticleChannel {

    @Autowired
    ArticleChannelModelMapper articleChannelModelMapper;

    //查询列表
    public List<ArticleChannelModel> select() {

        return articleChannelModelMapper.select();
    }

    //查询个数
    public int count() {
        return articleChannelModelMapper.count();
    }


    public ArticleChannelModel selectById(Integer id) {
        if (IntegerExtention.hasValueAndMaxZero(id))
            return articleChannelModelMapper.selectByPrimaryKey(id);

        return null;
    }


    public int addArticleChannel(ArticleChannelModel articleChannelModel) {

        if (articleChannelModel == null) {
            throw new BusinessException(ErrorCodeEnum.requestParamError);
        }
        if (StringExtention.isTrimNullOrEmpty(articleChannelModel.getName())) {
            throw new BusinessException(ErrorCodeEnum.requestParamError);
        }

        //有父节点且父节点不为0
        if (IntegerExtention.hasValueAndMaxZero(articleChannelModel.getParentId())) {
            ArticleChannelModel articleChannel_parent = articleChannelModelMapper
                    .selectByPrimaryKey(articleChannelModel.getParentId());
            //校验父节点
            if (articleChannel_parent == null) {
                throw new BusinessException("父节点不存在");
            }
        }

        return articleChannelModelMapper.insertSelective(articleChannelModel);
    }

    public int editArticleChannel(ArticleChannelModel articleChannelModel) throws Exception {

        if (articleChannelModel != null && IntegerExtention.hasValueAndMaxZero(articleChannelModel.getChannelId())) {
            return articleChannelModelMapper.updateByPrimaryKeySelective(articleChannelModel);
        } else {
            throw new BusinessException(ErrorCodeEnum.requestParamError);
        }
    }

//    changeTagLayer()

    public int deleteArticleChannel(Integer id) {

        if (IntegerExtention.hasValueAndMaxZero(id)) {
            //先判断是否有子类
            List<ArticleChannelModel> tagModelList = articleChannelModelMapper.selectByFatherId(id);
            if (tagModelList != null && tagModelList.size() > 0) {
                throw new BusinessException("请先删除其子类");
            }

            //TODO 需要判断其下是否有文章文章 //一般channel固定

            return articleChannelModelMapper.deleteByPrimaryKey(id);
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    //根据nestable 拖拽修改 tag 父子节点
    // TODO 但是数据库连接必须配置：&allowMultiQueries=true
    @Transactional(value = TransactionManagerName.partyTransactionManager)
    public boolean updateFromNestable(List<NestableModel> nestableModelList) {

        if (nestableModelList != null && nestableModelList.size() > 0) {
            //都是根节点

            this.updateChild(nestableModelList, 0);

//            for (NestableModel nestableModel : nestableModelList) {
//
//                ArticleChannelModel articleChannelModel = new ArticleChannelModel();
//                articleChannelModel.setChannelId(nestableModel.getId());
//                articleChannelModel.setParentId(0);
//
//                articleChannelModelMapper.updateByPrimaryKeySelective(articleChannelModel);
//
//                this.updateChild(nestableModel);
//            }
        }

        return true;
    }

    //修改子节点
//    void updateChild(NestableModel nestableModel) {
//
//        List<NestableModel> nestableModelList = nestableModel.getChildren();
//
//        if (nestableModelList != null && nestableModelList.size() > 0) {
//            for (NestableModel child : nestableModelList) {
//
//                ArticleChannelModel articleChannelModel = new ArticleChannelModel();
//                articleChannelModel.setChannelId(child.getId());
//                articleChannelModel.setParentId(nestableModel.getId());
//
//                articleChannelModelMapper.updateByPrimaryKeySelective(articleChannelModel);
//
//                //修改子节点
//                this.updateChild(child.getChildren(),child.getId());
//            }
//        }
//    }

    //修改子节点
    private void updateChild(List<NestableModel> nestableModelList, Integer parentId) {

        if (nestableModelList != null && nestableModelList.size() > 0) {
            for (NestableModel child : nestableModelList) {

                ArticleChannelModel articleChannelModel = new ArticleChannelModel();
                articleChannelModel.setChannelId(child.getId());
                articleChannelModel.setParentId(parentId);

                articleChannelModelMapper.updateByPrimaryKeySelective(articleChannelModel);

                this.updateChild(child.getChildren(), child.getId());
            }
        }
    }


    //根据 父节点ID 获取 TAG子节点
    public List<ArticleChannelModel> selectByFatherId(Integer fatherId) throws Exception {
        return this.selectByFatherId(fatherId, false);
    }

    public List<ArticleChannelModel> selectByFatherId(Integer fatherId, boolean isIterator) throws Exception {

        if (fatherId != null && fatherId >= 0) {
            if (isIterator) {
                List<ArticleChannelModel> articleChannelModelList = this.selectByFatherId(fatherId);

                if (articleChannelModelList != null && articleChannelModelList.size() > 0) {

                    for (ArticleChannelModel articleChannelModel : articleChannelModelList) {

                        List<ArticleChannelModel> childList = this.selectByFatherId(articleChannelModel.getChannelId(), true);
                        articleChannelModel.setChildList(childList);
                    }
                }

                return articleChannelModelList;

            } else {
                return articleChannelModelMapper.selectByFatherId(fatherId);
            }
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


}
