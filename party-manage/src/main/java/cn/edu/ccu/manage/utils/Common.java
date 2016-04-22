package cn.edu.ccu.manage.utils;

import cn.edu.ccu.ibusiness.system.IModuleGroup;
import cn.edu.ccu.model.user.UserModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Component
public class Common {

	private static IModuleGroup iModuleGroup;

	@Autowired
	public void setIModuleGroup(IModuleGroup iModuleGroup) {
		Common.iModuleGroup = iModuleGroup;  
    }
	
	public static ModelAndView getLoginModelAndView(HttpServletRequest httpRequest) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		UserModel loginUserModel = AuthHelper.getLoginUserModel(httpRequest);
		
		// 左边菜单
		mav.addObject("loginModuleGroupList",iModuleGroup.list(loginUserModel.getUserId()));
		
		// 登录用户
		mav.addObject("loginUserModel",loginUserModel);
				
		return mav;
	}
}
