package cn.edu.ccu.model.faq;

import cn.edu.ccu.model.SplitPageRequest;

/**
 * Created by kuangye on 2016/4/23.
 */
public class FAQListRequest {

//是否显示问 和 答 用户

    private boolean withUser;

    private FAQModel faqModel;

    private SplitPageRequest splitPageRequest;

    public FAQModel getFaqModel() {
        return faqModel;
    }

    public void setFaqModel(FAQModel faqModel) {
        this.faqModel = faqModel;
    }

    public SplitPageRequest getSplitPageRequest() {
        return splitPageRequest;
    }

    public void setSplitPageRequest(SplitPageRequest splitPageRequest) {
        this.splitPageRequest = splitPageRequest;
    }

    public boolean isWithUser() {
        return withUser;
    }

    public void setWithUser(boolean withUser) {
        this.withUser = withUser;
    }
}
