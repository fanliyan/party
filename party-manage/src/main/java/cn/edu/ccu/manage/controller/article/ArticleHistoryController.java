package cn.edu.ccu.manage.controller.article;

import cn.edu.ccu.ibusiness.article.IArticleModifyLog;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.article.ArticleModifyLogListResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/articleHistory")
@AuthController(moduleId = -1)
public class ArticleHistoryController extends BaseController {

	@Autowired
	private IArticleModifyLog iArticleModifyLog;

	/**
     *文章日志列表
     */
	@RequestMapping("/list")
	public ModelAndView listArticleCategoriesType(
            HttpServletRequest httpRequest, HttpServletResponse httpResponse,
            Integer articleId, SplitPageRequest pageRequest) throws Exception {
		ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        pageRequest.setReturnCount(true);

        ArticleModifyLogListResponse response = iArticleModifyLog
				.articleModifyLogList(articleId,pageRequest);

        mav.addObject("articleId",articleId);
		mav.addObject("response", response);

		mav.setViewName("article/articleHistoryList");
		return mav;
	}

    /**
     * 预览历史
     */
	@RequestMapping("/preview")
	public ModelAndView delArticleCategoriesType(
			HttpServletRequest httpRequest, HttpServletResponse httpResponse,
			Integer articleLogId) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);

        mav.addObject("article",iArticleModifyLog
                .articleHistoryPreview(articleLogId));

        mav.setViewName("article/previewArticle");

		return mav;
	}

}
