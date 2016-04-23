package cn.edu.ccu.data.faq;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.faq.FAQModel;

import java.util.List;
import java.util.Map;

@PartyDB
public interface FAQModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(FAQModel record);

    int insertSelective(FAQModel record);

    FAQModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(FAQModel record);

    int updateByPrimaryKey(FAQModel record);


    List<FAQModel> selectWithUser(Map map);

    List<FAQModel> select(Map map);

    int count(Map map);

}