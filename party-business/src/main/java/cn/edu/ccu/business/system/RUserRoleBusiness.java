package cn.edu.ccu.business.system;

import cn.edu.ccu.data.TransactionManagerName;
import cn.edu.ccu.data.system.RUserRoleModelMapper;
import cn.edu.ccu.ibusiness.system.ISysLog;
import cn.edu.ccu.ibusiness.system.IRole;
import cn.edu.ccu.ibusiness.system.IUser;
import cn.edu.ccu.ibusiness.system.IUserRole;
import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.system.LogType;
import cn.edu.ccu.model.system.RUserRoleModel;
import cn.edu.ccu.model.system.RUserRoleModelKey;
import cn.edu.ccu.model.user.UserModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Created by kuangye on 2016/4/12.
 */
@Service
public class RUserRoleBusiness implements IUserRole {

    @Autowired
    private RUserRoleModelMapper rUserRoleModelMapper;

    @Autowired
    private IUser iUser;

    @Autowired
    private IRole iRole;

    @Autowired
    private ISysLog iLog;

    @Override
    @Transactional
    public int insert(RUserRoleModel record) {

        return rUserRoleModelMapper.insert(record);
    }

    @Override
    public RUserRoleModel selectByPrimaryKey(RUserRoleModelKey key) {

        return rUserRoleModelMapper.selectByPrimaryKey(key);
    }

    @Override
    @Transactional(value = TransactionManagerName.partyTransactionManager)
    public int editByUserRoleIds(Integer userId, Integer[] roleIds, Byte level, RequestHead requestHead) {

        UserModel model=new UserModel();
        model.setUserId(userId);
//        iUser.updateUser(model);//更改用户级别

        StringBuffer rIds = new StringBuffer("");
        String logDesc = "";
        Integer createUserId = requestHead.getLoginUserId();
        int result = 0;
        if (roleIds == null||(roleIds != null && roleIds.length == 0)) {
            List<RUserRoleModel> ur = rUserRoleModelMapper.selectRolesByUserId(userId);//如果传过来角色为空,在删除前查询用户之前的角色,用来记录日志
            for (int i = 0; i < ur.size(); i++) {
                Integer integer = ur.get(i).getRoleId();
                rIds.append(integer);
                if (i < ur.size() - 1) {
                    rIds.append(",");
                }
            }
            logDesc = String.format("用户 %s 删除了用户 %s 的角色 %s", createUserId, userId, rIds.toString());
        }
        result = rUserRoleModelMapper.deleteByUserId(userId);
        if (roleIds != null && roleIds.length > 0) {
            for (int i = 0; i < roleIds.length; i++) {
                Integer integer = roleIds[i];
                RUserRoleModel rUserRoleModel = new RUserRoleModel();
                rUserRoleModel.setRoleId(integer);
                rUserRoleModel.setUserId(userId);
                rUserRoleModel.setCreateTime(new Date());
                rUserRoleModel.setLastModifyTime(new Date());
                result = rUserRoleModelMapper.insert(rUserRoleModel);
                rIds.append(integer);
                if (i < roleIds.length - 1) {
                    rIds.append(",");
                }
            }
            logDesc = String.format("用户 %s 给用户 %s 分配了角色 %s", createUserId, userId, rIds.toString());
        }
        iLog.addLog(LogType.AuthorityManage, logDesc, requestHead);
        return result;
    }

    @Override
    public List<RUserRoleModel> listByUserId(Integer userid) {
        return rUserRoleModelMapper.selectRolesByUserId(userid);
    }

}
