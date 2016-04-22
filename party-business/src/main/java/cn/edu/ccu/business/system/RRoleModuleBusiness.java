package cn.edu.ccu.business.system;

import cn.edu.ccu.data.system.RRoleModuleModelMapper;
import cn.edu.ccu.ibusiness.system.IRoleModule;
import cn.edu.ccu.model.system.RRoleModuleModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RRoleModuleBusiness implements IRoleModule {
	@Autowired
	private RRoleModuleModelMapper rRoleModuleModelMapper;

	public List<RRoleModuleModel> listByUserId(int userId){
		return rRoleModuleModelMapper.selectByUserId(userId);
	}


}
