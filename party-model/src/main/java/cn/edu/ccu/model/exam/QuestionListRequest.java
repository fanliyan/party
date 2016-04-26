package cn.edu.ccu.model.exam;

import cn.edu.ccu.model.SplitPageRequest;

/**
 * Created by kuangye on 2016/4/23.
 */
public class QuestionListRequest {

    private boolean withUserRole;

    private QuestionModel questionModel;

    private SplitPageRequest splitPageRequest;

    public boolean isWithUserRole() {
        return withUserRole;
    }

    public void setWithUserRole(boolean withUserRole) {
        this.withUserRole = withUserRole;
    }

    public QuestionModel getQuestionModel() {
        return questionModel;
    }

    public void setQuestionModel(QuestionModel questionModel) {
        this.questionModel = questionModel;
    }

    public SplitPageRequest getSplitPageRequest() {
        return splitPageRequest;
    }

    public void setSplitPageRequest(SplitPageRequest splitPageRequest) {
        this.splitPageRequest = splitPageRequest;
    }
}
