package cn.edu.ccu.index.controller;

import cn.edu.ccu.ibusiness.article.IArticle;
import cn.edu.ccu.ibusiness.article.IArticleChannel;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.article.*;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by ky on 2016/4/15.
 */
@Controller
public class MainController extends BaseController {

    @Autowired
    private IArticle iArticle;
    @Autowired
    private IArticleChannel iArticleChannel;

    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");


    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response) {

        ModelAndView mav = super.getModelAndView("index", request);

        return mav;
    }


    @RequestMapping(value = "/school", method = RequestMethod.GET)
    public ModelAndView school(HttpServletRequest request, HttpServletResponse response) {

        ModelAndView mav = super.getModelAndView("school", request);

        return mav;
    }

    /**
     * 文章列表
     */
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public ModelAndView list(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            ArticleModel model, SplitPageRequest pageRequest,
            String publishTimeStartString, String publishTimeEndString
    ) throws Exception {

        ModelAndView mav = super.getModelAndView("list", httpRequest);
        ArticleListRequest request = new ArticleListRequest();

        pageRequest.setReturnCount(true);
        request.setSplitPage(pageRequest);

        Date publishTimeStart = null;
        if (!StringExtention.isNullOrEmpty(publishTimeStartString, true)) {
            publishTimeStart = sdf.parse(publishTimeStartString);
        }
        Date publishTimeEnd = null;
        if (!StringExtention.isNullOrEmpty(publishTimeEndString, true)) {
            publishTimeEnd = sdf.parse(publishTimeEndString);
        }


        ArticleListResponse response = iArticle.articleList(model, pageRequest, publishTimeStart, publishTimeEnd, null, true);


        mav.addObject("article", model);
        mav.addObject("publishTimeStart", publishTimeStart);
        mav.addObject("publishTimeEnd", publishTimeEnd);

        mav.addObject("articleChannelList", iArticleChannel.select());

        mav.addObject("response", response);

        return mav;
    }


    /**
     * 文章 详情
     */
    @RequestMapping(value = "/article/{id}", method = RequestMethod.GET)
    public ModelAndView content(@PathVariable("id") Integer id,
                                HttpServletRequest request, HttpServletResponse response) throws Exception {

        ModelAndView mav = super.getModelAndView("content", request);

        ArticleGetRequest articleGetRequest = new ArticleGetRequest();
        articleGetRequest.setArticleId(id);
        ArticleGetResponse articleGetResponse = iArticle.selectArticleById(articleGetRequest);

        mav.addObject("article", articleGetResponse.getArticleModel());
        return mav;
    }

}
