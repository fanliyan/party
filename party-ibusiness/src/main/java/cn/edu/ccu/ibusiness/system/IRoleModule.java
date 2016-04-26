package cn.edu.ccu.ibusiness.system;


import cn.edu.ccu.model.system.RRoleModuleModel;

import java.util.List;

/**
 * Created by kuangye on 2016/4/12.
 */
public interface IRoleModule {

    List<RRoleModuleModel> listByUserId(int userid);
}
