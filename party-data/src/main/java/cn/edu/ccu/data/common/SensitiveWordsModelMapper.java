package cn.edu.ccu.data.common;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.common.SensitiveWordsModel;

import java.util.List;

@PartyDB
public interface SensitiveWordsModelMapper {
    int deleteByPrimaryKey(Integer wordId);

    int insert(SensitiveWordsModel record);

    int insertSelective(SensitiveWordsModel record);

    SensitiveWordsModel selectByPrimaryKey(Integer wordId);

    int updateByPrimaryKeySelective(SensitiveWordsModel record);

    int updateByPrimaryKey(SensitiveWordsModel record);

    List<String> getAllSensitiveWords();

}