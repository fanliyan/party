<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<#include "/function.ftl"> 
<@master.masterFrame pageTitle=["消息列表"]>
	<div class="panel panel-default table-responsive">
		<table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
			<thead>
				<tr>
					<th>标题</th>
					<th>状态</th>
					<th>时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<#if listResponse.messages ?? && listResponse.messages?size gt 0>
					<#list listResponse.messages as message>
						<tr>
							<td>${message.title!}</td>
							<td>
								<#if message.isRead>
									<span class="label label-default">已读</span>
								<#else>
									<span class="label label-success">未读</span>
								</#if>
							</td>
							<td>${message.createTime?string('yyyy-MM-dd HH:mm')}</td>
							<td>
								<a class="btn btn-xs btn-warning" href="${basePath}/message/msgInfo?messageId=${message.messageId}"><i class="fa fa-info-circle fa-lg"></i> 查看</a>
							</td>
						</tr>
					</#list>
				<#else>
					<tr><td colspan=5 class="text-center">没有数据</td></tr>
				</#if>
			</tbody>
		</table>
		<#if listResponse.messages ?? && listResponse.messages?size gt 0>
		<@splitPage1.splitPage pageCount=listResponse.splitPage.pageCount pageNo=listResponse.splitPage.pageNo formId="searchForm" recordCount=listResponse.splitPage.recordCount />
		</#if>
		<form id="searchForm" action="${basePath}/main/msgList" method="post">
		</form>
	</div><!-- /panel -->
</@master.masterFrame>