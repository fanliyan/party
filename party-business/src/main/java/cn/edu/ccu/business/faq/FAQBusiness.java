package cn.edu.ccu.business.faq;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.data.faq.FAQModelMapper;
import cn.edu.ccu.ibusiness.faq.IFAQ;
import cn.edu.ccu.model.SplitPageResponse;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.faq.FAQListRequest;
import cn.edu.ccu.model.faq.FAQListResponse;
import cn.edu.ccu.model.faq.FAQModel;
import cn.edu.ccu.model.faq.FAQStatus;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/4/23.
 */
@Service
public class FAQBusiness implements IFAQ {


    @Autowired
    private FAQModelMapper faqModelMapper;


 public    FAQModel selectById(Integer id){

        if(IntegerExtention.hasValueAndMaxZero(id)){
            return  faqModelMapper.selectByPrimaryKey(id);
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public  FAQListResponse select(FAQListRequest faqListRequest){


        FAQListResponse response = new FAQListResponse();

        Map<String, Object> map = new HashMap<>();
        UtilsBusiness.pubMapforSplitPage(faqListRequest.getSplitPageRequest(), map);


        FAQModel faqModel = faqListRequest.getFaqModel();
        if (faqModel != null) {
            if (faqModel.getAskUserId() != null) {
                map.put("studentId", faqModel.getAskUserId());
            }
            if (faqModel.getAnswerUserId() != null) {
                map.put("userId", faqModel.getAnswerUserId());
            }
            if (faqModel.getStatus() != null) {
                map.put("status", faqModel.getStatus());
            }
        }

        List<FAQModel> faqModelList;
        if (faqListRequest.isWithUser()) {
            faqModelList = faqModelMapper.selectWithUser(map);

        } else {
            faqModelList = faqModelMapper.select(map);
        }

        response.setFaqModelList(faqModelList);

        if (faqListRequest.getSplitPageRequest() != null && faqListRequest.getSplitPageRequest().isReturnCount()) {
            int rowCount = faqModelMapper.count(map);

            SplitPageResponse pageResponse = UtilsBusiness.getSplitPageResponse(
                    rowCount, faqListRequest.getSplitPageRequest().getPageSize(), faqListRequest.getSplitPageRequest().getPageNo());
            response.setSplitPageResponse(pageResponse);
        }

        return response;

    }

    public  boolean askAQuestion(FAQModel faqModel){

        FAQModel model = new FAQModel();

        if(StringExtention.isTrimNullOrEmpty(faqModel.getQuestion()))
            throw new BusinessException(ErrorCodeEnum.requestParamError);
        if(!IntegerExtention.hasValueAndMaxZero(faqModel.getAskUserId()))
            throw new BusinessException(ErrorCodeEnum.requestParamError);

        model.setQuestion(faqModel.getQuestion());
        model.setAskUserId(faqModel.getAskUserId());

        return faqModelMapper.insertSelective(model)>0;
    }

    public boolean answerAQuestion(FAQModel faqModel){
        FAQModel model = new FAQModel();

        if(!IntegerExtention.hasValueAndMaxZero(faqModel.getId()))
            throw new BusinessException(ErrorCodeEnum.requestParamError);
        if(StringExtention.isTrimNullOrEmpty(faqModel.getAnswer()))
            throw new BusinessException(ErrorCodeEnum.requestParamError);
        if(!IntegerExtention.hasValueAndMaxZero(faqModel.getAnswerUserId()))
            throw new BusinessException(ErrorCodeEnum.requestParamError);

        model.setId(faqModel.getId());
        model.setAnswer(faqModel.getAnswer());
        model.setAnswerUserId(faqModel.getAnswerUserId());
        model.setAnswerTime(new Date());
        model.setStatus(FAQStatus.ANSWERED);

        return faqModelMapper.updateByPrimaryKeySelective(model)>0;
    }




}
