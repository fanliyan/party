//
// 此文件是由 JavaTM Architecture for XML Binding (JAXB) 引用实现 v2.2.8-b130911.1802 生成的
// 请访问 <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// 在重新编译源模式时, 对此文件的所有修改都将丢失。
// 生成时间: 2015.10.09 时间 02:59:10 PM CST 
//


package cn.edu.ccu.model.article;


import cn.edu.ccu.model.SplitPageResponse;

import java.util.List;


public class ArticleModifyLogListResponse {

    protected List<ArticleModifyLogModel> articleModifyLogList;
    protected SplitPageResponse splitPage;

    public List<ArticleModifyLogModel> getArticleModifyLogList() {
        return articleModifyLogList;
    }

    public void setArticleModifyLogList(List<ArticleModifyLogModel> articleModifyLogList) {
        this.articleModifyLogList = articleModifyLogList;
    }

    public SplitPageResponse getSplitPage() {
        return splitPage;
    }

    public void setSplitPage(SplitPageResponse splitPage) {
        this.splitPage = splitPage;
    }
}
