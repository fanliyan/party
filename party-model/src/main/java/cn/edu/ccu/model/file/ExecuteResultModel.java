package cn.edu.ccu.model.file;

/**
 * 
 * @author Administrator
 *@Description 执行某一个动作返回结果
 */
public class ExecuteResultModel {
	private boolean result =false;
	private String message;
	
	/**
	 * 执行结果
	 * @return
	 */
	public boolean isSuccess() {
		return result;
	}
	public void setIsSuccess(boolean result) {
		this.result = result;
	}
	
	/**
	 * 返回信息
	 * @return
	 */
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
}
