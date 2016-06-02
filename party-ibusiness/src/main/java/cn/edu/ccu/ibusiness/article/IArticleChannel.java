package cn.edu.ccu.ibusiness.article;


import cn.edu.ccu.model.article.ArticleChannelModel;
import cn.edu.ccu.model.common.NestableModel;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by kuangye on 2015/11/11.
 */
public interface IArticleChannel {
    //查询列表
    List<ArticleChannelModel> select();

    //查询个数
    int count();

    ArticleChannelModel selectById(Integer id);


    int addArticleChannel(ArticleChannelModel articleChannelModel);

    int editArticleChannel(ArticleChannelModel articleChannelModel) throws Exception;

    int deleteArticleChannel(Integer id);

    //根据nestable 拖拽修改 channel 父子节点
    // TODO 但是数据库连接必须配置：&allowMultiQueries=true
    // TODO 暂时只有两级 级数添加是需要修改方法
    boolean updateFromNestable(List<NestableModel> nestableModelList);


    //根据 父节点ID 获取 TAG子节点
    List<ArticleChannelModel> selectByFatherId(Integer fatherId) throws Exception;

    List<ArticleChannelModel> selectByFatherId(Integer fatherId,boolean isIterator) throws Exception;

}
