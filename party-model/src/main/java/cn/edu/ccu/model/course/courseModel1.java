package cn.edu.ccu.model.course;

import java.util.Date;

/**
 * Created by Fanliyan on 2016/11/3.
 */
public class CourseModel1 {
    private Integer course_id;
    private String course_name;
    private String description;
    private String teacher;
    private double score;
    private String time;
    private boolean choose;

    public boolean isChoose() {
        return choose;
    }

    public void setChoose(boolean choose) {
        this.choose = choose;
    }

    private CourseTypeModel courseTypeModel;

    public CourseTypeModel getCourseTypeModel() {
        return courseTypeModel;
    }

    public void setCourseTypeModel(CourseTypeModel courseTypeModel) {
        this.courseTypeModel = courseTypeModel;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    private Integer course_type;
    private Date create_time;
    private Date last_modify_time;

    public Integer getCourse_id() {
        return course_id;
    }

    public void setCourse_id(Integer course_id) {
        this.course_id = course_id;
    }

    public String getCourse_name() {
        return course_name;
    }

    public void setCourse_name(String course_name) {
        this.course_name = course_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTeacher() {
        return teacher;
    }

    public void setTeacher(String teacher) {
        this.teacher = teacher;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public Integer getCourse_type() {
        return course_type;
    }

    public void setCourse_type(Integer course_type) {
        this.course_type = course_type;
    }

    public Date getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Date create_time) {
        this.create_time = create_time;
    }

    public Date getLast_modify_time() {
        return last_modify_time;
    }

    public void setLast_modify_time(Date last_modify_time) {
        this.last_modify_time = last_modify_time;
    }
}
