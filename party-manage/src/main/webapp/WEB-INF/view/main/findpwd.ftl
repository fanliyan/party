<#import "/master/master-blank.ftl" as master />
<@master.masterBlank bodyClass="">

<div class="login-wrapper">
	<div class="login-widget animation-delay1">	
		<div class="panel panel-default">
			<div class="panel-heading clearfix">
				<div class="pull-left">
					<i class="fa fa-lock fa-lg"></i> 密码找回
				</div>
			</div>
			<div class="panel-body">
				<form class="form-login" id="loginForm" action="${basePath}/main/findpwd" method="post">
					<div class="form-group">
						<label>新密码</label>
						<div>
							<input type="password" class="form-control input-sm parsley-validated" data-parsley-required="true" data-parsley-required-message="请输入密码" data-parsley-length="[6,20]" data-parsley-length-message="必须在6-20位之间" placeholder="6-20位之间" name="password" id="password">
							<input type="hidden" name="accountId" value="${accountId!}"/>
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label>确认新密码</label>
						<div>
							<input type="password" class="form-control input-sm parsley-validated" data-parsley-required="true" data-parsley-required-message="请再次输入密码" data-parsley-equalto="#password" data-parsley-equalto-message="两次密码输入不一致" data-parsley-length="[6,20]" data-parsley-length-message="6-20位之间" placeholder="请再次输入一次密码" name="password2">
						</div><!-- /.col -->
					</div><!-- /form-group -->

					<hr/>
					<a class="btn btn-success btn-sm bounceIn animation-delay5 pull-right" href="###" id="submitButton"><i class="fa fa-sign-in"></i> 提交</a>
				</form>				
			</div>
		</div><!-- /panel -->
	</div><!-- /login-widget -->
</div><!-- /login-wrapper -->

<script language="javascript">
$("#submitButton").click(function(){
	if($('#loginForm').parsley().validate()){
		$('#loginForm').submit();
	}
});

</script>
</@master.masterBlank>