package cn.edu.ccu.data.course;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.course.TaskModel;

import java.util.List;
import java.util.Map;

@PartyDB
public interface TaskModelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TaskModel record);

    int insertSelective(TaskModel record);

    TaskModel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TaskModel record);

    int updateByPrimaryKey(TaskModel record);

    List<TaskModel> select(Map map);

    int count(Map map);
}