package cn.edu.ccu.model.system;

import java.util.Date;
import java.util.List;

public class ModuleGroupModel {
    private Integer id;

    private String groupName;

    private Integer weight;

    private String icon;

    private Date createTime;

    private Date lastModifyTime;

    private List<ModuleModel> moduleModelList;

    public List<ModuleModel> getModuleModelList() {
        return moduleModelList;
    }

    public void setModuleModelList(List<ModuleModel> moduleModelList) {
        this.moduleModelList = moduleModelList;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public Integer getWeight() {
        return weight;
    }

    public void setWeight(Integer weight) {
        this.weight = weight;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon == null ? null : icon.trim();
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