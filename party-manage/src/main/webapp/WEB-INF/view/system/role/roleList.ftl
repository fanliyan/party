<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["系统管理","角色管理","角色列表"]>
	<div class="panel-body">
		<a class="btn btn-xs btn-info" href="${basePath}/role/add"><i class="fa fa-plus fa-lg"></i> 新增角色</a>
		<a class="btn btn-xs btn-info" href="${basePath}/role/roleModule"><i class="fa fa-info fa-lg"></i> 查看角色对应权限</a>
	</div>
	<div class="panel panel-default table-responsive">
		<div class="panel-heading">
			所有角色
			<span class="label label-info pull-right">目前共有 ${rolesModelList?size} 个角色</span>
		</div>
		<table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
			<thead>
				<tr>
					<th>角色名称</th>
					<th>创建时间</th>
					<th>最后修改时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<#list rolesModelList as rolesModel>
				<tr>
					<td>${rolesModel.name}</td>
					<td>${rolesModel.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
					<td>${rolesModel.lastModifyTime?string('yyyy-MM-dd HH:mm:ss')}</td>		
					<td>
						<a class="btn btn-xs btn-success" href="${basePath}/role/edit?roleId=${rolesModel.roleId}"><i class="fa fa-wrench fa-lg"></i> 编辑</a>
						<#if !(rolesModel.isBuiltin)>
						<a class="btn btn-xs btn-danger" href="javascript:void(0);" onclick="$.delRole(${rolesModel.roleId});"><i class="fa fa-trash-o fa-lg"></i> 删除</a>
						</#if>
					</td>
				</tr>
				</#list>
			</tbody>
		</table>
	</div><!-- /panel -->
	<script language="javascript">
	$.delRole = function(roleId){
		alertify.confirm("注意，角色一经删除，无法恢复！是否继续？", function (e) {
			if (e) {
				$.ajax({
			        cache: true,
			        type: "POST",
			        url:"${basePath}/role/del",
			        data:"roleId=" + roleId,// 你的formid
			        async: false,
			        error: function(request) {
			            alertify.alert("错误：服务器异常！");
			        },
			        success: function(data) {
			        	if(data.success){   
			            	location.href="${basePath}/role/list";
			        }   
			        else{   
		            	alertify.alert("错误:" + data.message);
			        }   
		        }
    		});
		}
	});
};
</script>
</@master.masterFrame>