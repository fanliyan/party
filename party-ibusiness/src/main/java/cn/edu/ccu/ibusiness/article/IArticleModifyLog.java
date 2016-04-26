package cn.edu.ccu.ibusiness.article;


import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.article.ArticleModel;
import cn.edu.ccu.model.article.ArticleModifyLogListResponse;

/**
 * Created by kuangye on 2015/9/24.
 */


public interface IArticleModifyLog {

    //用于修改状态（更新文章）
    boolean addLog(Integer articleId, Integer userId, Byte modifyType) throws Exception;
    //用于修改状态（不更新文章）
    boolean addLog(Integer articleId, Integer userId, Byte modifyType, Byte oldStatus) throws Exception;
    //添加文章
    boolean addLog(ArticleModel articleModel, Integer userId, Byte modifyType) throws Exception;

    boolean addLog(ArticleModel articleModel, Integer userId, Byte modifyType, Byte oldStatus) throws Exception;

    ArticleModifyLogListResponse articleModifyLogList(Integer articleId, SplitPageRequest splitPageRequest) throws Exception;

    ArticleModel articleHistoryPreview(Integer articleLogId) throws Exception;

}
