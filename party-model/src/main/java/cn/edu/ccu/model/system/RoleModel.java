package cn.edu.ccu.model.system;

import java.util.Date;
import java.util.List;

public class RoleModel {
    private Integer roleId;

    private String name;

    private Date createTime;

    private Date lastModifyTime;

    private List<ModuleModel> moduleModelList;

    private List<ModuleGroupModel> moduleGroupModelList;

    private boolean isBuiltin;

    public boolean getIsBuiltin() {
        return isBuiltin;
    }

    public void setIsBuiltin(boolean builtin) {
        isBuiltin = builtin;
    }

    public List<ModuleModel> getModuleModelList() {
        return moduleModelList;
    }

    public void setModuleModelList(List<ModuleModel> moduleModelList) {
        this.moduleModelList = moduleModelList;
    }

    public List<ModuleGroupModel> getModuleGroupModelList() {
        return moduleGroupModelList;
    }

    public void setModuleGroupModelList(List<ModuleGroupModel> moduleGroupModelList) {
        this.moduleGroupModelList = moduleGroupModelList;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
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