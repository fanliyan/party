package cn.edu.ccu.manage.controller.system;

import cn.edu.ccu.ibusiness.system.IModuleGroup;
import cn.edu.ccu.ibusiness.system.IRole;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.AuthList;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.system.ModuleGroupModel;
import cn.edu.ccu.model.system.RRoleModuleModel;
import cn.edu.ccu.model.system.RoleModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/role")
@AuthController(moduleId = 2)
public class RoleController extends BaseController {
	@Autowired
    IRole iRole;

	@Autowired
    IModuleGroup iModuleGroup;

	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {
		ModelAndView mav = Common.getLoginModelAndView(httpRequest);

		List<RoleModel> rolesModelList = iRole.list();
		mav.addObject("rolesModelList", rolesModelList);
		mav.setViewName("system/role/roleList");
		return mav;
	}

	@RequestMapping("/edit")
	public ModelAndView edit(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {
		ModelAndView mav = Common.getLoginModelAndView(httpRequest);
		mav.addObject("allModuleGroupList", iModuleGroup.list(null));

		int roleId = Integer.parseInt(httpRequest.getParameter("roleId"));
		RoleModel model = iRole.findRolesByRoleId(roleId);

		mav.addObject("roleModel", model);

		mav.setViewName("system/role/role");

		return mav;
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public ModelAndView add(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {
		ModelAndView mav = Common.getLoginModelAndView(httpRequest);
		mav.addObject("allModuleGroupList", iModuleGroup.list(null));

		mav.setViewName("system/role/role");
		return mav;
	}
	@RequestMapping(value = "/roleModule", method = RequestMethod.GET)
	public ModelAndView roleModule(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {
		ModelAndView mav = Common.getLoginModelAndView(httpRequest);
		List<RoleModel> rolesModelList = iRole.list();
		List<RoleModel> rolesList = new ArrayList<>();
		for (RoleModel rolesModel : rolesModelList) {
            RoleModel model = iRole.findRolesByRoleId(rolesModel.getRoleId());
			rolesList.add(model);
		}
		List<ModuleGroupModel> allModuleGroupList=iModuleGroup.list(null);
		mav.addObject("rolesList", rolesList);
		mav.addObject("allModuleGroupList", allModuleGroupList);
		mav.setViewName("system/role/roleModule");
		return mav;
	}

	@RequestMapping(value = "/addoredit", method = RequestMethod.POST)
	public @ResponseBody
    Map<String, Object> addOrEdit(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws BusinessException {
		Map<String, Object> map = new HashMap<>();
        RoleModel rolesModel = new RoleModel();
		if (httpRequest.getParameter("roleId") != null && !httpRequest.getParameter("roleId").equals("")) {
			rolesModel.setRoleId(Integer.parseInt(httpRequest.getParameter("roleId")));
		}
		rolesModel.setName(httpRequest.getParameter("roleName"));
//		String[] permissionIds = httpRequest.getParameterValues("permissionId");

		String[] moduleIds = httpRequest.getParameterValues("moduleid");
		List<RRoleModuleModel> roleModuleModelList = new ArrayList<>();
		if (moduleIds != null && moduleIds.length > 0) {
			for (String id : moduleIds) {
                RRoleModuleModel model = new RRoleModuleModel();
				model.setModuleId(Integer.parseInt(id));
//				if (permissionIds != null && permissionIds.length > 0) {
//					String string = "";
//					for (int i = 0; i < permissionIds.length; i++) {
//						string += permissionIds[i];
//						if (i < permissionIds.length - 1) {
//							string += ",";
//						}
//					}
//					model.setPermissionIdList(string);
//				}
				roleModuleModelList.add(model);
			}
		}

		iRole.insertOrUpdateRoleAndRoleModule(rolesModel, roleModuleModelList, super.getRequestHead(httpRequest));

		map.put("success", true);

		return map;

	}

	@RequestMapping(value = "/del", method = RequestMethod.POST)
	public @ResponseBody
    Map<String, Object> del(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws BusinessException {
		Map<String, Object> map = new HashMap<>();
		int roleId = 0;
		if (httpRequest.getParameter("roleId") != null && !httpRequest.getParameter("roleId").equals("")) {
			roleId = Integer.parseInt(httpRequest.getParameter("roleId"));
		}

		if (roleId == 0) {
			map.put("success", false);
			map.put("message", "角色ID不能为空");
		} else {
            //内建角色不能删除
			RoleModel rolesModel=iRole.findRolesByRoleId(roleId);
			if(rolesModel.getIsBuiltin()){
				map.put("success", false);
				map.put("message", "内置角色不允许删除");
			}else{
				iRole.deleteByRoleId(roleId, super.getRequestHead(httpRequest));
				map.put("success", true);
			}
		}
		return map;

	}
	
}
