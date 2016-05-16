package cn.edu.ccu.model.word;

import cn.edu.ccu.model.SplitPageResponse;
import cn.edu.ccu.model.common.SensitiveWordsModel;

import java.util.List;

/**
 * Created by kuangye on 2016/4/29.
 */
public class SensitiveWordListResponse {

    private List<SensitiveWordsModel> sensitiveWordsModelList;

    private SplitPageResponse splitPageResponse;

    public List<SensitiveWordsModel> getSensitiveWordsModelList() {
        return sensitiveWordsModelList;
    }

    public void setSensitiveWordsModelList(List<SensitiveWordsModel> sensitiveWordsModelList) {
        this.sensitiveWordsModelList = sensitiveWordsModelList;
    }

    public SplitPageResponse getSplitPageResponse() {
        return splitPageResponse;
    }

    public void setSplitPageResponse(SplitPageResponse splitPageResponse) {
        this.splitPageResponse = splitPageResponse;
    }
}
