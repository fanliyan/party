package cn.edu.ccu.business.student;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.data.student.StuLogModelMapper;
import cn.edu.ccu.ibusiness.student.IStuLog;
import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.student.StuLogListRequest;
import cn.edu.ccu.model.student.StuLogListResponse;
import cn.edu.ccu.model.student.StuLogModel;
import cn.edu.ccu.model.system.LogType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class StuLogBusiness implements IStuLog {

	@Autowired
	private StuLogModelMapper stuLogModelMapper;
	
	public int addLog(LogType logType, String description, RequestHead requestHead){
		StuLogModel model = new StuLogModel();
		model.setCreateUserid(requestHead.getLoginUserId());
		model.setDescription(description);
		model.setLogType(logType);

		return stuLogModelMapper.insertSelective(model);
	}
	
	public int addLog(LogType logType, String description, String ip){
		RequestHead requestHead = new RequestHead();
		requestHead.setUserIp(ip);
		return addLog(logType, description, requestHead);
	}

	@Override
	public StuLogListResponse listBySplitPage(StuLogListRequest request) {
		Map<String,Object> map=new HashMap<String,Object>();
		if(request.getLog()!=null){
			if(request.getLog().getLogType()!=null && !"".equals(request.getLog().getLogType().name())){
				String logType=request.getLog().getLogType().name();
				map.put("logType", logType);
			}
		}
			
		UtilsBusiness.pubMapforSplitPage(request.getSplitPage(), map);
		int rowCount=stuLogModelMapper.selectByCount(map);
		List<StuLogModel> logs=stuLogModelMapper.selectByMap(map);
        StuLogListResponse response=new StuLogListResponse();
		response.setLogs(logs);
		response.setSplitPage(UtilsBusiness.getSplitPageResponse(rowCount, request.getSplitPage().getPageSize(), request.getSplitPage().getPageNo()));
		return response;
	}

	@Override
	public StuLogModel getLogModelById(Integer logId) {
		return stuLogModelMapper.selectByPrimaryKey(logId);
	}

}
