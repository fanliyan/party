package cn.edu.ccu.business.article;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.business.word.SensitiveWordsBusiness;
import cn.edu.ccu.data.TransactionManagerName;
import cn.edu.ccu.data.article.ArticleModelMapper;
import cn.edu.ccu.data.article.ArticleWordsIndexModelMapper;
import cn.edu.ccu.ibusiness.article.IArticle;
import cn.edu.ccu.ibusiness.article.IArticleChannel;
import cn.edu.ccu.ibusiness.article.IArticleModifyLog;
import cn.edu.ccu.ibusiness.system.IUser;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.wltea.analyzer.core.IKSegmenter;
import org.wltea.analyzer.core.Lexeme;

import java.io.StringReader;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@Service
public class ArticleBusiness implements IArticle {

    @Autowired
    private ArticleModelMapper articleModelMapper;
    @Autowired
    private ArticleWordsIndexModelMapper articleWordsIndexModelMapper;

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


    public ArticleListResponse searchArticleList(String words, SplitPageRequest splitPageRequest) throws Exception {

        if (StringExtention.isTrimNullOrEmpty(words))
            throw new BusinessException("请输入关键字");

        //分词
        Map<String, Integer> stringIntegerMap = this.getWordsTimes(words);

        List stringList = Arrays.asList(stringIntegerMap.keySet().toArray());

        ArticleListResponse response = new ArticleListResponse();

        if (stringList != null && stringList.size() > 0) {

            List<Integer> articleIds = articleWordsIndexModelMapper.selectByKeyWords(stringList);

            if (articleIds != null && articleIds.size() > 0) {

                Integer rowStart = UtilsBusiness.getRowStart(splitPageRequest);
                Integer pageSize = UtilsBusiness.getRowCount(splitPageRequest);

                List<ArticleModel> articleModels = articleModelMapper.selectArticleByIds(articleIds, rowStart, pageSize);


                if (articleModels == null || articleModels.size() == 0) {
                    articleModels = articleModelMapper.selectArticleByLike(words, rowStart, pageSize);
                }

                response.setArticleModelList(articleModels);

                if (splitPageRequest != null && splitPageRequest.isReturnCount()) {

                    int rowCount;
                    if (articleModels == null || articleModels.size() == 0) {
                        rowCount = articleModelMapper.selectArticleByLikeCount(words);
                    } else {
                        rowCount = articleModelMapper.selectArticleByIdsCount(articleIds);
                    }
                    SplitPageResponse pageResponse = UtilsBusiness.getSplitPageResponse(rowCount, pageSize, splitPageRequest.getPageNo());

                    response.setSplitPage(pageResponse);
                }
            }
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
                orderby, model.getUserId(), rowStart, pageSize, articleChannelTransformation(model.getChannelCount()));

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
                    orderby, model.getUserId(), articleChannelTransformation(model.getChannelCount()));
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
     * @param id          文章ID
     * @param checkStatus 是否检查文章状态
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
     * @param request ArticleGetRequest
     * @return ArticleGetResponse
     * @throws Exception
     */
    @Override
    public ArticleGetResponse selectArticleById(ArticleGetRequest request) throws Exception {

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
                || (article.getSummary() != null && article.getSummary().length() > 1000)
                || StringExtention.isTrimNullOrEmpty(article.getContent())
                || article.getStatus() == null
                || article.getStatus() > 1 || article.getStatus() < -4
                ) {
            throw new BusinessException(ErrorCodeEnum.requestParamError);
        }

        //校验敏感词
        if (SensitiveWordsBusiness.wordsIsSensitive(article.getTitle())) {
            throw new BusinessException("请检查标题是否带有敏感词汇");
        }
        if (SensitiveWordsBusiness.wordsIsSensitive(article.getSummary())) {
            throw new BusinessException("请检查摘要是否带有敏感词汇");
        }
        if (SensitiveWordsBusiness.wordsIsSensitive(article.getContent())) {
            throw new BusinessException("请检查内容是否带有敏感词汇");
        }

