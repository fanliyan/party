package cn.edu.ccu.model.article;

import cn.edu.ccu.model.SplitPageRequest;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlSchemaType;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2016/4/13.
 */
public class ArticleListRequest {

    protected SplitPageRequest splitPage;
    protected Integer orderBy;
    protected Integer userId;
    protected Boolean isReturnUserData;
    protected Integer channelIdCount;
    protected String title;
    @XmlSchemaType(name = "date")
    protected Date startTime;
    @XmlSchemaType(name = "date")
    protected Date endTime;
    protected Byte status;

    public SplitPageRequest getSplitPage() {
        return splitPage;
    }

    public void setSplitPage(SplitPageRequest splitPage) {
        this.splitPage = splitPage;
    }

    public Integer getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(Integer orderBy) {
        this.orderBy = orderBy;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Boolean getIsReturnUserData() {
        return isReturnUserData;
    }

    public void setIsReturnUserData(Boolean returnUserData) {
        isReturnUserData = returnUserData;
    }

    public Integer getChannelIdCount() {
        return channelIdCount;
    }

    public void setChannelIdCount(Integer channelIdCount) {
        this.channelIdCount = channelIdCount;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }
}
