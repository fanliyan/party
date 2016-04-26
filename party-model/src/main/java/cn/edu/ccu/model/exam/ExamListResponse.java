package cn.edu.ccu.model.exam;

import cn.edu.ccu.model.SplitPageResponse;

import java.util.List;

/**
 * Created by kuangye on 2016/4/25.
 */
public class ExamListResponse {

    private List<ExamModel> examModelList;

    private SplitPageResponse splitPageResponse;


    public List<ExamModel> getExamModelList() {
        return examModelList;
    }

    public void setExamModelList(List<ExamModel> examModelList) {
        this.examModelList = examModelList;
    }

    public SplitPageResponse getSplitPageResponse() {
        return splitPageResponse;
    }

    public void setSplitPageResponse(SplitPageResponse splitPageResponse) {
        this.splitPageResponse = splitPageResponse;
    }
}
