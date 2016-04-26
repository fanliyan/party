package cn.edu.ccu.model.exam;

import cn.edu.ccu.model.SplitPageResponse;

import java.util.List;

/**
 * Created by kuangye on 2016/4/23.
 */
public class QuestionListResponse {

    private List<QuestionModel> questionModelList;

    private SplitPageResponse splitPageResponse;


    public List<QuestionModel> getQuestionModelList() {
        return questionModelList;
    }

    public void setQuestionModelList(List<QuestionModel> questionModelList) {
        this.questionModelList = questionModelList;
    }

    public SplitPageResponse getSplitPageResponse() {
        return splitPageResponse;
    }

    public void setSplitPageResponse(SplitPageResponse splitPageResponse) {
        this.splitPageResponse = splitPageResponse;
    }
}
