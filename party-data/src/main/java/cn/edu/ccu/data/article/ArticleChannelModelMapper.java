package cn.edu.ccu.data.article;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.article.ArticleChannelModel;

import java.util.List;

@PartyDB
public interface ArticleChannelModelMapper {
    int deleteByPrimaryKey(Integer channelId);

    int insert(ArticleChannelModel record);

    int insertSelective(ArticleChannelModel record);

    ArticleChannelModel selectByPrimaryKey(Integer channelId);

    int updateByPrimaryKeySelective(ArticleChannelModel record);

    int updateByPrimaryKey(ArticleChannelModel record);

    //查询列表
    List<ArticleChannelModel> select();
    //查询个数
    int count();
    //通过父节点ID查询子节点
    List<ArticleChannelModel>  selectByFatherId(Integer id);
}