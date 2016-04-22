package cn.edu.ccu.model.article;

import cn.edu.ccu.model.user.UserModel;

import java.util.Date;
import java.util.List;

public class ArticleModel {
    private Integer articleId;

    private String title;

    private String summary;

    private String coverUrl;

    private Integer userId;

    private Integer countclick;

    private Byte status;

    private Date createTime;

    private Date lastModifyTime;

    private Date publishTime;

    private Integer channelCount;

    private String titleIndex;

    private String content;


    private UserModel userModel;

    private List<ArticleChannelModel> articleChannelModelList;

    public UserModel getUserModel() {
        return userModel;
    }

    public void setUserModel(UserModel userModel) {
        this.userModel = userModel;
    }

    public List<ArticleChannelModel> getArticleChannelModelList() {
        return articleChannelModelList;
    }

    public void setArticleChannelModelList(List<ArticleChannelModel> articleChannelModelList) {
        this.articleChannelModelList = articleChannelModelList;
    }

    public Integer getArticleId() {
        return articleId;
    }

    public void setArticleId(Integer articleId) {
        this.articleId = articleId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary == null ? null : summary.trim();
    }

    public String getCoverUrl() {
        return coverUrl;
    }

    public void setCoverUrl(String coverUrl) {
        this.coverUrl = coverUrl == null ? null : coverUrl.trim();
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getCountclick() {
        return countclick;
    }

    public void setCountclick(Integer countclick) {
        this.countclick = countclick;
    }

    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getLastModifyTime() {
        return lastModifyTime;
    }

    public void setLastModifyTime(Date lastModifyTime) {
        this.lastModifyTime = lastModifyTime;
    }

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    public Integer getChannelCount() {
        return channelCount;
    }

    public void setChannelCount(Integer channelCount) {
        this.channelCount = channelCount;
    }

    public String getTitleIndex() {
        return titleIndex;
    }

    public void setTitleIndex(String titleIndex) {
        this.titleIndex = titleIndex == null ? null : titleIndex.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }
}