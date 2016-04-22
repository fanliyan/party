package cn.edu.ccu.business.system;

import cn.edu.ccu.data.TransactionManagerName;
import cn.edu.ccu.data.system.ModuleModelMapper;
import cn.edu.ccu.data.system.RRoleModuleModelMapper;
import cn.edu.ccu.data.system.RoleModelMapper;
import cn.edu.ccu.ibusiness.system.ISysLog;
import cn.edu.ccu.ibusiness.system.IRole;
import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.system.LogType;
import cn.edu.ccu.model.system.ModuleModel;
import cn.edu.ccu.model.system.RRoleModuleModel;
import cn.edu.ccu.model.system.RoleModel;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
public class RoleBusiness implements IRole {

	@Autowired
	private RoleModelMapper roleModelMapper;

	@Autowired
	private RRoleModuleModelMapper rRoleModuleModelMapper;

	@Autowired
	private ModuleModelMapper moduleModelMapper;

	@Autowired
	private ISysLog iLog;

    //查询rolemodel
	@Override
	public List<RoleModel> listRolesByUserId(Integer userId) {
		return roleModelMapper.selectRolesByUserId(userId);
	}

    //查询role 以及 module
	@Override
	public List<RoleModel> listRolesDetailByUserId(Integer userId) {
		return roleModelMapper.selectRolesDetailByUserId(userId);
	}

	public List<RoleModel> list() {
		return roleModelMapper.list();
	}

	public RoleModel findRolesByRoleId(int roleId) {
        RoleModel model = roleModelMapper.selectByPrimaryKey(roleId);
		if (model != null) {
			List<ModuleModel> modulesModelList = moduleModelMapper.SelectByRoleId(roleId);

			if (modulesModelList != null) {
				model.setModuleModelList(modulesModelList);
			}
		}
		return model;
	}

	@Transactional(value= TransactionManagerName.partyTransactionManager)
	public void insertOrUpdateRoleAndRoleModule(RoleModel rolesModel, List<RRoleModuleModel> roleModuleModelList, RequestHead requestHead) throws BusinessException {
		String insertOrUpdateDescription = "";
		List<RoleModel> oldRolesModel = roleModelMapper.selectByRoleName(rolesModel.getName());

		if (rolesModel.getRoleId() == null || rolesModel.getRoleId() == 0) {
			if (oldRolesModel != null && oldRolesModel.size() != 0) {
				throw new BusinessException("此角色已存在！");
			}

			insertOrUpdateDescription = "新增";
			roleModelMapper.insertSelective(rolesModel);
		} else {
			if (oldRolesModel != null && oldRolesModel.size() > 0 && oldRolesModel.get(0).getRoleId() != rolesModel.getRoleId()) {
				throw new BusinessException("此角色名称已经被使用！");
			}

			insertOrUpdateDescription = "更新";

			roleModelMapper.updateByPrimaryKeySelective(rolesModel);
			rRoleModuleModelMapper.deleteByRoleId(rolesModel.getRoleId());
		}

		if (roleModuleModelList != null && roleModuleModelList.size() > 0) {
			for (RRoleModuleModel model : roleModuleModelList) {
				model.setModuleId(model.getModuleId());
				model.setRoleId(rolesModel.getRoleId());
				rRoleModuleModelMapper.insertSelective(model);
			}
		}

		String logDescripton = String.format("%s %s了角色 ，角色名称：%s,角色ID：%s", requestHead.getUserIp(), insertOrUpdateDescription, rolesModel.getName(), rolesModel.getRoleId());
		iLog.addLog(LogType.AuthorityManage, logDescripton, requestHead);
	}

	@Transactional(value=TransactionManagerName.partyTransactionManager)
	public void deleteByRoleId(int roleId, RequestHead requestHead) {
		roleModelMapper.deleteByPrimaryKey(roleId);
		rRoleModuleModelMapper.deleteByRoleId(roleId);

		iLog.addLog(LogType.AuthorityManage, requestHead.getUserIp() + "删除了角色,角色ID" + roleId, requestHead);
	}

}
