package cn.edu.ccu.ibusiness.article;

import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.article.*;

import java.util.Date;
import java.util.List;



/**
 * @author kuangye
 * @Description: 文章相关业务逻辑处理类接口
 * @date 2016/4/13.
 */
public interface IArticle {

    /**
     * 文章列表
     *
     * @param request
     * @return
     * @throws Exception
     */
    ArticleListResponse articleList(ArticleListRequest request) throws Exception;


    /**
     * 根据ID查询完整文章信息
     *
     * @param id
     * @return
     * @throws Exception
     */
    ArticleModel selectFullById(Integer id) throws Exception;

    /**
     * 据ID查询完整文章信息
     *
     * @param id
     * @param checkStatus 是否校验文章状态
     * @return
     * @throws Exception
     */
    ArticleModel selectFullById(Integer id, boolean checkStatus) throws Exception;


    ArticleListResponse articleList(ArticleModel model, SplitPageRequest pageRequest, Date publishTimeStart, Date publishTimeEnd, Integer orderby, Boolean returnUserInfo) throws Exception;

    //API根据请求查询文章
    ArticleGetResponse selectArticleById(ArticleGetRequest request) throws Exception;

    //添加文章
    boolean addArticle(
            ArticleModel ArticleModel, Byte[] channels) throws Exception;

    //修改文章
    boolean updateArticle(
            ArticleModel ArticleModel, Byte[] channels, boolean update, Integer userId) throws Exception;

    //删除文章
    boolean delArticle(Integer id, Integer userId) throws Exception;


}
