<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />
<#include "/function.ftl">

<@master.masterFrame pageTitle=["系统管理","用户管理","用户列表"]>
	<div class="panel panel-default table-responsive">
		<div class="panel-body">
			<form id="searchForm" class="form-inline no-margin" action="${basePath}/log/list" method="post">
				<div class="form-group">
					<label class="control-label">日志类型</label>
					<select class="form-control chzn-select" data-placeholder="请选择日志类型" name="logType" id="intCountry" >
						<option value="">全部</option>
						<option value="AuthorityManage" <#if log ?? && log.logType?? && log.logType=="AuthorityManage">selected="selected"</#if>>权限管理</option>
						<option value="Execption" <#if log ?? && log.logType?? && log.logType=="Execption">selected="selected"</#if>>程序异常</option>
						<option value="LoginFail" <#if log ?? && log.logType?? && log.logType=="LoginFail">selected="selected"</#if>>登录失败</option>
						<option value="LoginSuccess" <#if log ?? && log.logType?? && log.logType=="LoginSuccess">selected="selected"</#if>>登录成功</option>
					</select>
				</div>
				<div class="form-group" >
					<label class="control-label">开始日期</label>
					<div >
						<input id="startTime" name="startTime" placeholder="请选择开始时间" class="form-control input-sm" 
						 type="text" value="<#if log ??>${log.startTime!}</#if>" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label">结束日期</label>
					<div >
						<input id="endTime" name="endTime" placeholder="请选择结束时间" class="form-control input-sm" 
						 type="text" value="<#if log ??>${log.endTime!}</#if>" />
					</div>
				</div>
				
				<button type="submit" class="btn btn-sm btn-success"><i class="fa fa-search" style="font-size:16px;"></i></button>
			</form>
		</div>
		<table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
			<thead>
				<tr>
					<th>日志类型</th>
					<th>操作用户</th>
					<th>操作时间</th>
					<th>内容</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<#if response.logs ?? && response.logs?size gt 0>
					<#list response.logs as log>
						<tr>
							<td>
								<#if log.logType=="AuthorityManage">
									权限管理
								<#elseif log.logType=="Execption">
									程序异常
								<#elseif log.logType=="LoginSuccess">
									登录成功
								<#elseif log.logType=="LoginFail">
									登录失败
								</#if>
							</td>
							<td><#if log.user??>${log.user.userName!}<#else>${(log.createUserid)!}</#if></td>
							<td>${log.createTime?string('yyyy-MM-dd HH:mm')}</td>
							<td>${log.description!}</td>
							<td>
								<a class="btn btn-xs btn-warning" href="${basePath}/log/info?logId=${log.logId}"><i class="fa fa-info-circle fa-lg"></i> 查看</a>
							</td>
						</tr>
					</#list>
				<#else>
					<tr><td colspan=5 class="text-center">没有数据</td></tr>
				</#if>
			</tbody>
		</table>
		<#if response.logs ?? && response.logs?size gt 0>
		<@splitPage1.splitPage pageCount=response.splitPage.pageCount pageNo=response.splitPage.pageNo formId="searchForm" recordCount=response.splitPage.recordCount />
		</#if>
	</div><!-- /panel -->
	<script language="javascript">
	$.editLock = function(userid,status){
		$.ajax({
			cache: true,
			type: "POST",
			url:"${basePath}/users/editLock",
			data:"userid=" + userid+"&status="+status,// 你的formid
			async: false,
			error: function(request) {
				alertify.alert("错误：服务器异常！");
			},
			success: function(data) {
				if(data.success){
					var pageNo=$(".pagination li.active").text();
					$.GoPage(pageNo);
				}
				else{
					alertify.alert("错误:" + data.message);
				}
			}
		});
	};
</script>
<link href="${basePath}/resources/js/timepicker/jquery-ui-timepicker-addon.min.css" rel="stylesheet" type="text/css" />
<script src="${basePath}/resources/js/timepicker/jquery-ui-timepicker-addon.min.js" type="text/javascript"></script>
<script src="${basePath}/resources/js/timepicker/jquery-ui-timepicker-zh-CN.js" type="text/javascript"></script>
<script type="text/javascript">
$().ready(function () {
	$('#startTime').datetimepicker({
		hour: 12,
		minute: 30,
		timeFormat: "HH:mm",
		dateFormat: "yy-mm-dd",
		minDate: new Date(2015, 0, 01, 00, 00),
		maxDate: new Date(),
		onSelect:function(dateText,inst){
			$("#endTime").datepicker("option","minDate",dateText);
		}
	});
	$('#endTime').datetimepicker({
		hour: 12,
		minute: 30,
		timeFormat: "HH:mm",
		dateFormat: "yy-mm-dd",
		minDate: new Date(2015, 0, 01, 00, 00),
		maxDate: new Date(),
		onSelect:function(dateText,inst){
			$("#startTime").datepicker("option","maxDate",dateText);
		}
	});
});
</script>
</@master.masterFrame>