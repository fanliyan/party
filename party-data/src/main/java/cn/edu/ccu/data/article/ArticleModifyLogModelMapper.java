package cn.edu.ccu.data.article;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.article.ArticleModifyLogModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@PartyDB
public interface ArticleModifyLogModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ArticleModifyLogModel record);

    int insertSelective(ArticleModifyLogModel record);

    ArticleModifyLogModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ArticleModifyLogModel record);

    int updateByPrimaryKeyWithBLOBs(ArticleModifyLogModel record);

    int updateByPrimaryKey(ArticleModifyLogModel record);

    List<ArticleModifyLogModel> selectByArticle(@Param("articleId")Integer id, @Param("rowStart")Integer rowStart, @Param("rowCount") Integer rowCount);

    int selectCountByArticle(@Param("articleId")Integer id);
}