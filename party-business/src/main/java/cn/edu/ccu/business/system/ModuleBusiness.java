package cn.edu.ccu.business.system;

import cn.edu.ccu.data.system.ModuleModelMapper;
import cn.edu.ccu.ibusiness.system.IModule;
import cn.edu.ccu.model.system.ModuleModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ModuleBusiness implements IModule {

	@Autowired
	private ModuleModelMapper moduleModelMapper;
	

	@Override
	public List<ModuleModel> listByUserId(Integer userId) {
		List<ModuleModel> modelList = moduleModelMapper.selectByUserId(userId);
		
		return modelList;
	}

}
