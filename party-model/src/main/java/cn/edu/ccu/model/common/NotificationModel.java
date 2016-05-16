package cn.edu.ccu.model.common;

import cn.edu.ccu.model.student.SRoleModel;

import java.util.Date;

public class NotificationModel {
    private Integer id;

    private Integer roleId;

    private Date createTime;

    private Date lastModifyTime;

    private String content;


    private SRoleModel sRoleModel;

    public SRoleModel getsRoleModel() {
        return sRoleModel;
    }

    public void setsRoleModel(SRoleModel sRoleModel) {
        this.sRoleModel = sRoleModel;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }
}