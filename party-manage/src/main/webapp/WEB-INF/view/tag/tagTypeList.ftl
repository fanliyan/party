<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["标签管理","标签类型","标签类型列表"]>

	<div class="panel panel-default table-responsive">

        <div class="panel-heading">条件搜索</div>
        <div class="panel-body">
            <form id="searchForm" class="form-inline no-margin" action="${basePath}/tagType/list" method="post">
                <div class="form-group" style="margin-right:10px;">
                    <label class="control-label">标签类别名称</label>
                    <div>
                        <input name="name" type="text" class="form-control input-sm" value="<#if name??>${name!}</#if>"/>
                    </div>
                </div>

                <button type="submit" class="btn btn-sm btn-success"><i class="fa fa-search" style="font-size:16px;"></i></button>
            </form>
            <div class="panel-body pull-right">
                <a class="btn btn-xs btn-info" href="${basePath}/tagType/add" ><i class="fa fa-plus fa-lg"></i> 新增</a>
            </div>
        </div>
		<div class="padding-md clearfix">
			<table class="table table-condensed table-hover table-striped" id="dataTable">
				<thead>
					<tr>
						<th>标签类别ID</th>
						<th>标签类别名称</th>
                        <th>创建时间</th>
						<th>修改时间</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<#if response.tagTypeModelList?? && response.tagTypeModelList?size gt 0>
						<#list response.tagTypeModelList as tagType>
							<tr>
								<td>${tagType.tagTypeId!}</td>
								<td>${tagType.tagTypeName!}</td>
								<td>${tagType.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                                <td><#if tagType.lastModifyTime??>${tagType.lastModifyTime?string('yyyy-MM-dd HH:mm:ss')}</#if></td>
                                <td>
	                                <a class="btn btn-xs btn-success" href="${basePath}/tagType/edit?typeId=${tagType.tagTypeId}"><i class="fa  fa-edit  fa-lg"></i> 修改</a>
								</td>
							</tr>
						</#list>
					<#else>
						<tr><td colspan=5 class="text-center">没有数据</td></tr>
					</#if>
				</tbody>
			</table>
            <#if response.tagTypeModelList?? && response.tagTypeModelList?size gt 0>
                <@splitPage1.splitPage pageCount=(response.splitPage.pageCount)!1 pageNo=(response.splitPage.pageNo)!1 formId="searchForm" recordCount=(response.splitPage.recordCount)!0 />
            </#if>
		</div><!-- /.padding-md -->
	</div><!-- /panel -->
	
	<script language="javascript">
        $.del = function(id) {
            alertify.confirm("注意，一经删除，无法恢复！是否继续？", function (e) {
                if (e) {
                    $.ajax({
                        cache: true,
                        type: "POST",
                        url: "${basePath}/tagType/del",
                        data: "tagTypeId=" + id,
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