package cn.edu.ccu.ibusiness.word;

import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.word.SensitiveWordListResponse;

/**
 * Created by kuangye on 2016/4/12.
 */
public interface ISensitiveWords {


    SensitiveWordListResponse list(SplitPageRequest splitPageRequest, String word);

    boolean add(String word);

    boolean delete(Integer id);
}
