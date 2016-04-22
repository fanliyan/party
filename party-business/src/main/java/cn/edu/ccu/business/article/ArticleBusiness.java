package cn.edu.ccu.business.article;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.business.word.SensitiveWordsBusiness;
import cn.edu.ccu.data.TransactionManagerName;
import cn.edu.ccu.data.article.ArticleModelMapper;
import cn.edu.ccu.ibusiness.article.IArticle;
import cn.edu.ccu.ibusiness.article.IArticleChannel;
import cn.edu.ccu.ibusiness.article.IArticleModifyLog;
import cn.edu.ccu.ibusiness.system.IUser;
import cn.edu.ccu.ibusiness.word.ISensitiveWords;
import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.SplitPageResponse;
import cn.edu.ccu.model.article.*;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.user.UserModel;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.constants.ArticleModifyLogStatus;
import cn.edu.ccu.utils.common.constants.ArticleStatus;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


@Service
public class ArticleBusiness implements IArticle {

    @Autowired
    private ArticleModelMapper articleModelMapper;

    @Autowired
    private IUser iUser;
    @Autowired
    private IArticleModifyLog iArticleModifyLog;
    @Autowired
    private IArticleChannel iArticleChannel;

    //文章内容分页分隔符
    private final String _splitStr = "_ueditor_page_break_tag_";


    /**
     * 查询文章列表
     *
     * @param request ArticleListRequest
     * @return ArticleListResponse
     * @throws Exception
     */
    @Override
    public ArticleListResponse articleList(ArticleListRequest request) throws Exception {

        ArticleListResponse response = null;
        if (request != null) {

            //该方法为网站API调用，只出去发布时间小于当前时间的文章 不允许查询还未发布的文章
            Date publishEndTime = Calendar.getInstance().getTime();
            if (request.getEndTime() != null) {
                if (request.getEndTime().compareTo(publishEndTime) > 0) {
                    request.setEndTime(publishEndTime);
                }
            } else {
                request.setEndTime(publishEndTime);
            }

            //默认查询发布状态文章
            if (request.getStatus() == null) {
                request.setStatus(ArticleStatus.SUCCESS);
            }

            ArticleModel articleModel = new ArticleModel();
            articleModel.setTitle(request.getTitle());
            articleModel.setUserId(request.getUserId());
            articleModel.setStatus(request.getStatus());
            articleModel.setChannelCount(request.getChannelIdCount());


            return articleList(articleModel, request.getSplitPage(), request.getStartTime(), request.getEndTime(), request.getOrderBy(), request.getIsReturnUserData());

        } else {
            response = new ArticleListResponse();
        }

        return response;
    }

    @Override
    public ArticleListResponse articleList(ArticleModel model, SplitPageRequest pageRequest, Date publishTimeStart, Date publishTimeEnd, Integer orderby, Boolean returnUserInfo) throws Exception {


        String title = StringExtention.isNullOrEmpty(model.getTitle()) ? null : model.getTitle();


        ArticleListResponse response = new ArticleListResponse();

        Integer rowStart = UtilsBusiness.getRowStart(pageRequest);
        Integer pageSize = UtilsBusiness.getRowCount(pageRequest);

        List<ArticleModel> articleModels = articleModelMapper.selectArticleByRequirement(StringExtention.isNullOrEmpty(title) ? null : title,
                publishTimeStart, publishTimeEnd, model.getStatus(),
                orderby, model.getUserId(), rowStart, pageSize, model.getChannelCount());

        if (articleModels != null && articleModels.size() > 0) {
            for (ArticleModel articleModel : articleModels) {
                //设置扩展信息
                setArticleExtentionInfo(articleModel, returnUserInfo);
            }
        }

        response.setArticleModelList(articleModels);

        if (pageRequest != null && pageRequest.isReturnCount()) {
            int rowCount = articleModelMapper.selectArticleByRequirementCount(
                    StringExtention.isNullOrEmpty(title) ? null : title,
                    publishTimeStart, publishTimeEnd, model.getStatus(),
                orderby, model.getUserId(), model.getChannelCount());
            SplitPageResponse pageResponse = UtilsBusiness.getSplitPageResponse(rowCount, pageSize, pageRequest.getPageNo());
            response.setSplitPage(pageResponse);
        }


        return response;
    }

