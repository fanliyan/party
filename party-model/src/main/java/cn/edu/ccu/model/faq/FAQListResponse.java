package cn.edu.ccu.model.faq;

import cn.edu.ccu.model.SplitPageResponse;

import java.util.List;

/**
 * Created by Administrator on 2016/4/23.
 */
public class FAQListResponse {

    private List<FAQModel> faqModelList;

    private SplitPageResponse splitPageResponse;

    public SplitPageResponse getSplitPageResponse() {
        return splitPageResponse;
    }

    public void setSplitPageResponse(SplitPageResponse splitPageResponse) {
        this.splitPageResponse = splitPageResponse;
    }

    public List<FAQModel> getFaqModelList() {
        return faqModelList;
    }

    public void setFaqModelList(List<FAQModel> faqModelList) {
        this.faqModelList = faqModelList;
    }
}
