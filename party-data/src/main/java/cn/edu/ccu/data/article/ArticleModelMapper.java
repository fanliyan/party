package cn.edu.ccu.data.article;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.article.ArticleModel;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;


/**
 * 文章标题修改时会同时修改文章索引
 * 有特殊逻辑请注意
 */
@PartyDB
public interface ArticleModelMapper {
    int deleteByPrimaryKey(Integer articleId);

//    int insert(ArticleModel record);

    int insertSelective(ArticleModel record);

    ArticleModel selectByPrimaryKey(Integer articleId);

    int updateByPrimaryKeySelective(ArticleModel record);

//    int updateByPrimaryKeyWithBLOBs(ArticleModel record);
//
//    int updateByPrimaryKey(ArticleModel record);


    /**
     * @param title            标题
     * @param publishTimeStart 发布最小时间
     * @param publishTimeEnd   发布最大时间
     * @param status           状态
     * @param orderBy          排序
     * @param userId           用户ID
     * @param pageNo           分页参数 第几页
     * @param pageSize         分页参数 每页多少条数据
     * @return
     */
    List<ArticleModel> selectArticleByRequirement(
            @Param("title") String title,
            @Param("publishTimeStart") Date publishTimeStart,
            @Param("publishTimeEnd") Date publishTimeEnd,
            @Param("status") Byte status,
            @Param("orderBy") Integer orderBy,
            @Param("userId") Integer userId,
            @Param("pageNo") Integer pageNo,
            @Param("pageSize") Integer pageSize,
            @Param("channelId") Integer channelId);

    /**
     * 根据指定条件查询文章总数
     *
     * @param userId
     * @return
     */
    Integer selectArticleByRequirementCount(
            @Param("title") String title,
            @Param("publishTimeStart") Date publishTimeStart,
            @Param("publishTimeEnd") Date publishTimeEnd,
            @Param("status") Byte status,
            @Param("orderBy") Integer orderBy,
            @Param("userId") Integer userId,
            @Param("channelId") Integer channelId);

    /**
     * 根据文章id将文章阅读数增加到指定数
     *
     * @param articleId
     * @param count
     * @return
     */
    Integer updateArticleClickCountPlus1ByArticleId(
            @Param("articleId") Integer articleId,
            @Param("count") Integer count);

    //查询标题是否被占用 不包含自己ID
    int selectTitleByIndex(@Param("title") String title, @Param("notIncludeId") Integer includeThis);


    List<ArticleModel> selectArticleByIds(@Param("list") List<Integer> list, @Param("pageNo") Integer pageNo, @Param("pageSize") Integer pageSize);

    int selectArticleByIdsCount(List<Integer> list);



    List<ArticleModel> selectArticleByLike(@Param("name") String name, @Param("pageNo") Integer pageNo, @Param("pageSize") Integer pageSize);

    int selectArticleByLikeCount(String name);
}