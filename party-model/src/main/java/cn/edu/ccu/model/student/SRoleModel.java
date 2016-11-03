package cn.edu.ccu.model.student;

import cn.edu.ccu.model.course.CourseModel;

import java.util.Date;
import java.util.List;

public class SRoleModel {
    private Integer roleId;

    private String name;

    private Date createTime;

    private Date lastModifyTime;

    private List<CourseModel> courseList;

    public List<CourseModel> getCourseList() {
        return courseList;
    }

    public void setCourseList(List<CourseModel> courseList) {
        this.courseList = courseList;
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