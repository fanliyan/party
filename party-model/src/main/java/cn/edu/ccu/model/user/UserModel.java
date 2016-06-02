package cn.edu.ccu.model.user;

import cn.edu.ccu.model.common.BranchModel;
import cn.edu.ccu.model.common.DepartmentModel;
import cn.edu.ccu.model.system.ModuleModel;
import cn.edu.ccu.model.system.RoleModel;

import java.util.Date;
import java.util.List;

public class UserModel {
    private Integer userId;

    private String account;

    private String password;

    private String name;

    private String gender;

    private String birthday;

    private String lastLoginIp;

    private Date lastLoginTime;

    private Integer loginCount;

    private Integer loginFailCount;

    private Byte status;

    private Date createTime;

    private Date lastModifyTime;

    private Integer branchId;

    private Byte departmentType;


    private Integer departmentId;

    public Integer getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Integer departmentId) {
        this.departmentId = departmentId;
    }

    /**
     * 用户所包含的模块
     */
    private List<ModuleModel> hasModules;

    /**
     * 用户所包含的角色
     */
    private List<RoleModel> hasRoles;


    private BranchModel branchModel;


    private DepartmentModel departmentModel;

    public DepartmentModel getDepartmentModel() {
        return departmentModel;
    }

    public void setDepartmentModel(DepartmentModel departmentModel) {
        this.departmentModel = departmentModel;
    }

    public BranchModel getBranchModel() {
        return branchModel;
    }

    public void setBranchModel(BranchModel branchModel) {
        this.branchModel = branchModel;
    }

    public List<ModuleModel> getHasModules() {
        return hasModules;
    }

    public void setHasModules(List<ModuleModel> hasModules) {
        this.hasModules = hasModules;
    }

    public List<RoleModel> getHasRoles() {
        return hasRoles;
    }

    public void setHasRoles(List<RoleModel> hasRoles) {
        this.hasRoles = hasRoles;
    }



    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account == null ? null : account.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday == null ? null : birthday.trim();
    }

    public String getLastLoginIp() {
        return lastLoginIp;
    }

    public void setLastLoginIp(String lastLoginIp) {
        this.lastLoginIp = lastLoginIp == null ? null : lastLoginIp.trim();
    }

    public Date getLastLoginTime() {
        return lastLoginTime;
    }

    public void setLastLoginTime(Date lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }

    public Integer getLoginCount() {
        return loginCount;
    }

    public void setLoginCount(Integer loginCount) {
        this.loginCount = loginCount;
    }

    public Integer getLoginFailCount() {
        return loginFailCount;
    }

    public void setLoginFailCount(Integer loginFailCount) {
        this.loginFailCount = loginFailCount;
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

    public Integer getBranchId() {
        return branchId;
    }

    public void setBranchId(Integer branchId) {
        this.branchId = branchId;
    }

    public Byte getDepartmentType() {
        return departmentType;
    }

    public void setDepartmentType(Byte departmentType) {
        this.departmentType = departmentType;
    }
}