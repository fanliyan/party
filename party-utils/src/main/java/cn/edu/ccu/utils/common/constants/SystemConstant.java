package cn.edu.ccu.utils.common.constants;

public interface SystemConstant {

	int ROLE_SALES = 2;// 经纪人角色id
	int ROLE_ADVISOR = 3;// 顾问角色id
	int ROLE_CUST_MANAGER =25 ;// 客服经理id
	int ROLE_MANAGER =19 ;// 管理层id
	int ROLE_HANDLE=27;//需求处理人
	
	byte LEVEL_INTERNAL = 30;//内部用户

	int COUNTRY_CHINA = 1;// 中国id

	int PERMISSION_SALES_CUSTOMER = 1;// 管理非自己的客户(所有)
	int PERMISSION_YMB_CUSTOMER = 2;// 查看编辑所有客户
	int PERMISSION_GRANT_ROLE = 4;// 分配权限
	int PERMISSION_GRANT_ADVISOR = 5;// 分配顾问
	int PERMISSION_VIEW_CUSTOMER = 6;// 查看客户联系方式
	int PERMISSION_VIEW_FOLLOWLOG = 7;// 查看跟进日志
	int PERMISSION_ADD_FOLLOWLOG = 8;// 增加所有客户跟进记录
	int PERMISSION_EDIT_CUSTOMER = 10;// 修改客户基本信息
	int PERMISSION_DOWNLOAD_CUSTOMER = 11;// 顾问导出自己的客户数据
	int PERMISSION_GRANT_DEMAND = 12;// 分配需求
	int PERMISSION_YMB_DEMAND = 13;// 查看所有需求
	int PERMISSION_GRANT_CALLBACK = 14;// 回访
	int PERMISSION_GRANT_VIEWCALLBACK = 15;// 查看回访
    int PERMISSION_ADD_OR_EDIT_SUCCESSCASE = 16;//添加修改成功案例
	

	int CUSTOMER_STATUS_FOLLOW = 1;// 长期维护
	int CUSTOMER_STATUS_IMPORTANT = 2;// 重点跟进
	int CUSTOMER_STATUS_WEED=5;//淘汰客户
	int CUSTOMER_STATUS_OUT=8;//转出客户

	int PERMISSION_ADD_OR_EDIT_TAG = 9;// 编辑标签 特殊权限

	String CONTACTS_SMS = "崔先生(18616638069)王先生(13166266079)";// 短信联系人

	/* 客户来源 */
	int SOURCE_TYPE_SALES = 0;// 经纪人
	int SOURCE_TYPE_WEBSITE = 1;// 网站客户
	int SOURCE_TYPE_REFERRER = 2;// 客户推荐
	int SOURCE_TYPE_ADVISER = 3;// 顾问带入

	int REPORT_GROUP_ID = 9;// 报表modulegroupID

	int PRODUCT_TYPE_OF_HOUSE = 1;
	/**
	 * 商业投资移民
	 */
	int PRODUCT_TYPE_OF_BUSINESS = 2;
	/**
	 * 金融投资移民
	 */
	int PRODUCT_TYPE_OF_FINANCE = 3;
	/**
	 * 创业移民
	 */
	int PRODUCT_TYPE_OF_STARTUP = 4;

	int EMAIL_GROUP_CUSTOMER_OBSOLETE = 1;
	
	/**
	 * 客户需求状态
	 */
	int DEMAND_STATUS_INIT =1;//创建
	int DEMAND_STATUS_ALLOCATIONED =2;//已分配
	int DEMAND_STATUS_PROCESSING =3;//处理中
	int DEMAND_STATUS_FINISH =4;//已解决
	
	/**
	 * 短信模板编号
	 */
	int SMS_TEMP_DEMAND_PROCESS =12;//短信模板需求处理提醒
	int SMS_TEMP_DEMAND_WARNING =13;//短信模板需求超时告警
	
	/**
	 * 专家状态
	 */
	String DIC_EXPERT_BD_PROGRESS="expertBDProgress";
	/**
	 * 专家状态
	 */
	String DIC_EXPERT_STATUS="expertStatus";
	/**
	 * 专家可承接业务
	 */
	String DIC_EXPERT_BUSINESS="expertBusiness";
	
	String LOG_TYPE_MALL_PRODUCT="mallProduct";
}
