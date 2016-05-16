package cn.edu.ccu.data.user;

import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.user.UserModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@PartyDB
public interface UserModelMapper {
    int deleteByPrimaryKey(Integer userId);

    int insert(UserModel record);

    int insertSelective(UserModel record);

    UserModel selectByPrimaryKey(Integer userId);

    int updateByPrimaryKeySelective(UserModel record);

    int updateByPrimaryKey(UserModel record);


    List<UserModel> selectByUserMap(Map map);

    int selectCount(Map map);

    List<UserModel> selectByIds(List<Integer> ids);

    UserModel selectByKey(@Param("account") String account, @Param("password") String password);



}