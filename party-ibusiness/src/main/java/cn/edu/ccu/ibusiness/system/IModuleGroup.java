package cn.edu.ccu.ibusiness.system;


import cn.edu.ccu.model.system.ModuleGroupModel;
import cn.edu.ccu.model.system.ModuleModel;

import java.util.List;

/**
 * Created by Administrator on 2016/4/12.
 */
public interface IModuleGroup {

    List<ModuleGroupModel> list(Integer loginUserId);
}
