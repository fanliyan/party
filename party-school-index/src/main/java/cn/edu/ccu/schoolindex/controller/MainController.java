package cn.edu.ccu.schoolindex.controller;

import cn.edu.ccu.ibusiness.article.IArticle;
import cn.edu.ccu.ibusiness.article.IArticleChannel;
import cn.edu.ccu.ibusiness.common.IBannerConfig;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.article.*;
import cn.edu.ccu.model.common.BannerConfigModel;
import cn.edu.ccu.utils.common.extention.StringExtention;
import cn.edu.ccu.utils.common.web.WebHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Created by ky on 2016/4/15.
 */
@Controller
public class MainController extends BaseController {

    @Autowired
    private IArticle iArticle;
    @Autowired
    private IArticleChannel iArticleChannel;
    @Autowired
    private IBannerConfig iBannerConfig;

    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");


    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView school(HttpServletRequest request, HttpServletResponse response) throws Exception {

        ModelAndView mav = super.getModelAndView("/school", request);

        ArticleListRequest articleListRequest = new ArticleListRequest();
        SplitPageRequest splitPageRequest = new SplitPageRequest();
        splitPageRequest.setPageSize(5);
        splitPageRequest.setReturnCount(false);
        articleListRequest.setSplitPage(splitPageRequest);
        ArticleModel articleModel = new ArticleModel();

        //通知公告
        articleModel.setChannelCount(15);
        ArticleListResponse tzgg = iArticle.articleList(articleModel, splitPageRequest, null, null, null, false);
        mav.addObject("tzgg", tzgg.getArticleModelList());
        //党校新闻
        articleModel.setChannelCount(14);
        ArticleListResponse dxxw = iArticle.articleList(articleModel, splitPageRequest, null, null, null, false);
        mav.addObject("dxxw", dxxw.getArticleModelList());

        //banner
        List<BannerConfigModel> bannerConfigModelList = iBannerConfig.selectByType(2);
        mav.addObject("banner",bannerConfigModelList);

        return mav;
    }


    /**
     * 文章列表 - 党校
     */
    @RequestMapping(value = "/list/{id}")
    public ModelAndView list_dx(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            SplitPageRequest pageRequest, @PathVariable("id") Integer id
    ) throws Exception {

        ModelAndView mav = super.getModelAndView("/list", httpRequest);
        ArticleListRequest request = new ArticleListRequest();
        pageRequest.setReturnCount(true);
        request.setSplitPage(pageRequest);

        ArticleModel articleModel = new ArticleModel();
        articleModel.setChannelCount(id);
        ArticleListResponse response = iArticle.articleList(articleModel, pageRequest, null, null, null, false);

        //如果只有一篇文章返回列表
        if (response.getArticleModelList() != null
//                && response.getArticleModelList().size() == 1
                && response.getSplitPage().getRecordCount() == 1) {

            ArticleGetRequest articleGetRequest = new ArticleGetRequest();
            articleGetRequest.setArticleId(response.getArticleModelList().get(0).getArticleId());
            ArticleGetResponse articleGetResponse = iArticle.selectArticleById(articleGetRequest);

            mav.addObject("article", articleGetResponse.getArticleModel());
            mav.setViewName("content");
        } else {
            mav.addObject("response", response);
        }

        ArticleChannelModel articleChannelModel = iArticleChannel.selectById(id);
        mav.addObject("channel", articleChannelModel.getName());
        WebHelper.setCookie(httpResponse, "channel", articleChannelModel.getName());

        mav.addObject("id", id);

        //左侧栏
        List<ArticleChannelModel> channelModelList = iArticleChannel.selectByFatherId(id, true);
        mav.addObject("left", channelModelList);

        return mav;
    }


    /**
     * 文章 详情 - 党校
     */
    @RequestMapping(value = "/article/{id}", method = RequestMethod.GET)
    public ModelAndView content_dx(@PathVariable("id") Integer id,
                                   HttpServletRequest request, HttpServletResponse response) throws Exception {

        ModelAndView mav = super.getModelAndView("/content", request);

        ArticleGetRequest articleGetRequest = new ArticleGetRequest();
        articleGetRequest.setArticleId(id);
        ArticleGetResponse articleGetResponse = iArticle.selectArticleById(articleGetRequest);

        String channel = WebHelper.getCookie(request, "channel");
        if(!StringExtention.isTrimNullOrEmpty(channel))
            mav.addObject("channel", URLDecoder.decode(channel, "utf-8"));

        mav.addObject("article", articleGetResponse.getArticleModel());
        return mav;
    }


    /**
     * 文章 搜索
     */
    @RequestMapping(value = "/search")
    public ModelAndView search(String w, SplitPageRequest splitPageRequest, HttpServletRequest request, HttpServletResponse response) throws Exception {

        ModelAndView mav = super.getModelAndView("search", request);

        splitPageRequest.setReturnCount(true);
        ArticleListResponse articleListResponse = iArticle.searchArticleList(w, splitPageRequest);

        mav.addObject("w",w);

        mav.addObject("response", articleListResponse);

        return mav;
    }


}