    /**
     * 根据ID查询文章完整信息(检查权限)
     *
     * @param id 文章ID
     * @return ArticleModel
     * @throws Exception
     */
    public ArticleModel selectFullById(Integer id) throws Exception {

        return selectFullById(id, true);
    }

    /**
     * 查询文章详情
     *
     * @param id              文章ID
     * @param checkStatus     是否检查文章状态
     * @return ArticleModel
     * @throws Exception
     */
    @Override
    public ArticleModel selectFullById(Integer id, boolean checkStatus) throws Exception {

        if (!IntegerExtention.hasValueAndMaxZero(id)) {
            throw new BusinessException(ErrorCodeEnum.requestParamError);
        }

        ArticleModel articleModel = articleModelMapper.selectByPrimaryKey(id);

        if (articleModel != null) {

            //是否检查文章状态
            if (checkStatus
                    && articleModel.getStatus() != null
                    //草稿状态 可显示
                    && articleModel.getStatus() < -1) {

                switch (articleModel.getStatus()) {
                    case -3:
                    case -4:
                        throw new BusinessException(ErrorCodeEnum.ArticleNoCanDisplay);
                    default:
                        throw new BusinessException(ErrorCodeEnum.ArticleNoCanDisplay);
                }
            }
            //设置文章扩展信息
            setArticleExtentionInfo(articleModel, true);

            //设置文章渠道
            if (articleModel.getChannelCount() != null) {
                List<ArticleChannelModel> articleChannelModelList = channelCountToModelList(articleModel.getChannelCount());
                articleModel.setArticleChannelModelList(articleChannelModelList);
            }
        }

        return articleModel;
    }

    /**
     * API获取文章详情 （会增加点击数）
     *
     * @param request     ArticleGetRequest
     * @param requestHead RequestHead
     * @return ArticleGetResponse
     * @throws Exception
     */
    @Override
    public ArticleGetResponse selectArticleById(ArticleGetRequest request, RequestHead requestHead) throws Exception {

        ArticleGetResponse response = new ArticleGetResponse();
        if (request != null && IntegerExtention.hasValueAndMaxZero(request.getArticleId())) {

            ArticleModel article = this.selectFullById(request.getArticleId());

            //更新文章阅读数
            articleModelMapper.updateArticleClickCountPlus1ByArticleId(article.getArticleId(), 1);

            response.setArticleModel(article);
        }
        return response;
    }

    /**
     * 设置文章扩展信息
     *
     * @param article ArticleModel
     * @throws Exception
     */
    private void setArticleExtentionInfo(ArticleModel article, Boolean returnUserInfo) throws Exception {

        if (article != null) {
            //设置user信息
            if (IntegerExtention.hasValueAndMaxZero(article.getUserId()) && returnUserInfo != null && returnUserInfo) {
                UserModel userModel = iUser.getSimpleUserModelByUserId(article.getUserId());
                article.setUserModel(userModel);
            }

        }
    }


    /**
     * 文章校验
     *
     * @param article ArticleModel
     */
    private void articleCheck(ArticleModel article) {
        //标题 摘要 内容 状态 校验
        if (article == null
                || StringExtention.isTrimNullOrEmpty(article.getTitle())
                || article.getTitle().length() > 300
                || StringExtention.isTrimNullOrEmpty(article.getSummary())
                || article.getSummary().length() > 1000
                || StringExtention.isTrimNullOrEmpty(article.getContent())
                || article.getStatus() == null
                || article.getStatus() > 1 || article.getStatus() < -4
                ) {
            throw new BusinessException(ErrorCodeEnum.requestParamError);
        }

        //校验敏感词
        if(SensitiveWordsBusiness.wordsIsSensitive(article.getContent())){
            throw new BusinessException("请检查是否带有敏感词汇");
        }
        if(SensitiveWordsBusiness.wordsIsSensitive(article.getSummary())){
            throw new BusinessException("请检查是否带有敏感词汇");
        }

        //标题 唯一性校验
        if (articleModelMapper.selectTitleByIndex(article.getTitle(), article.getArticleId()) > 0) {
            throw new BusinessException(ErrorCodeEnum.titleExist);
        }

    }


