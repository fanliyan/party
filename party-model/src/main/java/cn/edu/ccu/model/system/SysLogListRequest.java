package cn.edu.ccu.model.system;


import cn.edu.ccu.model.SplitPageRequest;

public class SysLogListRequest {

	private SysLogModel log;
	private SplitPageRequest splitPage;


	public SplitPageRequest getSplitPage() {
		return splitPage;
	}

	public void setSplitPage(SplitPageRequest value) {
		this.splitPage = value;
	}

	public SysLogModel getLog() {
		return log;
	}

	public void setLog(SysLogModel log) {
		this.log = log;
	}

}
