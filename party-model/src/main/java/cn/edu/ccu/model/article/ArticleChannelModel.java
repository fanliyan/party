package cn.edu.ccu.model.article;

import java.util.Date;
import java.util.List;

public class ArticleChannelModel {
    private Integer channelId;

    private String name;

    private Integer parentId;

    private Integer weight;

    private Date createTime;

    private Date lastModifyTime;


    List<ArticleChannelModel> childList;

    public List<ArticleChannelModel> getChildList() {
        return childList;
    }

    public void setChildList(List<ArticleChannelModel> childList) {
        this.childList = childList;
    }

    public Integer getChannelId() {
        return channelId;
    }

    public void setChannelId(Integer channelId) {
        this.channelId = channelId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public Integer getWeight() {
        return weight;
    }

    public void setWeight(Integer weight) {
        this.weight = weight;
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
}