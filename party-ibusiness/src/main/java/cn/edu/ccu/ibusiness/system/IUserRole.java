package cn.edu.ccu.ibusiness.system;

import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.system.RUserRoleModel;
import cn.edu.ccu.model.system.RUserRoleModelKey;

import java.util.List;

/**
 * Created by kuangye on 2016/4/12.
 */
public interface IUserRole {

    int insert(RUserRoleModel record);

    RUserRoleModel selectByPrimaryKey(RUserRoleModelKey key);


    /**
     * @Title:editByUserRoleIds
     * @Description: 给用户分配角色
     * @param userid 用户id
     * @param roleIds 多个角色id
     * @param requestHead 操作人员信息
     * @return int
     * @throws
     */
    int editByUserRoleIds(Integer userid, Integer roleIds[], Byte level, RequestHead requestHead);

    List<RUserRoleModel> listByUserId(Integer userid);
}
