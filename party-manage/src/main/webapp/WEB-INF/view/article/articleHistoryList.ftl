<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["文章管理","文章历史","文章历史列表"]>

	<div class="panel panel-default table-responsive">
        <form id="searchForm" class="form-inline no-margin" action="${basePath}/articleHistory/list" method="post">
            <input type="hidden" name="articleId" value="${articleId}" />
            </form>

        <div class="panel-body">
            <div class="panel-body pull-right">
                <a class="btn btn-xs btn-default" href="${basePath}/article/list" ><i class="fa fa-reply fa-lg"></i> 返回</a>
            </div>
        </div>

		<div class="padding-md clearfix">
			<table class="table table-condensed table-hover table-striped" id="dataTable">
				<thead>
					<tr>
						<th>文章历史ID</th>
						<th>操作用户</th>
                        <th>操作类型</th>
                        <th>描述</th>
						<th>创建时间</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<#if response.articleModifyLogList?? && response.articleModifyLogList?size gt 0>
						<#list response.articleModifyLogList as articleModifyLog>
							<tr>
								<td>${articleModifyLog.id!}</td>
								<td>${(articleModifyLog.userModel.name)!}</td>
                                <td><#if articleModifyLog.modifyType==0>
                                        修改内容
                                    <#elseif articleModifyLog.modifyType==1>
                                        修改文章状态
                                    <#elseif articleModifyLog.modifyType==2>
                                        修改发布时间
                                    <#elseif articleModifyLog.modifyType==3>
                                        添加文章
                                </#if></td>
                                <td>${articleModifyLog.description!}</td>
								<td>${articleModifyLog.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
								<td>
									<a class="btn btn-xs btn-success" target="_blank" href="${basePath}/articleHistory/preview?articleLogId=${articleModifyLog.id}">
                                        <i class="fa fa fa-search"></i> 预览历史</a>
								</td>
							</tr>
						</#list>
					<#else>
						<tr><td colspan=6 class="text-center">没有数据</td></tr>
					</#if>
				</tbody>
			</table>
            <#if response.articleModifyLogList?? && response.articleModifyLogList?size gt 0>
                <@splitPage1.splitPage pageCount=(response.splitPage.pageCount)!1 pageNo=(response.splitPage.pageNo)!1 formId="searchForm" recordCount=(response.splitPage.recordCount)!0 />
            </#if>
		</div><!-- /.padding-md -->
	</div><!-- /panel -->
	
</@master.masterFrame>