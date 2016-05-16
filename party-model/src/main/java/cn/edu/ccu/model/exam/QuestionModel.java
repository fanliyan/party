package cn.edu.ccu.model.exam;

import cn.edu.ccu.model.student.SRoleModel;
import cn.edu.ccu.model.user.UserModel;

import java.util.Date;
import java.util.List;

public class QuestionModel {
    private Integer id;

    private String name;

    private String question;

    private Integer type;

    private String rightAnswer;

    private Byte status;

    private Date createTime;

    private Date lastModifyTime;

    private Integer createUser;

    private Integer roleId;

    private Integer weight;

    private String answers;

    private Double score;


    private UserModel userModel;

    private SRoleModel sRoleModel;


    //=============================================================================

    private List<Choice> choiceModelList;

    private List<String> rightAnswerList;

    public List<String> getRightAnswerList() {
        return rightAnswerList;
    }

    public void setRightAnswerList(List<String> rightAnswerList) {
        this.rightAnswerList = rightAnswerList;
    }

    public List<Choice> getChoiceModelList() {
        return choiceModelList;
    }

    public void setChoiceModelList(List<Choice> choiceModelList) {
        this.choiceModelList = choiceModelList;
    }

    public QuestionModel(QuestionModel questionModel){
        this.setId(questionModel.getId());
        this.setName(questionModel.getName());
        this.setQuestion(questionModel.getQuestion());
        this.setType(questionModel.getType());
        this.setStatus(questionModel.getStatus());
        this.setCreateTime(questionModel.getCreateTime());
        this.setLastModifyTime(questionModel.getLastModifyTime());
        this.setCreateUser(questionModel.getCreateUser());
        this.setRoleId(questionModel.getRoleId());
        this.setWeight(questionModel.getWeight());
        this.setScore(questionModel.getScore());
        this.setUserModel(questionModel.getUserModel());
        this.setsRoleModel(questionModel.getsRoleModel());
    }
    public QuestionModel(){
    }

    //=============================================================================



    public SRoleModel getsRoleModel() {
        return sRoleModel;
    }

    public void setsRoleModel(SRoleModel sRoleModel) {
        this.sRoleModel = sRoleModel;
    }

    public UserModel getUserModel() {
        return userModel;
    }

    public void setUserModel(UserModel userModel) {
        this.userModel = userModel;
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

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getRightAnswer() {
        return rightAnswer;
    }

    public void setRightAnswer(String rightAnswer) {
        this.rightAnswer = rightAnswer == null ? null : rightAnswer.trim();
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

    public Integer getWeight() {
        return weight;
    }

    public void setWeight(Integer weight) {
        this.weight = weight;
    }

    public String getAnswers() {
        return answers;
    }

    public void setAnswers(String answers) {
        this.answers = answers == null ? null : answers.trim();
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }
}