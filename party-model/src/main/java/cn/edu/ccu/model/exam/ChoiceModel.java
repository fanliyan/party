package cn.edu.ccu.model.exam;

import java.util.List;

/**
 * Created by kuangye on 2016/4/23.
 */
public class ChoiceModel extends QuestionModel {

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


    public ChoiceModel(QuestionModel questionModel) {
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
}
