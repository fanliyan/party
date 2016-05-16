package cn.edu.ccu.data.exam;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.common.TableModel;
import cn.edu.ccu.model.exam.ExamModel;
import cn.edu.ccu.model.exam.ExamModelWithBLOBs;

import java.util.List;
import java.util.Map;

@PartyDB
public interface ExamModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ExamModelWithBLOBs record);

    int insertSelective(ExamModelWithBLOBs record);

    ExamModelWithBLOBs selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ExamModelWithBLOBs record);

    int updateByPrimaryKeyWithBLOBs(ExamModelWithBLOBs record);

    int updateByPrimaryKey(ExamModel record);



    List<ExamModel> selectWithUser(Map map);

    List<ExamModel> select(Map map);

    int count(Map map);


    ExamModelWithBLOBs selectByMap(Map map);


    //统计相关

    //查询 某考试 某角色 学生 分数排名
    List<TableModel> getAExamTop(Map map);
}