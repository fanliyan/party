package cn.edu.ccu.model.course;

import java.util.Date;
import java.util.List;

public class CourseModel {
    private Integer courseId;

    private String courseName;

    private String description;

    private String teacher;

    private String teacherDescription;

    private Double score;

    private String time;

    private Integer courseType;

    private Date createTime;

    private Date lastModifyTime;

    private CourseTypeModel courseTypeModel;

    private List<CourseWareModel> courseWareModelList;


    //========================================================================

    private boolean isChoose;

    public boolean getIsChoose() {
        return isChoose;
    }

    public void setIsChoose(boolean choose) {
        isChoose = choose;
    }

    //========================================================================

    public List<CourseWareModel> getCourseWareModelList() {
        return courseWareModelList;
    }

    public void setCourseWareModelList(List<CourseWareModel> courseWareModelList) {
        this.courseWareModelList = courseWareModelList;
    }

    public CourseTypeModel getCourseTypeModel() {
        return courseTypeModel;
    }

    public void setCourseTypeModel(CourseTypeModel courseTypeModel) {
        this.courseTypeModel = courseTypeModel;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName == null ? null : courseName.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public String getTeacher() {
        return teacher;
    }

    public void setTeacher(String teacher) {
        this.teacher = teacher == null ? null : teacher.trim();
    }

    public String getTeacherDescription() {
        return teacherDescription;
    }

    public void setTeacherDescription(String teacherDescription) {
        this.teacherDescription = teacherDescription;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public Integer getCourseType() {
        return courseType;
    }

    public void setCourseType(Integer courseType) {
        this.courseType = courseType;
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