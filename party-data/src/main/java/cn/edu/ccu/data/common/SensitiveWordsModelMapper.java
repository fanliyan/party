package cn.edu.ccu.data.common;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.common.SensitiveWordsModel;

import java.util.List;
import java.util.Map;

@PartyDB
public interface SensitiveWordsModelMapper {
    int deleteByPrimaryKey(Integer wordId);

    int insert(SensitiveWordsModel record);

    int insertSelective(SensitiveWordsModel record);

    SensitiveWordsModel selectByPrimaryKey(Integer wordId);

    int updateByPrimaryKeySelective(SensitiveWordsModel record);

    int updateByPrimaryKey(SensitiveWordsModel record);

    List<String> getAllSensitiveWords();


    List<SensitiveWordsModel> select(Map map);

    int count(Map map);

}