package cn.edu.ccu.manage.controller.article;

import cn.edu.ccu.ibusiness.article.IArticle;
import cn.edu.ccu.ibusiness.article.IArticleChannel;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.AuthHelper;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.article.ArticleListRequest;
import cn.edu.ccu.model.article.ArticleListResponse;
import cn.edu.ccu.model.article.ArticleModel;
import cn.edu.ccu.model.user.UserModel;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import cn.edu.ccu.utils.common.web.RequestParamHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 文章相关 Created by kuangye on 2015/9/22.
 */
@Controller
@RequestMapping("/article")
@AuthController(moduleId = 4)
public class ArticleController extends BaseController {

    @Autowired
    IArticle iArticle;
    @Autowired
    IArticleChannel iArticleChannel;


   private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    /**
     * 文章列表
     */
    @RequestMapping("/list")
    public ModelAndView list(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            ArticleModel model, SplitPageRequest pageRequest,
            String publishTimeStartString, String publishTimeEndString
    ) throws Exception {

        ModelAndView mav = Common.getLoginModelAndView(httpRequest);
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


        ArticleListResponse response = iArticle.articleList(model,pageRequest,publishTimeStart,publishTimeEnd,null,true);


        mav.addObject("article", model);
        mav.addObject("publishTimeStart", publishTimeStart);
        mav.addObject("publishTimeEnd", publishTimeEnd);

        mav.addObject("articleChannelList", iArticleChannel.select());

        mav.addObject("response", response);

        mav.setViewName("article/articleList");
        return mav;
    }


    /**
     * 添加 文章
     */
    @RequestMapping("/add")
    public ModelAndView addArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        mav.addObject("articleChannelList", iArticleChannel.select());

        mav.setViewName("article/articleEdit");
        return mav;
    }


    /**
     * 编辑 文章
     */
    @RequestMapping("/edit")
    public ModelAndView editArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            Integer articleId) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        mav.addObject("article", iArticle.selectFullById(articleId, false));

        mav.addObject("articleChannelList", iArticleChannel.select());

        mav.setViewName("article/articleEdit");
        return mav;
    }


    /**
     * 预览 文章
     */
    @RequestMapping("/previewArticle")
    public ModelAndView previewArticle(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            Integer articleId) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        mav.addObject("article", iArticle.selectFullById(articleId, false));

        mav.setViewName("article/previewArticle");
        return mav;
    }


    /**
     * 保存 添加/编辑 文章
     */
    @RequestMapping(value = "/addOrUpdate", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> addOrUpdateArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            ArticleModel model, Byte[] channels) throws Exception {

        Map<String, Object> map = new HashMap<>();
        boolean i;
        model.setPublishTime(sdf.parse(RequestParamHelper.getString(httpRequest, "publishTimeString")));

        UserModel user = AuthHelper.getLoginUserModel(httpRequest);
        if (httpRequest.getParameter("isUpdate") == null) {
            model.setUserId(user.getUserId());
            i = iArticle.addArticle(model, channels);
        } else {
            i = iArticle.updateArticle(model, channels, true, user.getUserId());
        }
        map.put("success", i);

        return map;
    }


    /**
     * 删除 文章
     */
    @RequestMapping("/del")
    public
    @ResponseBody
    Map<String, Object> delArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            Integer articleId) throws Exception {

        boolean i = false;
        Map<String, Object> map = new HashMap<>();
        if(IntegerExtention.hasValueAndMaxZero(articleId)) {
            i = iArticle
                    .delArticle(articleId, AuthHelper.getLoginUserModel(httpRequest).getUserId());
        }
        map.put("success", i);

        return map;
    }


    /**
     * 修改文章封面
     */
    @RequestMapping("/changeCoverImg")
    public
    @ResponseBody
    Map<String, Object> changeCoverImg(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            Integer articleId, String coverImg) throws Exception {

        Map<String, Object> map = new HashMap<>();

        ArticleModel articleModel = new ArticleModel();
        articleModel.setArticleId(articleId);
        articleModel.setCoverUrl(coverImg);
        boolean i = iArticle.updateArticle(articleModel, null, false, AuthHelper.getLoginUserModel(httpRequest).getUserId());

        map.put("success", i);

        return map;
    }


    /**
     * 修改文章状态
     */
    @RequestMapping("/changeStatus")
    public
    @ResponseBody
    Map<String, Object> changeStatus(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            Integer articleId, Byte status) throws Exception {

        Map<String, Object> map = new HashMap<>();

        ArticleModel articleModel = new ArticleModel();
        articleModel.setArticleId(articleId);
        articleModel.setStatus(status);
        boolean i = iArticle.updateArticle(articleModel, null, false, AuthHelper.getLoginUserModel(httpRequest).getUserId());

        map.put("success", i);

        return map;
    }


}
