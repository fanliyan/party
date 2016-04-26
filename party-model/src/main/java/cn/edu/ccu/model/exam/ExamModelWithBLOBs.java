package cn.edu.ccu.model.exam;

import java.util.List;

public class ExamModelWithBLOBs extends ExamModel {
    private String singleChoice;

    private String multipleChoice;

    private String tof;

    //==========================================

    private List<QuestionModel> singleChoiceList;

    private List<QuestionModel> multipleChoiceList;

    private List<QuestionModel> tofList;

    public List<QuestionModel> getSingleChoiceList() {
        return singleChoiceList;
    }

    public void setSingleChoiceList(List<QuestionModel> singleChoiceList) {
        this.singleChoiceList = singleChoiceList;
    }

    public List<QuestionModel> getMultipleChoiceList() {
        return multipleChoiceList;
    }

    public void setMultipleChoiceList(List<QuestionModel> multipleChoiceList) {
        this.multipleChoiceList = multipleChoiceList;
    }

    public List<QuestionModel> getTofList() {
        return tofList;
    }

    public void setTofList(List<QuestionModel> tofList) {
        this.tofList = tofList;
    }


    //==========================================

    public String getSingleChoice() {
        return singleChoice;
    }

    public void setSingleChoice(String singleChoice) {
        this.singleChoice = singleChoice == null ? null : singleChoice.trim();
    }

    public String getMultipleChoice() {
        return multipleChoice;
    }

    public void setMultipleChoice(String multipleChoice) {
        this.multipleChoice = multipleChoice == null ? null : multipleChoice.trim();
    }

    public String getTof() {
        return tof;
    }

    public void setTof(String tof) {
        this.tof = tof == null ? null : tof.trim();
    }
}