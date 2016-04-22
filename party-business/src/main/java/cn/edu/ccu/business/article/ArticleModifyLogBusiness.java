package cn.edu.ccu.business.article;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.data.article.ArticleModifyLogModelMapper;
import cn.edu.ccu.data.user.UserModelMapper;
import cn.edu.ccu.ibusiness.article.IArticle;
import cn.edu.ccu.ibusiness.article.IArticleModifyLog;
import cn.edu.ccu.ibusiness.system.IUser;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.article.ArticleModel;
import cn.edu.ccu.model.article.ArticleModifyLogListResponse;
import cn.edu.ccu.model.article.ArticleModifyLogModel;
import cn.edu.ccu.model.user.UserModel;
import cn.edu.ccu.utils.common.constants.ArticleModifyLogStatus;
import cn.edu.ccu.utils.common.constants.ArticleStatus;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


/**
 * 文章操作日志
 * Created by kuangye on 2015/9/24.
 */

@Service
public class ArticleModifyLogBusiness implements IArticleModifyLog {

    @Autowired
    private ArticleModifyLogModelMapper articleModifyLogModelMapper;
    @Autowired
    private IArticle iArticle;
    @Autowired
    private IUser iUser;

    @Override
    public boolean addLog(Integer articleId, Integer userId, Byte modifyType) throws Exception {

        return addLog(articleId, userId, modifyType, null);
    }

    @Override
    public boolean addLog(Integer articleId, Integer userId, Byte modifyType, Byte oldStatus) throws Exception {

        ArticleModel articleModel = iArticle.selectFullById(articleId, false);

        return addLog(articleModel, userId, modifyType, oldStatus);
    }

    @Override
    public boolean addLog(ArticleModel articleModel, Integer userId, Byte modifyType) throws Exception {
        return addLog(articleModel, userId, modifyType, null);
    }

    @Override
    public boolean addLog(ArticleModel articleModel, Integer userId, Byte modifyType, Byte oldStatus) throws Exception {

        ArticleModifyLogModel articleModifyLogModel = new ArticleModifyLogModel();

        //修改状态时 添加描述
        if (oldStatus != null) {
            if (modifyType != null && modifyType.equals(ArticleModifyLogStatus.EditStatus)) {
                articleModifyLogModel.setDescription(ArticleStatus.getStatus(oldStatus) + " -> " + ArticleStatus.getStatus(articleModel.getStatus()));
            }
        }

        String jsonString = new ObjectMapper().writeValueAsString(articleModel);

        articleModifyLogModel.setModifyBeforeData(jsonString);
        articleModifyLogModel.setModifyType(modifyType);
        articleModifyLogModel.setUserId(userId);
        articleModifyLogModel.setArticleId(articleModel.getArticleId());

        if (articleModifyLogModelMapper.insertSelective(articleModifyLogModel) > 0) {
            return true;
        }
        return false;
    }

    /**
     * 文章历史记录 列表
     *
     * @param articleId        文章ID
     * @param splitPageRequest
     * @return
     * @throws Exception
     */
    @Override
    public ArticleModifyLogListResponse articleModifyLogList(Integer articleId, SplitPageRequest splitPageRequest) throws Exception {

        ArticleModifyLogListResponse response = new ArticleModifyLogListResponse();

        Integer start = null;
        Integer count = null;
        if (splitPageRequest != null && splitPageRequest.isReturnCount()) {
            start = UtilsBusiness.getRowStart(splitPageRequest);
            count = UtilsBusiness.getRowCount(splitPageRequest);

            int rowCount = articleModifyLogModelMapper.selectCountByArticle(articleId);
            response.setSplitPage(UtilsBusiness.getSplitPageResponse(rowCount, splitPageRequest.getPageSize(), splitPageRequest.getPageNo()));
        }

        List<ArticleModifyLogModel> list = articleModifyLogModelMapper.selectByArticle(articleId, start, count);

        //装配操作用户
        List<Integer> ids = new ArrayList<>();
        for (ArticleModifyLogModel articleModifyLogModel : list) {
            if (articleModifyLogModel.getUserId() > 0) {
                ids.add(articleModifyLogModel.getUserId());
            }
        }

        List<UserModel> userModelList = iUser.selectByUserIds(ids);

        for (ArticleModifyLogModel articleModifyLogModel : list) {
            if (articleModifyLogModel.getUserId() > 0) {
                for (UserModel userModel : userModelList) {
                    if (articleModifyLogModel.getUserId().equals(userModel.getUserId()))
                        articleModifyLogModel.setUserModel(userModel);
                }
            }
        }

        response.setArticleModifyLogList(list);

        return response;
    }

    @Override
    public ArticleModel articleHistoryPreview(Integer articleLogId) throws Exception {

        ArticleModifyLogModel model = articleModifyLogModelMapper.selectByPrimaryKey(articleLogId);

        ObjectMapper objectMapper = new ObjectMapper();
        ArticleModel articleModel = objectMapper.readValue(model.getModifyBeforeData(), ArticleModel.class);

        return articleModel;
    }


}
