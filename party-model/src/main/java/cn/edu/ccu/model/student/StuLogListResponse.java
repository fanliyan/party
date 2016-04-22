package cn.edu.ccu.model.student;


import cn.edu.ccu.model.SplitPageResponse;

import java.util.List;

public class StuLogListResponse {

	private List<StuLogModel> logs;
	private SplitPageResponse splitPage;

	public List<StuLogModel> getLogs() {
		return logs;
	}

	public void setLogs(List<StuLogModel> logs) {
		this.logs = logs;
	}

	public SplitPageResponse getSplitPage() {
		return splitPage;
	}

	public void setSplitPage(SplitPageResponse value) {
		this.splitPage = value;
	}

}
