package cn.edu.ccu.manage.controller.article;

import cn.edu.ccu.ibusiness.article.IArticleChannel;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.article.ArticleChannelModel;
import cn.edu.ccu.model.common.NestableModel;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.extention.StringExtention;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/14.
 */
@Controller
@RequestMapping("/articlechannel")
@AuthController(moduleId = -1)
public class ArticleChannelController extends BaseController {

    @Autowired
    private IArticleChannel iArticleChannel;

    /**
     * channel 列表
     */
    @RequestMapping("/list")
    public ModelAndView list(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            SplitPageRequest pageRequest) throws Exception {

        ModelAndView mav = Common.getLoginModelAndView(httpRequest);
        //所有
        List<ArticleChannelModel> articleChannelModelList = iArticleChannel.select();
        //根节点
        List<ArticleChannelModel> rootList = iArticleChannel.selectByFatherId(0);

        //获取nestable
        String html = getNestableListHtml(rootList, articleChannelModelList);

        mav.addObject("channelList", articleChannelModelList);
        mav.addObject("nestable", html);

        mav.setViewName("articlechannel/channelList");
        return mav;
    }


    /**
     * 添加 TAG
     */
    @RequestMapping("/add")
    public ModelAndView addArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        mav.addObject("channelList", iArticleChannel.select());

        mav.setViewName("articlechannel/channelEdit");
        return mav;
    }

    /**
     * 编辑 TAG
     */
    @RequestMapping("/edit")
    public ModelAndView editArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            @RequestParam("id") Integer id) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);


        mav.addObject("channel", iArticleChannel.selectById(id));
        mav.addObject("channelList", iArticleChannel.select());

        mav.setViewName("articlechannel/channelEdit");
        return mav;
    }

    /**
     * 动态编辑编辑 channel
     */
    @RequestMapping("/dynamicChange")
    public
    @ResponseBody
    Map<String, Object>
    moveChange(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            @RequestParam("data") String data) throws Exception {

        //防xss 转换回来
        data= StringEscapeUtils.unescapeHtml4(data);

        Map<String, Object> map = new HashMap<>();

        boolean tag = false;

        if (!StringExtention.isTrimNullOrEmpty(data)) {
            ObjectMapper objectMapper = new ObjectMapper();

            try {
                List<NestableModel> nestableModelList = objectMapper.readValue(data, new TypeReference<List<NestableModel>>() {
                });

                tag = iArticleChannel.updateFromNestable(nestableModelList);
            } catch (Exception e) {
                throw new BusinessException(ErrorCodeEnum.requestParamError);
            }
        }

        map.put("success", tag);

        return map;
    }

    /**
     * 保存 添加/编辑 TAG
     */
    @RequestMapping("/addOrUpdate")
    public
    @ResponseBody
    Map<String, Object> addOrUpdateArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            ArticleChannelModel model) throws Exception {

        Map<String, Object> map = new HashMap<>();
        int i;

        if (httpRequest.getParameter("isUpdate") == null) {
            i = iArticleChannel.addArticleChannel(model);
        } else {
            i = iArticleChannel.editArticleChannel(model);
        }
        map.put("success", i > 0);

        return map;
    }


    /**
     * 删除 TAG
     */
    @RequestMapping("/del")
    public
    @ResponseBody
    Map<String, Object> del(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            Integer id) throws Exception {

        Map<String, Object> map = new HashMap<>();

        int i = iArticleChannel.deleteArticleChannel(id);

        map.put("success", i > 0);

        return map;
    }

    //生成 nestable html
    private String getNestableListHtml(List<ArticleChannelModel> rootList, List<ArticleChannelModel> list) {

        String html = "";
        //root list
        if (rootList != null && rootList.size() > 0) {

            html += "<ol class=\"dd-list\">";
            html += (this.getChildHtml(rootList, list, true));
            html += "</ol>";
        }

        return html;
    }

    //装配子节点html  iterator
    private String getChildHtml(List<ArticleChannelModel> childList, List<ArticleChannelModel> list, boolean isRoot) {


        StringBuffer html = new StringBuffer();

        if (!isRoot) {
            html.append("<ol class=\"dd-list\">");
        }

        //获取子节点列表
        if (childList != null && childList.size() > 0) {
            //生成一个节点
            for (ArticleChannelModel articleChannelModel : childList) {

                html.append("<li class=\"dd-item\" data-id=\"" + articleChannelModel.getChannelId() + "\">");
                html.append("<div class=\"dd-handle\">" + articleChannelModel.getName() );
//                html.append("<button class=\"btn btn-xs btn-danger pull-right\" onclick=\"$.del(" + articleChannelModel.getChannelId() + ");\">删除</button>");
//                html.append("<button class=\"btn btn-xs btn-warning pull-right\" onclick=\"$.change(" + articleChannelModel.getChannelId() + ");\">修改</button>");
                html.append("</div>");

                //获取子节点list
                List<ArticleChannelModel> childs = this.getChildList(articleChannelModel.getChannelId(), list);

                if (childs != null) {
                    //查询是否有子节点
                    html.append(getChildHtml(childs, list, false));
                }

                html.append("</li>");

            }
        }

        if (!isRoot) {
            html.append("</ol>");
        }

        if (childList != null && childList.size() > 0) {
            return html.toString();
        } else {
            return "暂无数据";
        }
    }


    //获取子节点list
    private List<ArticleChannelModel> getChildList(Integer id, List<ArticleChannelModel> list) {

        List<ArticleChannelModel> childList = new ArrayList<>();

        for (ArticleChannelModel articleChannelModel : list)
            if (articleChannelModel.getParentId().equals(id))
                childList.add(articleChannelModel);

        if (childList.size() > 0)
            return childList;

        return null;
    }


}
