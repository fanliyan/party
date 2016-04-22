package cn.edu.ccu.business.system;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.data.system.SysLogModelMapper;
import cn.edu.ccu.ibusiness.system.ISysLog;
import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.system.LogType;
import cn.edu.ccu.model.system.SysLogListRequest;
import cn.edu.ccu.model.system.SysLogListResponse;
import cn.edu.ccu.model.system.SysLogModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SysLogBusiness implements ISysLog {

	@Autowired
	private SysLogModelMapper sysLogModelMapper;
	
	public int addLog(LogType logType, String description, RequestHead requestHead){
        SysLogModel model = new SysLogModel();
		model.setCreateUserid(requestHead.getLoginUserId());
		model.setDescription(description);
		model.setLogType(logType);

		return sysLogModelMapper.insertSelective(model);
	}
	
	public int addLog(LogType logType, String description, String ip){
		RequestHead requestHead = new RequestHead();
		requestHead.setUserIp(ip);
		return addLog(logType, description, requestHead);
	}

	@Override
	public SysLogListResponse listBySplitPage(SysLogListRequest request) {
		Map<String,Object> map=new HashMap<String,Object>();
		if(request.getLog()!=null){
			if(request.getLog().getLogType()!=null && !"".equals(request.getLog().getLogType().name())){
				String logType=request.getLog().getLogType().name();
				map.put("logType", logType);
			}
		}
			
		UtilsBusiness.pubMapforSplitPage(request.getSplitPage(), map);
		int rowCount=sysLogModelMapper.selectByCount(map);
		List<SysLogModel> logs=sysLogModelMapper.selectByMap(map);
        SysLogListResponse response=new SysLogListResponse();
		response.setLogs(logs);
		response.setSplitPage(UtilsBusiness.getSplitPageResponse(rowCount, request.getSplitPage().getPageSize(), request.getSplitPage().getPageNo()));
		return response;
	}

	@Override
	public SysLogModel getLogModelById(Integer logId) {
		return sysLogModelMapper.selectByPrimaryKey(logId);
	}

}
