package cn.edu.ccu.manage.controller.system;

import cn.edu.ccu.ibusiness.system.ISysLog;
import cn.edu.ccu.manage.controller.BaseController;
import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.Common;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.system.SysLogListRequest;
import cn.edu.ccu.model.system.SysLogListResponse;
import cn.edu.ccu.model.system.SysLogModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/log")
@AuthController(moduleId = 3)
public class LogController extends BaseController {

	@Autowired
	private ISysLog ilog;

	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest httpRequest, HttpServletResponse httpResponse, SysLogModel log, SplitPageRequest pageRequest) throws Exception {
		ModelAndView mav = Common.getLoginModelAndView(httpRequest);
		SysLogListRequest request = new SysLogListRequest();
		pageRequest.setPageSize(20);
		if (pageRequest.getPageNo() < 1) {
			pageRequest.setPageNo(1);
		}
		request.setLog(log);
		request.setSplitPage(pageRequest);
        SysLogListResponse response=ilog.listBySplitPage(request);
		mav.addObject("response", response);
		mav.addObject("log", log);
		mav.setViewName("system/log/logList");
		return mav;
	}
	@RequestMapping("/info")
	public ModelAndView info(HttpServletRequest httpRequest, HttpServletResponse httpResponse, Integer logId) throws Exception {
		ModelAndView mav = Common.getLoginModelAndView(httpRequest);
        SysLogModel logModel=ilog.getLogModelById(logId);
		mav.addObject("logModel", logModel);
		mav.setViewName("system/log/logInfo");
		return mav;
	}
}
