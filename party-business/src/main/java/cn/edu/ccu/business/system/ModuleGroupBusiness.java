package cn.edu.ccu.business.system;

import cn.edu.ccu.data.system.ModuleGroupModelMapper;
import cn.edu.ccu.data.system.ModuleModelMapper;
import cn.edu.ccu.ibusiness.system.IModuleGroup;
import cn.edu.ccu.model.system.ModuleGroupModel;
import cn.edu.ccu.model.system.ModuleModel;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


@Service
public class ModuleGroupBusiness implements IModuleGroup {
	@Autowired
	private ModuleGroupModelMapper moduleGroupModelMapper;

	@Autowired
	private ModuleModelMapper moduleModelMapper;


	public List<ModuleGroupModel> list(Integer loginUserId) {
		// 先取出所有模块分组
		List<ModuleGroupModel> resultList = moduleGroupModelMapper.list();

		// 取出模块
		List<ModuleModel> moduleList ;
		if (IntegerExtention.hasValueAndMaxZero(loginUserId)) {
			moduleList = moduleModelMapper.selectByUserId(loginUserId);
		} else {
			moduleList = moduleModelMapper.list();
		}

		// 将分组赋入模块
		for (ModuleGroupModel groupModel : resultList) {

            List<ModuleModel> tempModulesList =new ArrayList<>();

            for(ModuleModel moduleModel:moduleList){
                if(moduleModel.getModulegroupId().equals(groupModel.getId()))
                    tempModulesList.add(moduleModel);
            }

//			tempModulesList = moduleList.stream().filter((u) -> u.getModuleGroupId() == groupModel.getModuleGroupId()).collect(Collectors.toList());

			if ( tempModulesList.size() > 0) {
				groupModel.setModuleModelList(tempModulesList);
			}
		}

		// 删除没有模块的分组
		for (int i = 0; i < resultList.size(); i++) {
			if (resultList.get(i).getModuleModelList() == null) {
				resultList.remove(i);
				i--;
			}
		}

		return resultList;
	}

}
