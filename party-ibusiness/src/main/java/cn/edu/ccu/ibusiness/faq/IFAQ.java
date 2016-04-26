package cn.edu.ccu.ibusiness.faq;

import cn.edu.ccu.model.faq.FAQListRequest;
import cn.edu.ccu.model.faq.FAQListResponse;
import cn.edu.ccu.model.faq.FAQModel;

/**
 * Created by kuangye on 2016/4/23.
 */
public interface IFAQ {

    FAQModel selectById(Integer id);

    FAQListResponse select(FAQListRequest faqListRequest);

    boolean askAQuestion(FAQModel faqModel);

    boolean answerAQuestion(FAQModel faqModel);


}
