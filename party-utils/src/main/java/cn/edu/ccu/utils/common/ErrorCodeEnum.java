package cn.edu.ccu.utils.common;


/**
 * 接口错误吗
 * @author yinqiang
 *
 */
public enum ErrorCodeEnum {
	/*
	 * 存于<li><a href="<%=path%>/apidocument/common/ERROR_CODE.html">错误 - 错误码</a></li>下
	 * */
	
	//用户相关
	/**
	 * 用户名密码为空
	 */
	
	registerInfoError(100100000001L,"请填写完整的注册信息"),
	
	uidOrPasswordError(100100000002L,"用户名密码异常"),
	
	nickNameError(100100000003L,"昵称异常"),
	nickNameTooLong(100100000004L,"昵称过长"),
	
	phoneError(100100000005L,"手机号码填写有误"),
	emailError(100100000006L,"邮箱号码填写有误"),
	passwordError(100110000007L,"密码异常"),
	
	sameAccountError(100100000008L,"相同的用户名已经存在"),
	samePhoneError(100100000009L, "相同的手机号码已经存在"),
	sameEmailError(100100000010L, "相同的电子邮箱已经存在"),
	sameQQError(100100000011L, "相同的QQ已经存在"),
	sameWechatError(100100000012L, "相同的微信已经存在"),
	sameWeiboError(100100000013L, "相同的微博已经存在"),
	
	noAccountError(100100000014L,"用户名不存在"),
	noPhoneError(100100000015L, "手机号码不存在"),
	noEmailError(100100000016L, "电子邮箱不存在"),

	
	groupTypeNotMatchError(100100000017L, "用户组与用户类型不匹配"),
	
	noLoginUserIdError(100100000018L, "无操作用户错误"),
	
	requestParamError(100100000019L, "请求参数不正确"),
	
	//前端验此 code
	noUserError(100100000020L,"无此用户"),
	
	findPwdError(100100000021L,"找回密码错误"),
	
	
	verifyCodeError(100100000022L,"验证码错误"),
	verifyCodeExpiredError(100100000023L,"验证码已过期"),
	usedVerifyCodeError(100100000024L,"验证码已使用"),
	noVerifyCodeError(100100000025L,"验证码不存在"),
	
	
	findPwdEmailError(100100000026L,"找回密码邮箱错误"),
	
	
	bindAccountExist(100100000027L,"账号已被绑定"),
	alreadyBinding(100100000028L,"已有绑定账号"),
	bindAccountNotExist(100100000029L,"无绑定账号"),
	
	
	alreadyFocus(100100000030L,"已关注"),
	notFocus(100100000031L,"未关注"),
	
	
	genderError(100100000032L,"性别错误"),
	sensitiveWordsError(100100000033L,"存在敏感字段"),
	nickNameOccupied(100100000034L,"昵称已存在"),
	
	
	signatureTooLong(100100000035L,"签名过长"),
	areaTooLong(100100000036L,"地区过长"),
	jobTooLong(100100000037L,"职业过长"),

	
	questionStatusError(100100000038L,"该回复对应问题已删除"),
	questionNotExist(100100000038L,"该问题不存在"),

    titleExist(100100000040L,"文章标题已存在"),
	
	
	
	systemError(100200000001L,"系统异常"),
	
	operationError(100200000002L,"操作异常"),
	
	paramConflict(100200000003L,"参数冲突"),

	noOpenIdError(100200000004L,"微信登陆openid不可为空"),
	
	
	//1003开头为文章相关错误
	ArticleIsDelete(100300000001L,"文章已被删除"),
	ArticleNoCanDisplay(100300000002L,"文章未审核通过"),
	ArticleParaRequirement(100300000003L,"文章相关参数不全"),
	ArticleCommentAddError(100300000004L,"添加评论异常，稍后重试")
	
	;
	
	
	//code值
	private final long value;
	//话术
	private final String message;
	ErrorCodeEnum(long value,String message){
		this.value =value;
		this.message =message;
	}
	public long getValue(){
		return this.value;
	}
	public String getMessage(){
		return this.message;
	}
}
