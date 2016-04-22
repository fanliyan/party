package cn.edu.ccu.business.word;

import cn.edu.ccu.data.common.SensitiveWordsModelMapper;
import cn.edu.ccu.ibusiness.word.ISensitiveWords;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.wltea.analyzer.core.IKSegmenter;
import org.wltea.analyzer.core.Lexeme;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

/**
 * @author 2015年5月14日下午3:43:25
 * @Description 敏感词逻辑处理类
 */
@Service
public class SensitiveWordsBusiness implements ISensitiveWords {

    // Field
    @Autowired
    private SensitiveWordsModelMapper wordsModelMapper;

    // endField
    private static List<String> words = new ArrayList<>();

    @PostConstruct
    public void init() {
        words = wordsModelMapper.getAllSensitiveWords();
    }

    /**
     * 验证内容中是否存在敏感词,如果存在则返回true,不存在返回false
     */
    public static boolean wordsIsSensitive(String content) {
        boolean flag = false;
        if (content == null || content.length() == 0)
            return flag;
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
}
