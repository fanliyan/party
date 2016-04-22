package cn.edu.ccu.data.student;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.student.StudentModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@PartyDB
public interface StudentModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(StudentModel record);

    int insertSelective(StudentModel record);

    StudentModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(StudentModel record);

    int updateByPrimaryKey(StudentModel record);

    StudentModel selectByStudentCode(@Param("code") String code);

    StudentModel selectByKey(@Param("account") String account, @Param("password") String password);

    List<StudentModel> select(Map map);

    int count(Map map);

    StudentModel selectDetail(Integer id);

}