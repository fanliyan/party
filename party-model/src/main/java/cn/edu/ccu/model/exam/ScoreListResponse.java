package cn.edu.ccu.model.exam;

import cn.edu.ccu.model.SplitPageResponse;

import java.util.List;

/**
 * Created by kuangye on 2016/5/5.
 */
public class ScoreListResponse {

    private List<ScoreModel> scoreModelList;

    private SplitPageResponse splitPageResponse;

    public List<ScoreModel> getScoreModelList() {
        return scoreModelList;
    }

    public void setScoreModelList(List<ScoreModel> scoreModelList) {
        this.scoreModelList = scoreModelList;
    }

    public SplitPageResponse getSplitPageResponse() {
        return splitPageResponse;
    }

    public void setSplitPageResponse(SplitPageResponse splitPageResponse) {
        this.splitPageResponse = splitPageResponse;
    }
}
