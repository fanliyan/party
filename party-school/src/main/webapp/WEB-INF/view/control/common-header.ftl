<#macro mainMenu>
<div class="main-menu">
    <ul>
        <#list loginModuleGroupList as moduleGroupModel>
            <li class="openable moduleGroupMenu${moduleGroupModel.moduleGroupId}">
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
                    <#list moduleGroupModel.modulesModels as module>
                        <li class="moduleMenu${module.moduleId}"><a href="${basePath}${module.entryUrl}" class="moduleMenu" moduleId="${module.moduleId}" moduleGroupId="${moduleGroupModel.moduleGroupId}"><span class="submenu-label">${module.moduleName}</span></a></li>
                    </#list>
                </ul>
            </li>
        </#list>
    </ul>

    <div class="alert alert-info">
        欢迎使用 移民帮 云平台，有任何建议和意见请 <a href="mailto:liwei@htke.com">点击</a>.
    </div>
</div><!-- /main-menu -->
</#macro>