        //标题 唯一性校验
        if (articleModelMapper.selectTitleByIndex(article.getTitle(), article.getArticleId()) > 0) {
            throw new BusinessException(ErrorCodeEnum.titleExist);
        }

    }


    //文章渠道 对应转换方法 8421
    private int articleChannelTransformation(byte[] channels) {

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

    //文章渠道 对应转换方法 8421
    private Integer articleChannelTransformation(Integer channel) {

        if (channel == null)
            return null;

        StringBuffer countBinary = new StringBuffer();
        //有多少选项 就有多少位
        int count = iArticleChannel.count();
        for (int i = 0; i < count; i++) {
            countBinary.append("0");
        }
        //转换为二进制 选择第一个代表第一位是1 从右往左
        countBinary.setCharAt(countBinary.length() - channel, '1');

        //返回之和 十进制
        return Integer.parseInt(countBinary.toString(), 2);
    }

    //文章渠道ID和 转换为modelList 对应转换方法 8421
    private List<ArticleChannelModel> channelCountToModelList(Integer channelCount) {

        if (!IntegerExtention.hasValueAndMaxZero(channelCount))
            return null;

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
    public boolean addArticle(ArticleModel articleModel, byte[] channels) throws Exception {

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
            //记录日志
            iArticleModifyLog.addLog(articleModel, articleModel.getUserId(), ArticleModifyLogStatus.AddArticle);

            //添加索引
            this.addIndex(articleModel);
        }

        return i > 0;
    }

    private void addIndex(ArticleModel articleModel) throws Exception {

        //添加索引

        String regex_html = "<[^>]+>";
        String regex_space = "(\\n|\\r|\\t)+?";

        //加逗号防止语义混乱嘛
        //直接标题 摘要 内容一起 分词~~~
        String str = "";

        String title = articleModel.getTitle();
        str += ("," + title);

        String summary = articleModel.getSummary();
        if (!StringExtention.isTrimNullOrEmpty(summary))
            str += ("," + summary);

        String content = articleModel.getContent();

        //清除
        if (!StringExtention.isTrimNullOrEmpty(content)) {
            Matcher m_content = Pattern.compile(regex_html).matcher(content);
            content = m_content.replaceAll("");
            m_content = Pattern.compile(regex_space).matcher(content);
            content = m_content.replaceAll("");
        }

        str += ("," + content);

        //次数统计
        Map<String, Integer> wordsTimesMap = this.getWordsTimes(str);

        //  词-次数 map   大于多少次    要多少个    最多多少个
        List<String> wordsList = this.getKeyWordsList(wordsTimesMap, 2, 10, 100);

        this.insertBatch(wordsList, articleModel.getArticleId());
    }


    //分词
    private Map<String, Integer> getWordsTimes(String content) throws Exception {

        Map<String, Integer> words_times = new HashMap<>();

        //分词 整词不包含在里面 但可能包含
        StringReader re = new StringReader(content);
        // 当为true时，分词器进行最大词长切分
        IKSegmenter ik = new IKSegmenter(re, true);

        Lexeme lex;
        while ((lex = ik.next()) != null) {

            String string = lex.getLexemeText();

            if (string.length() > 1) {
                //一个字不算词

                //是否存在
                Integer times = words_times.get(string);
                if (times == null) {
                    words_times.put(string, 1);
                } else {
                    times++;
                    words_times.put(string, times);
                }
            }
        }

        return words_times;
    }

    //  词-次数 map   大于多少次    要多少个    最多多少个
    private List<String> getKeyWordsList(Map<String, Integer> words_times, Integer times, Integer count, Integer maxSize) {

        List<String> wordsArticleIdList = new ArrayList<>();

        if (words_times != null && words_times.size() > 0) {

            //sortMap排序后 词典 列表
            TreeMap<String, Integer> sortMap = new TreeMap<>(new ValueComparator(words_times));

            sortMap.putAll(words_times);

            if (!IntegerExtention.hasValueAndMaxZero(times)) {
                times = 1;
            }
            if (!IntegerExtention.hasValueAndMaxZero(count)) {
                count = 30;
            }
            if (!IntegerExtention.hasValueAndMaxZero(maxSize)) {
                maxSize = 5;
            }


            //是否存在该词
            int i = 0;

            for (Map.Entry<String, Integer> entry : sortMap.entrySet()) {
                //只取最多的 count 个
                if (i > count) {
                    break;
                }
                //至少要一次以上
                if (entry.getValue() > 1 && entry.getValue() >= times) {
                    //最多只取 maxSize 个
                    if (wordsArticleIdList.size() > maxSize) {
                        break;
                    }

                    wordsArticleIdList.add(entry.getKey());
                }
                i++;
            }

            //长度大于3的词更为关键
//            for (Map.Entry<String, Integer> entry : sortMap.entrySet()) {
//                if (entry.getKey().length() >= 3&&entry.getValue()>2 ) {
//                    wordsArticleIdList.add(entry.getKey());
//                }
//            }


        }
        return wordsArticleIdList;
    }

    //通过value 倒叙排序
    private class ValueComparator implements Comparator<String> {

        private Map<String, Integer> base;

        ValueComparator(Map<String, Integer> base) {
            this.base = base;
        }

        public int compare(String a, String b) {
            if (base.get(a) >= base.get(b)) {
                return -1;
            } else {
                return 1;
            }
        }
    }

    private void insertBatch(List<String> list, Integer articleId) {

        articleWordsIndexModelMapper.deleteByArticle(articleId);

        if (list != null && list.size() > 0) {
            for (String s : list) {
                try {
                    ArticleWordsIndexModelKey articleWordsIndexModelKey = new ArticleWordsIndexModelKey();
                    articleWordsIndexModelKey.setWords(s);
                    articleWordsIndexModelKey.setArticleId(articleId);

                    articleWordsIndexModelMapper.insertSelective(articleWordsIndexModelKey);
                } catch (Exception e) {
                }
            }
        }
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
            ArticleModel articleModel, byte[] channels, boolean update, Integer userId) throws Exception {

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

            //添加索引
            this.addIndex(articleModel);
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
