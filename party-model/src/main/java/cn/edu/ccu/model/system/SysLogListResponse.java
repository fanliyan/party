package cn.edu.ccu.model.system;


import cn.edu.ccu.model.SplitPageResponse;

import java.util.List;

public class SysLogListResponse {

	private List<SysLogModel> logs;
	private SplitPageResponse splitPage;

	public List<SysLogModel> getLogs() {
		return logs;
	}

	public void setLogs(List<SysLogModel> logs) {
		this.logs = logs;
	}

	public SplitPageResponse getSplitPage() {
		return splitPage;
	}

	public void setSplitPage(SplitPageResponse value) {
		this.splitPage = value;
	}

}
