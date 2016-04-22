package cn.edu.ccu.ibusiness.student;


import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.student.StuLogListRequest;
import cn.edu.ccu.model.student.StuLogListResponse;
import cn.edu.ccu.model.student.StuLogModel;
import cn.edu.ccu.model.system.LogType;

public interface IStuLog {
	
	int addLog(LogType logtype, String description, RequestHead requestHead);
	
	int addLog(LogType logtype, String description, String ip);

    StuLogListResponse listBySplitPage(StuLogListRequest request);
	
	StuLogModel getLogModelById(Integer logId);
}
