<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["标签管理","标签","标签列表"]>

	<div class="panel panel-default table-responsive">

        <div class="panel-heading">条件搜索</div>
        <div class="panel-body">
            <form id="searchForm" class="form-inline no-margin" action="${basePath}/tag/list" method="post">
                <div class="form-group" style="margin-right:10px;">
                    <label class="control-label">标签名称</label>
                    <div>
                        <input name="keywords" type="text" class="form-control input-sm" value="<#if keywords??>${keywords!}</#if>"/>
                    </div>
                </div>
                <!-- /form-group -->

                <div class="form-group">
                    <label class="control-label">标签类别</label>
                    <select name="tagTypeId" id="tagTypeId" class="form-control chzn-select"
                            data-placeholder="请选择标签类别">
                        <option value="">请选择标签类别</option>
                        <#if tagTypeList ?? >
                            <#list tagTypeList as tagType >
                                <#if tagTypeId?? && tagType.tagTypeId?? && tagType.tagTypeId==tagTypeId>
                                    <option value="${tagType.tagTypeId}" selected>${tagType.tagTypeName}</option>
                                <#else>
                                    <option value="${tagType.tagTypeId}">${tagType.tagTypeName}</option>
                                </#if>
                            </#list>
                        </#if>
                    </select>
                </div>
                <!-- /form-group -->

                <div class="form-group" style="margin-right:10px;">
                    <label class="control-label">状态</label>
                    <div>
                        <select class="form-control chzn-select" id="status" name="status" data-placeholder="选择状态">
                            <option value="">请选择</option>
                            <option value="1" <#if status??&&status==1>selected</#if>>正常</option>
                            <option value="0" <#if status??&&status==0>selected</#if>>已删除</option>
                        </select>
                    </div>
                </div><!-- /form-group -->


                <button type="submit" class="btn btn-sm btn-success"><i class="fa fa-search" style="font-size:16px;"></i></button>
            </form>
            <div class="panel-body pull-right">
                <#if editPermission??&&editPermission>
                    <a class="btn btn-xs btn-info" href="${basePath}/tag/add" ><i class="fa fa-plus fa-lg"></i> 新增</a>
                </#if>
            </div>
        </div>
		<div class="padding-md clearfix">
			<table class="table table-condensed table-hover table-striped" id="dataTable">
				<thead>
					<tr>
						<th>标签ID</th>
						<th>标签名称</th>
                        <th>标签类别</th>
                        <th>状态</th>
                        <th>创建人</th>
						<th>创建时间</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<#if response.tags?? && response.tags?size gt 0>
						<#list response.tags as tag>
							<tr>
								<td>${tag.tagId!}</td>
								<td>${tag.tagName!}</td>
                                <td><#if tag.tagType??>${tag.tagType.tagTypeName!}</#if></td>
                                <td>
                                    <#if tag.status??&&tag.status==1>
                                        <span class="label label-xs label-success">正常</span>
                                    <#else>
                                        <span class="label label-xs label-warning">已停用</span>
                                    </#if>
                                </td>
                                <td><#if tag.userModel??>${tag.userModel.username!}</#if></td>

								<td>${tag.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
								<td>
                                    <#if tag.status??&&tag.status==1>
                                        <a class="btn btn-xs btn-warning" href="javascript:$.changeStatus(${tag.tagId},0);"><i class="fa  fa-check  fa-lg"></i> 停用</a>
                                    <#else>
                                        <a class="btn btn-xs btn-success" href="javascript:$.changeStatus(${tag.tagId},1);"><i class="fa  fa-times  fa-lg"></i> 启用</a>
                                    </#if>
                                    <#if editPermission??&&editPermission>
                                        <a class="btn btn-xs btn-success" href="${basePath}/tag/edit?tagId=${tag.tagId}"><i class="fa  fa-edit  fa-lg"></i> 编辑</a>
                                    </#if>
								</td>
							</tr>
						</#list>
					<#else>
						<tr><td colspan=7 class="text-center">没有数据</td></tr>
					</#if>
				</tbody>
			</table>
            <#if response.tags?? && response.tags?size gt 0>
                <@splitPage1.splitPage pageCount=(response.splitPage.pageCount)!1 pageNo=(response.splitPage.pageNo)!1 formId="searchForm" recordCount=(response.splitPage.recordCount)!0 />
            </#if>
		</div><!-- /.padding-md -->
	</div><!-- /panel -->
	
	<script language="javascript">
        $.changeStatus = function(id,status) {
            alertify.confirm(status>0?"是否启用?":"是否停用?", function (e) {
                if (e) {
                    $.ajax({
                        cache: true,
                        type: "POST",
                        url: "${basePath}/tag/changeStatus",
                        data: {"tagId" : id,"status":status},
                        async: false,
                        error: function (request) {
                            alertify.alert("错误：服务器异常！");
                        },
                        success: function (data) {
                            if (data.success) {
                                location.reload();
                            }
                            else {
                                alertify.alert("错误:" + data.message);
                            }
                        }
                    });
                }
            });
        }
	</script>
</@master.masterFrame>