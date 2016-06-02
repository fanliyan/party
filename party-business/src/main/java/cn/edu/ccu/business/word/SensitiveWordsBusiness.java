package cn.edu.ccu.business.word;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.data.common.SensitiveWordsModelMapper;
import cn.edu.ccu.data.exam.ScoreModelMapper;
import cn.edu.ccu.ibusiness.word.ISensitiveWords;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.SplitPageResponse;
import cn.edu.ccu.model.common.SensitiveWordsModel;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.word.SensitiveWordListResponse;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.wltea.analyzer.core.IKSegmenter;
import org.wltea.analyzer.core.Lexeme;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 2015年5月14日下午3:43:25
 * 敏感词逻辑处理类
 */
@Service
public class SensitiveWordsBusiness implements ISensitiveWords {

    // Field 总要改？？？？ TODO
    private static SensitiveWordsModelMapper wordsModelMapper;

    @Autowired
    public void setWordsModelMapper(SensitiveWordsModelMapper wordsModelMapper) {
        this.wordsModelMapper = wordsModelMapper;
    }

    // endField
    private static List<String> words = new ArrayList<>();

    @PostConstruct
    public void init() {
        words = wordsModelMapper.getAllSensitiveWords();
    }

    private static void list() {
        int rowCount = wordsModelMapper.count(new HashMap());
        if (rowCount != words.size()) {
            words = wordsModelMapper.getAllSensitiveWords();
        }
    }

    /**
     * 验证内容中是否存在敏感词,如果存在则返回true,不存在返回false
     */
    public static boolean wordsIsSensitive(String content) {
        if (StringExtention.isTrimNullOrEmpty(content))
            return false;

        boolean flag = false;
        if (content == null || content.length() == 0)
            return flag;

        SensitiveWordsBusiness.list();

        try {
            StringReader re = new StringReader(content);
            IKSegmenter ik = new IKSegmenter(re, false);
            Lexeme lex = null;
            while ((lex = ik.next()) != null) {
//				System.out.print(lex.getLexemeText() + "|");
                String string = lex.getLexemeText();
                if (words.contains(string)) {
                    System.out.println("敏感词========" + string);
                    flag = true;
                    break;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            flag = true;
        }
        return flag;
    }


    public SensitiveWordListResponse list(SplitPageRequest splitPageRequest, String word) {

        SensitiveWordListResponse response = new SensitiveWordListResponse();

        Map<String, Object> map = new HashMap<>();

        UtilsBusiness.pubMapforSplitPage(splitPageRequest, map);

        if (word != null) {
            map.put("word", word);
        }
        List<SensitiveWordsModel> sensitiveWordsModelList = wordsModelMapper.select(map);

        response.setSensitiveWordsModelList(sensitiveWordsModelList);

        if (splitPageRequest != null && splitPageRequest.isReturnCount()) {
            int rowCount = wordsModelMapper.count(map);

            SplitPageResponse pageResponse = UtilsBusiness.getSplitPageResponse(
                    rowCount, splitPageRequest.getPageSize(), splitPageRequest.getPageNo());
            response.setSplitPageResponse(pageResponse);
        }

        return response;
    }


    public boolean add(String word) {
        if (!StringExtention.isTrimNullOrEmpty(word)) {

            try {
                SensitiveWordsModel sensitiveWordsModel = new SensitiveWordsModel();
                sensitiveWordsModel.setWord(word);
                return wordsModelMapper.insertSelective(sensitiveWordsModel) > 0;
            } catch (Exception e) {
                throw new BusinessException("该词已存在");
            }
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public boolean delete(Integer id) {
        if (IntegerExtention.hasValueAndMaxZero(id)) {
            return wordsModelMapper.deleteByPrimaryKey(id) > 0;
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


}
