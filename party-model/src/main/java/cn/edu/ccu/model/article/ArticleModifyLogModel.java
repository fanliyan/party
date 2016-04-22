package cn.edu.ccu.model.article;

import cn.edu.ccu.model.user.UserModel;

import java.util.Date;

public class ArticleModifyLogModel {
    private Integer id;

    private Integer articleId;

    private Integer userId;

    private Byte modifyType;

    private String description;

    private Date createTime;

    private String modifyBeforeData;



    private UserModel userModel;

    public UserModel getUserModel() {
        return userModel;
    }

    public void setUserModel(UserModel userModel) {
        this.userModel = userModel;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getArticleId() {
        return articleId;
    }

    public void setArticleId(Integer articleId) {
        this.articleId = articleId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Byte getModifyType() {
        return modifyType;
    }

    public void setModifyType(Byte modifyType) {
        this.modifyType = modifyType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getModifyBeforeData() {
        return modifyBeforeData;
    }

    public void setModifyBeforeData(String modifyBeforeData) {
        this.modifyBeforeData = modifyBeforeData == null ? null : modifyBeforeData.trim();
    }
}