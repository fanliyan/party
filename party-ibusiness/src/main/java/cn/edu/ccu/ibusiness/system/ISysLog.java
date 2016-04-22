package cn.edu.ccu.ibusiness.system;


import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.system.LogType;
import cn.edu.ccu.model.system.SysLogListRequest;
import cn.edu.ccu.model.system.SysLogListResponse;
import cn.edu.ccu.model.system.SysLogModel;

public interface ISysLog {
	
	int addLog(LogType logtype, String description, RequestHead requestHead);
	
	int addLog(LogType logtype, String description, String ip);

    SysLogListResponse listBySplitPage(SysLogListRequest request);
	
	SysLogModel getLogModelById(Integer logId);
}
