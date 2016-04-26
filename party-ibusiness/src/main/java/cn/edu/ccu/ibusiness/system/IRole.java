package cn.edu.ccu.ibusiness.system;

import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.system.RRoleModuleModel;
import cn.edu.ccu.model.system.RoleModel;

import java.util.List;

/**
 * Created by kuangye on 2016/4/12.
 */
public interface IRole {
    List<RoleModel> listRolesByUserId(Integer userId);

    List<RoleModel> listRolesDetailByUserId(Integer userId);

    List<RoleModel> list();

    void insertOrUpdateRoleAndRoleModule(RoleModel roleModel, List<RRoleModuleModel> roleModuleModelList, RequestHead requestHead) throws BusinessException;

    RoleModel findRolesByRoleId(int roleId);

    void deleteByRoleId(int roleId,RequestHead requestHead);
}
