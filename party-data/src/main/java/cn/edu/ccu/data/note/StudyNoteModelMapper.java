package cn.edu.ccu.data.note;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.note.StudyNoteModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@PartyDB
public interface StudyNoteModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(StudyNoteModel record);

    int insertSelective(StudyNoteModel record);

    StudyNoteModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(StudyNoteModel record);

    int updateByPrimaryKeyWithBLOBs(StudyNoteModel record);

    int updateByPrimaryKey(StudyNoteModel record);


    List<StudyNoteModel> select(Map map);

    List<StudyNoteModel> selectWithStudent(Map map);

    int count(Map map);


    StudyNoteModel getByIdAndStudentId(@Param("id") Integer id, @Param("studentId") Integer studentId);

    //查询已发布文章
    StudyNoteModel getByIdWithStudent(Integer id);
}