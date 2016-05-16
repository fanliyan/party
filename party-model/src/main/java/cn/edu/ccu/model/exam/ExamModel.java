package cn.edu.ccu.model.exam;

import cn.edu.ccu.model.student.SRoleModel;
import cn.edu.ccu.model.user.UserModel;

import java.util.Date;

public class ExamModel {
    private Integer id;

    private String name;

    private String description;

    private Byte type;

    private Integer time;

    private Date startTime;

    private Date endTime;

    private Integer createUser;

    private Integer roleId;

    private Double score;

    private Byte status;

    private Date createTime;

    private Date lastModifyTime;

    private UserModel userModel;

    private SRoleModel sRoleModel;


    //==============================================


    private Integer singleChoiceCount;

    private Integer multipleChoiceCount;

    private Integer tofCount;

    public Integer getSingleChoiceCount() {
        return singleChoiceCount;
    }

    public void setSingleChoiceCount(Integer singleChoiceCount) {
        this.singleChoiceCount = singleChoiceCount;
    }

    public Integer getMultipleChoiceCount() {
        return multipleChoiceCount;
    }

    public void setMultipleChoiceCount(Integer multipleChoiceCount) {
        this.multipleChoiceCount = multipleChoiceCount;
    }

    public Integer getTofCount() {
        return tofCount;
    }

    public void setTofCount(Integer tofCount) {
        this.tofCount = tofCount;
    }

    //==============================================


    public UserModel getUserModel() {
        return userModel;
    }

    public void setUserModel(UserModel userModel) {
        this.userModel = userModel;
    }

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

    public Byte getType() {
        return type;
    }

    public void setType(Byte type) {
        this.type = type;
    }

    public Integer getTime() {
        return time;
    }

    public void setTime(Integer time) {
        this.time = time;
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

    public Integer getCreateUser() {
        return createUser;
    }

    public void setCreateUser(Integer createUser) {
        this.createUser = createUser;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
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
}