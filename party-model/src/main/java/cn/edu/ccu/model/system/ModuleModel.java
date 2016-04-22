package cn.edu.ccu.model.system;

import java.util.Date;

public class ModuleModel {
    private Integer moduleId;

    private String name;

    private String description;

    private String entryUrl;

    private Integer modulegroupId;

    private Date createTime;

    private Date lastModifyTime;

    public Integer getModuleId() {
        return moduleId;
    }

    public void setModuleId(Integer moduleId) {
        this.moduleId = moduleId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public String getEntryUrl() {
        return entryUrl;
    }

    public void setEntryUrl(String entryUrl) {
        this.entryUrl = entryUrl == null ? null : entryUrl.trim();
    }

    public Integer getModulegroupId() {
        return modulegroupId;
    }

    public void setModulegroupId(Integer modulegroupId) {
        this.modulegroupId = modulegroupId;
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