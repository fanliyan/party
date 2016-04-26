package cn.edu.ccu.model.exam;

import cn.edu.ccu.model.SplitPageRequest;

/**
 * Created by kuangye on 2016/4/25.
 */
public class ExamListRequest {

    private boolean withUser;

    private ExamModel examModel;

    private SplitPageRequest splitPageRequest;


    public boolean isWithUser() {
        return withUser;
    }

    public void setWithUser(boolean withUser) {
        this.withUser = withUser;
    }

    public ExamModel getExamModel() {
        return examModel;
    }

    public void setExamModel(ExamModel examModel) {
        this.examModel = examModel;
    }

    public SplitPageRequest getSplitPageRequest() {
        return splitPageRequest;
    }

    public void setSplitPageRequest(SplitPageRequest splitPageRequest) {
        this.splitPageRequest = splitPageRequest;
    }
}
