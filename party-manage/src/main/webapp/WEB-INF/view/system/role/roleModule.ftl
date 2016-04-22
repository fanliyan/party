<#import "/master/master-frame.ftl" as master />
	<#assign title=["系统管理","角色管理","角色权限对照表"]>
<@master.masterFrame pageTitle=title>
<div class="panel panel-default">
	<div class="panel-body">
		<table class="table table-bordered table-condensed table-hover table-striped" id="dataTable">
			<thead>
				<tr class="bg-theme">
					<th rowspan="2">模块组</th>
					<th rowspan="2">模块名称</th>
					<th rowspan="2">细分权限</th>
					<th rowspan="2">说明</th>
					<th colspan="${rolesList?size}">岗位名称</th>
				</tr>
				<tr class="bg-theme">
					<#list rolesList as role>
						<th>${role.name}</th>
					</#list>
				</tr>
			</thead>
			<tbody>
				<#list allModuleGroupList as moduleGroup>
					<#assign rowCount=0>
					<#--<#if moduleGroup.moduleModelList??>-->
						<#--<#assign rowCount=moduleGroup.moduleModelList?size>-->
						<#--<#list moduleGroup.moduleModelList as module>-->
							<#--<#if module.permissionModels??>-->
								<#--<#list module.permissionModels as permissionModel>-->
									<#--<#assign rowCount=rowCount+1>-->
								<#--</#list>-->
							<#--</#if>-->
						<#--</#list>-->
					<#--</#if>-->
					<#--<#if rowCount==1><!--模块组中只有一个子模块并且子模块无特殊权限&ndash;&gt;-->
						<#--<tr>-->
							<#--<td>${moduleGroup.groupName}</td>-->
							<#--<#list moduleGroup.modulesModels as module>-->
								<#--<td>${module.moduleName}</td>-->
								<#--<td>默认权限</td>-->
								<#--<td>${(module.moduleDesc)!}</td>-->
								<#--<#list rolesList as role>-->
									<#--<td align="center">-->
										<#--<#if role.modulesModels??>-->
											<#--<#list role.modulesModels as roleModule>-->
												<#--<#if roleModule.moduleId==module.moduleId>-->
													<#--<div data-toggle="tooltip" data-placement="top" title="" data-original-title="${role.roleName}">√</div>-->
												<#--</#if>-->
											<#--</#list>-->
										<#--</#if>-->
									<#--</td>-->
								<#--</#list>-->
							<#--</#list>-->
						<#--</tr>-->
					<#--<#elseif rowCount gt 1><!--模块组有多个模块&ndash;&gt;-->
						<#--<#assign flag=0>-->
						<#list moduleGroup.moduleModelList as module>
							<#--<#assign prowCount=0>-->
							<#--<#if module.permissionModels??>-->
								<#--<#assign prowCount=module.permissionModels?size+1>-->
							<#--</#if>-->
							<#--<#if prowCount gt 0><!--模块中有特殊权限&ndash;&gt;-->
								<#--<tr>-->
									<#--<#if flag==0>-->
									<#--<td rowspan="${rowCount}">${moduleGroup.groupName}</td>-->
									<#--</#if>-->
									<#--<td rowspan="${prowCount}">${module.moduleName}</td>-->
									<#--<td>默认权限</td>-->
									<#--<td>${(module.moduleDesc)!}</td>-->
									<#--<#list rolesList as role>-->
										<#--<td align="center">-->
											<#--<#if role.modulesModels??>-->
												<#--<#list role.modulesModels as roleModule>-->
													<#--<#if roleModule.moduleId==module.moduleId>-->
														<#--<div data-toggle="tooltip" data-placement="top" data-original-title="${role.roleName}">√</div>-->
													<#--</#if>-->
												<#--</#list>-->
											<#--</#if>-->
										<#--</td>-->
									<#--</#list>-->
								<#--</tr>-->
								<#--<#list module.permissionModels as permissionModel>-->
									<#--<tr>-->
										<#--<td>${permissionModel.permissionName}</td>-->
										<#--<td>${permissionModel.permissionDesc!}</td>-->
										<#--<#list rolesList as role>-->
											<#--<td align="center">-->
												<#--<#if role.permissionIds?? && role.permissionIds?contains(permissionModel.permissionId+"")>-->
													<#--<div data-toggle="tooltip" data-placement="top" data-original-title="${role.roleName}">√</div>-->
												<#--</#if>-->
											<#--</td>-->
										<#--</#list>-->
									<#--</tr>-->
									<#--<#assign flag=flag+1>-->
								<#--</#list>-->
							<#--<#else><!--模块中无特殊权限&ndash;&gt;-->
								<tr>
									<#--<#if flag==0>-->
									<td rowspan="${rowCount}">${moduleGroup.groupName}</td>
									<#--</#if>-->
									<td>${module.name}</td>
									<td>默认权限</td>
									<td>${(module.description)!}</td>
									<#list rolesList as role>
										<td align="center">
											<#if role.moduleModelList??>
												<#list role.moduleModelList as roleModule>
													<#if roleModule.moduleId==module.moduleId>
														<div data-toggle="tooltip" data-placement="top" data-original-title="${role.name}">√</div>
													</#if>
												</#list>
											</#if>
										</td>
									</#list>
								</tr>
							<#--</#if>-->
							<#--<#assign flag=flag+1>-->
						</#list>
					<#--</#if>-->
				</#list>
			</tbody>
		</table>
				
		<div class="panel-footer text-center">
			<button type="button" class="btn btn-default" onclick="javascript:history.go(-1);">返回</button>
		</div>
	</div>
</div><!-- /panel -->
<#function checked moduelId>
	<#if roleModel??>
		<#list roleModel.modulesModels as m>
			<#if m.moduleId == moduelId>
				<#return "checked='checked'">
			</#if>
		</#list>
	</#if>
	<#return "">   
</#function>

<#function checked1 permissionId>
	<#if roleModel??>
		<#list roleModel.modulesModels as m>
			<#if m.permissionIdList ?? && m.permissionIdList?contains(permissionId+"")>
				<#return "checked='checked'">
			</#if>
		</#list>
	</#if>
	<#return "">   
</#function>
</@master.masterFrame>