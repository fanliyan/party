package cn.edu.ccu.data.article;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.article.ArticleWordsIndexModelKey;

import java.util.List;

@PartyDB
public interface ArticleWordsIndexModelMapper {
    int deleteByPrimaryKey(ArticleWordsIndexModelKey key);

    int insert(ArticleWordsIndexModelKey record);

    int insertSelective(ArticleWordsIndexModelKey record);

    List<Integer> selectByKeyWords(List<String> list);

    int deleteByArticle(Integer id);
}