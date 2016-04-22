<#import "/master/master-blank.ftl" as master />
<@master.masterBlank bodyClass="">

<div class="login-wrapper">
	<div class="text-center">
		<h2 class="fadeInUp animation-delay8" style="font-weight:bold">
			<span class="text-success">移民帮</span> <span style="color:#ccc; text-shadow:0 1px #fff">管理平台</span>
		</h2>
	</div>
	<div class="login-widget animation-delay1">	
		<div class="panel panel-default">
			<div class="panel-heading clearfix">
				<div class="pull-left">
					<i class="fa fa-lock fa-lg"></i> 注册
				</div>
			</div>
			<div class="panel-body">
				<form class="form-login" id="loginForm">
					<div class="form-group">
						<label>用户名</label>
						<input type="text" placeholder="请输入用户名" name="userId" class="form-control input-sm bounceIn animation-delay2 parsley-validated"
						 data-parsley-required="true"
						 data-parsley-required-message="用户名不可为空"
						
						/>
					</div>
					<div class="form-group">
						<label>密码</label>
						<input type="password" placeholder="请输入密码" name="password" id="password" class="form-control input-sm bounceIn animation-delay4 parsley-validated"
						 data-parsley-required="true"
						 data-parsley-trigger="focusout"
						 data-parsley-required-message="密码不可为空"
						 data-parsley-minlength="6"
						 data-parsley-minlength-message="密码位数不可少于6位"
						/>
					</div>
					<div class="form-group">
						<label>确认密码</label>
						<input type="password" placeholder="请再次输入密码" class="form-control input-sm bounceIn animation-delay4 parsley-validated"
						 data-parsley-required="true"
						 data-parsley-trigger="focusout"
						 data-parsley-required-message="确认密码不可为空"
						 data-parsley-equalto="#password"
						 data-parsley-equalto-message="两次密码输入不一致"
						 />
					</div>
					<div class="form-group">
						<label>姓名</label>
						<input type="text" placeholder="请输入姓名" data-parsley-required="true" class="form-control input-sm bounceIn animation-delay4 parsley-validated" name="password"/>
					</div>
					<div class="form-group">
						<label>手机号码</label>
						<input type="text" placeholder="请输入手机号码" data-parsley-required="true" class="form-control input-sm bounceIn animation-delay4 parsley-validated" name="password"/>
					</div>
					<div class="seperator"></div>
					<div class="form-group">
						已经拥有账号?
						<a href="#"> 登录</a>
					</div>

					<hr/>
					<a class="btn btn-success btn-sm bounceIn animation-delay5 pull-right" href="###" id="submitButton"><i class="fa fa-sign-in"></i> 注册</a>
				</form>				
			</div>
		</div><!-- /panel -->
	</div><!-- /login-widget -->
</div><!-- /login-wrapper -->

<script language="javascript">
$("#submitButton").click(function(){
	if($('#loginForm').parsley().validate()){
		$.ajax({
        cache: true,
        type: "POST",
        url:"${basePath}/main/checklogin",
        data:$('#loginForm').serialize(),
        async: false,
        error: function(request) {
            alertify.alert("错误：服务器异常！");
        },
        success: function(data) {
        	if(data.success){  
	        	<#if backurl??>
					location.href="${backurl!}";
	        	<#else>
	        		location.href="${basePath}/main/index";
				</#if>
			}
			else{
            	alertify.alert("错误:" + data.message);
			}
        }
    });
	}
});
</script>
</@master.masterBlank>