<#macro topNav>
<div id="top-nav" class="skin-6 fixed">
	<div class="brand">
		<img src="${basePath}/resources/img/logo.png" class="logo"/>
	</div><!-- /brand -->
	<button type="button" class="navbar-toggle pull-left" id="sidebarToggle">
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
	</button>
	<button type="button" class="navbar-toggle pull-left hide-menu" id="menuToggle">
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
	</button>
	<ul class="nav-notification clearfix">
		<li class="dropdown">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">
				<i class="fa fa-bell fa-lg"></i>
				<span class="notification-label bounceIn animation-delay6" id="msgCount" style="display:none"></span>
			</a>
			<ul class="dropdown-menu notification dropdown-3" id="msgList">
				
			</ul>
		</li>
		<li class="profile dropdown">
			<a class="dropdown-toggle" data-toggle="dropdown" href="${basePath}/resources/#">
				<strong>${loginUserModel.userName!"未设置姓名"}</strong>
				<span><i class="fa fa-chevron-down"></i></span>
			</a>
			<ul class="dropdown-menu">
				<li>
					<a class="clearfix" href="#">
						<img id="tpHead" src="<#if loginUserModel.avatarPic?? && loginUserModel.avatarPic != "" && loginUserModel.avatarPic?index_of("http") == 0>${loginUserModel.avatarPic}@50h_50w_1e_1c<#else>${defaultAvatar}</#if>" alt="User Avatar">
						<div class="detail">
							<strong>${loginUserModel.userName!"未设置姓名"}</strong>
							<p class="grey">${loginUserModel.email!}</p>
						</div>
					</a>
				</li>
				<li><a tabindex="-1" href="${basePath}/main/changepwd" class="main-link"><i class="fa fa-edit fa-lg"></i> 更改密码</a></li>
				<li><a tabindex="-1" href="${basePath}/main/profile" class="theme-setting"><i class="fa fa-cog fa-lg"></i> 个人设置</a></li>
				<li class="divider"></li>
				<li><a tabindex="-1" class="main-link logoutConfirm_open" href="${basePath}/main/logout"><i class="fa fa-lock fa-lg"></i> 退出</a></li>
			</ul>
		</li>
	</ul>
</div><!-- /top-nav-->
<script language="javascript">
	$(document).ready(function(){
		getMessage();
	});
	function getMessage(){
		try {
			var basePath='${basePath}';
			$.ajax({
				cache: true,
				type: "POST",
				url:"${basePath}/message/notification",
				//data:"customerId=" + customerId,
				async: false,
				dataType: 'JSON',
				error: function(request) {
				},
				success: function(data) {
					$("#msgList").html("");
					if(data.msgCount > 0){
						$("#msgCount").text(data.msgCount);
						$("#msgCount").show();
						$("#msgList").append("<li><a href='#'>您有"+data.msgCount+"条未读消息</a></li>");

						for(var i=0;i<data.msgList.length;i++){
							var msg=data.msgList[i];
							var html="<li><a href='"+basePath+"/message/msgInfo?messageId="+msg.messageId+"'>";
							if(msg.mstType==2||msg.msgType==4){
								html+="<span class='notification-icon bg-success'><i class='fa fa-plus'></i></span>";
							}else{
								html+="<span class='notification-icon bg-warning'><i class='fa fa-warning'></i></span>";
							}
							html+="<span class='m-left-xs'>"+msg.title+"</span></a></li>";
							$("#msgList").append(html);
						}
					}else{
						$("#msgList").append("<li><a href='#'>您暂时没有未读消息</a></li>");
						$("#msgCount").hide();
					}
					$("#msgList").append("<li><a href='${basePath}/message/list'>查看全部消息</a></li>");
				}
			});
		} catch (e) {
		}
		setTimeout('getMessage();',60000);
	}
</script>
</#macro>