package cn.edu.ccu.model.article;

import cn.edu.ccu.model.SplitPageResponse;

import java.util.List;

/**
 * Created by kuangye on 2016/4/13.
 */
public class ArticleListResponse {

    protected SplitPageResponse splitPage;
    protected List<ArticleModel> articleModelList;


    public SplitPageResponse getSplitPage() {
        return splitPage;
    }

    public void setSplitPage(SplitPageResponse splitPage) {
        this.splitPage = splitPage;
    }

    public List<ArticleModel> getArticleModelList() {
        return articleModelList;
    }

    public void setArticleModelList(List<ArticleModel> articleModelList) {
        this.articleModelList = articleModelList;
    }
}
