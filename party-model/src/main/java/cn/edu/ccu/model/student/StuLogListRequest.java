package cn.edu.ccu.model.student;


import cn.edu.ccu.model.SplitPageRequest;

public class StuLogListRequest {

	private StuLogModel log;
	private SplitPageRequest splitPage;


	public SplitPageRequest getSplitPage() {
		return splitPage;
	}

	public void setSplitPage(SplitPageRequest value) {
		this.splitPage = value;
	}

	public StuLogModel getLog() {
		return log;
	}

	public void setLog(StuLogModel log) {
		this.log = log;
	}

}
