<#macro userInfo userModel>
<div class="user-block clearfix">
	<img id="lftHead" src="<#if loginUserModel.avatarPic?? && loginUserModel.avatarPic != "" && loginUserModel.avatarPic?index_of("http") == 0>${loginUserModel.avatarPic}@50h_50w_1e_1c<#else>${defaultAvatar}</#if>" alt="用户头像">
	<div class="detail">
		<strong>${loginUserModel.userName!"未设置姓名"}</strong><!--<span class="badge badge-danger bounceIn animation-delay4 m-left-xs">0</span>-->
		<ul class="list-inline">
			<li><a href="${basePath}/main/profile">设置个人信息</a></li>
			<!--<li><a href="${basePath}/resources/inbox.html" class="no-margin">Inbox</a></li>-->
		</ul>
	</div>
</div><!-- /user-block -->
</#macro>