    //文章渠道 对应转换方法 8421
    private int articleChannelTransformation(Byte[] channels) {

        StringBuffer countBinary = new StringBuffer();
        //有多少选项 就有多少位
        int count = iArticleChannel.count();
        for (int i = 0; i < count; i++) {
            countBinary.append("0");
        }
        //转换为二进制 选择第一个代表第一位是1 从右往左
        for (Byte c : channels) {
            countBinary.setCharAt(countBinary.length() - c, '1');
        }

        //返回之和 十进制
        return Integer.parseInt(countBinary.toString(), 2);
    }

    //文章渠道ID和 转换为modelList 对应转换方法 8421
    private List<ArticleChannelModel> channelCountToModelList(int channelCount) {

        List<ArticleChannelModel> articleChannelModelList = new ArrayList<>();
        //从左往右
        StringBuffer binaryString = new StringBuffer(Integer.toBinaryString(channelCount)).reverse();

        for (int i = 1; i <= binaryString.length(); i++) {
            //第几位是1第几个id就是
            if (binaryString.charAt(i - 1) == '1') {
                ArticleChannelModel articleChannelModel = iArticleChannel.selectById(i);
                articleChannelModelList.add(articleChannelModel);
            }
        }

        return articleChannelModelList;
    }


    /**
     * 添加文章
     *
     * @param articleModel ArticleModel
     * @param channels     Byte[]
     * @return boolean
     * @throws Exception
     */
    @Override
    @Transactional(TransactionManagerName.partyTransactionManager)
    public boolean addArticle(ArticleModel articleModel, Byte[] channels) throws Exception {

        //校验
        this.articleCheck(articleModel);

        //默认发布时间为当前时间
        if (articleModel.getPublishTime() == null) {
            articleModel.setPublishTime(new Date());
        }

        //添加频道
        if (channels != null && channels.length > 0) {
            int channelId = articleChannelTransformation(channels);
            articleModel.setChannelCount(channelId);
        }

        int i = articleModelMapper
                .insertSelective(articleModel);

        if (i > 0) {
            iArticleModifyLog.addLog(articleModel, articleModel.getUserId(), ArticleModifyLogStatus.AddArticle);
        }

        return i > 0;
    }

    /**
     * 修改文章
     *
     * @param articleModel ArticleModel
     * @param channels     Byte[]
     * @param update       boolean
     * @param userId       Integer
     * @return boolean
     * @throws Exception
     */
    @Override
    @Transactional(TransactionManagerName.partyTransactionManager)
    public boolean updateArticle(
            ArticleModel articleModel, Byte[] channels, boolean update, Integer userId) throws Exception {

        //是否更新文章
        if (update) {

            //校验
            this.articleCheck(articleModel);

            //添加频道
            if (channels != null && channels.length > 0) {
                int channelId = articleChannelTransformation(channels);
                articleModel.setChannelCount(channelId);
            }

            iArticleModifyLog.addLog(articleModel.getArticleId(), userId, ArticleModifyLogStatus.Editcontent);
        } else {

            iArticleModifyLog.addLog(articleModel.getArticleId(), userId, ArticleModifyLogStatus.EditStatus, articleModel.getStatus());
        }

        int i = articleModelMapper
                .updateByPrimaryKeySelective(articleModel);

        return i > 0;
    }


    /**
     * 删除文章
     *
     * @param articleId Integer
     * @param userId    Integer
     * @return boolean
     * @throws Exception
     */
    @Override
    @Transactional(TransactionManagerName.partyTransactionManager)
    public boolean delArticle(Integer articleId, Integer userId) throws Exception {

        ArticleModel articleModel = new ArticleModel();
        articleModel.setArticleId(articleId);
        articleModel.setStatus(ArticleStatus.ADMIN_DELETE);

        iArticleModifyLog.addLog(articleId, userId, ArticleModifyLogStatus.EditStatus);

        int i = articleModelMapper.updateByPrimaryKeySelective(articleModel);

        return i > 0;
    }

}
