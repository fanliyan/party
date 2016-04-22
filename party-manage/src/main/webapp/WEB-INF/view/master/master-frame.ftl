
<#import  "/master/master-blank.ftl" as masterBlank>
<#import  "/control/common-top-nav.ftl" as topNav>
<#import  "/control/common-left-userinfo.ftl" as userInfo>
<#import  "/control/common-left-mainmenu.ftl" as mainMenu>

<#macro masterFrame showNotice=false pageTitle=[]>
<@masterBlank.masterBlank>
<!-- Overlay Div -->
	<div id="overlay" class="transparent" style="display:none"></div>

	<a href="${basePath}/resources/#" id="theme-setting-icon"><i class="fa fa-cog fa-lg"></i></a>
	<div id="theme-setting">
		<div class="title">
			<strong class="no-margin">Skin Color</strong>
		</div>
		<div class="theme-box">
			<a class="theme-color" style="background:#323447" id="default"></a>
			<a class="theme-color" style="background:#efefef" id="skin-1"></a>
			<a class="theme-color" style="background:#a93922" id="skin-2"></a>
			<a class="theme-color" style="background:#3e6b96" id="skin-3"></a>
			<a class="theme-color" style="background:#635247" id="skin-4"></a>
			<a class="theme-color" style="background:#3a3a3a" id="skin-5"></a>
			<a class="theme-color" style="background:#495B6C" id="skin-6"></a>
		</div>
		<div class="title">
			<strong class="no-margin">Sidebar Menu</strong>
		</div>
		<div class="theme-box">
			<label class="label-checkbox">
				<input type="checkbox" checked id="fixedSidebar">
				<span class="custom-checkbox"></span>
				Fixed Sidebar
			</label>
		</div>
	</div><!-- /theme-setting -->
	
	<div id="wrapper" class="preload">
		<@topNav.topNav />
		
		<aside class="fixed skin-6">	
			<div class="sidebar-inner scrollable-sidebar">
				<div class="size-toggle">
					<a class="btn btn-sm" id="sizeToggle">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</a>
					<a class="btn btn-sm pull-right logoutConfirm_open logout"  href="#">
						<i class="fa fa-power-off"></i>
					</a>
				</div><!-- /size-toggle -->	
				<@userInfo.userInfo userModel="null"/>

				<@mainMenu.mainMenu />
			</div><!-- /sidebar-inner -->
		</aside>

		<div id="main-container">
			<#if pageTitle?exists && pageTitle?size gt 0>
			<div id="breadcrumb">
				<ul class="breadcrumb">
					 <li><i class="fa fa-home"></i><a href="${basePath}/main/index"> 首页</a></li>
					 <#list pageTitle as title>
						<li <#if !title_has_next>class="active"</#if>>${title}</li>
					 </#list>
				</ul>
			</div><!--readcrumb-->
			</#if>
			
			<#if showNotice>
			<div class="alert-animated">
				<div class="alert-inner">
					<div class="alert-message">
						重要的公告将显示在此处
					</div>
				</div>
			</div><!-- /alert-animated -->
			</#if>

			<div class="padding-md">
			<#nested>
			</div>
		</div><!-- /main-container -->
	</div><!-- /wrapper -->

	<a href="${basePath}/resources/#" id="scroll-to-top" class="hidden-print"><i class="fa fa-chevron-up"></i></a>
	
	<!-- Logout confirmation -->
	<div class="custom-popup width-100" id="logoutConfirm">
		<div class="padding-md">
			<h4 class="m-top-none"> 确认要退出 云平台 ?</h4>
		</div>

		<div class="text-center">
			<a class="btn btn-success m-right-sm" href="${basePath}/main/logout">退出</a>
			<a class="btn btn-danger logoutConfirm_close">取消</a>
		</div>
	</div>
</@masterBlank.masterBlank>
</#macro>

	