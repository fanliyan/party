package cn.edu.ccu.model.exam;

import java.util.List;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/27.
 */
public class ExamResultModel {

    private Double totalScore;

    private Double singleChoiceScore;
    private Double multipleChoiceScore;
    private Double tofScore;

    //题号 和 你的 答案list
    private Map<String,List<String>> detail;


    public Double getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(Double totalScore) {
        this.totalScore = totalScore;
    }

    public Double getSingleChoiceScore() {
        return singleChoiceScore;
    }

    public void setSingleChoiceScore(Double singleChoiceScore) {
        this.singleChoiceScore = singleChoiceScore;
    }

    public Double getMultipleChoiceScore() {
        return multipleChoiceScore;
    }

    public void setMultipleChoiceScore(Double multipleChoiceScore) {
        this.multipleChoiceScore = multipleChoiceScore;
    }

    public Double getTofScore() {
        return tofScore;
    }

    public void setTofScore(Double tofScore) {
        this.tofScore = tofScore;
    }

    public Map<String, List<String>> getDetail() {
        return detail;
    }

    public void setDetail(Map<String, List<String>> detail) {
        this.detail = detail;
    }
}
