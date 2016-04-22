package cn.edu.ccu.model.student;

import java.util.Date;

public class RStudentRoleModel extends RStudentRoleModelKey {
    private Date createTime;

    private Date lastModifyTime;

    private Integer id;

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

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}