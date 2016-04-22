<#macro mainMenu>
<div class="main-menu">
	<ul>	
		<#list loginModuleGroupList as moduleGroupModel>
			<li class="openable moduleGroupMenu${moduleGroupModel.id}">
					<a href="#">
					<span class="menu-icon">
						<i class="fa <#if moduleGroupModel.icon?? && moduleGroupModel.icon!="">${moduleGroupModel.icon}<#else>fa-file-text</#if> fa-lg"></i> 
					</span>
					<span class="text">
					${moduleGroupModel.groupName}
					</span>
					<span class="menu-hover"></span>
				</a>
				<ul class="submenu">
					<#list moduleGroupModel.moduleModelList as module>
						<li class="moduleMenu${module.moduleId}"><a href="${basePath}${module.entryUrl}" class="moduleMenu" moduleId="${module.moduleId}" moduleGroupId="${moduleGroupModel.id}"><span class="submenu-label">${module.name}</span></a></li>
					</#list>
				</ul>
			</li>
		</#list>
	</ul>
	
	<div class="alert alert-info">
		欢迎使用 计算机党校 云平台，有任何建议和意见请 <a href="mailto:.com">点击</a>.
	</div>
</div><!-- /main-menu -->
</#macro>