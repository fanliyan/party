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
				<form class="form-login" id="loginForm" action="${basePath}/main/checkVerifyCode" method="post">
					<div class="form-group">
						<label>手机/邮箱号码</label>
						<input type="text" placeholder="请输入手机/邮箱号码" name="accountId" id="accountId" class="form-control input-sm bounceIn animation-delay2 parsley-validated"
						 data-parsley-required="true"
						 data-parsley-required-message="手机/邮箱号码不可为空"
						 value="${accountId!}"
						/>
					</div>
					<div class="form-group">
						<label>验证码</label>
						
						<div class="input-group">
							<input type="text" placeholder="请输入验证码" name="verifyCode" id="yzm" class="form-control input-sm bounceIn animation-delay4 parsley-validated"
							 data-parsley-required="true"
							 data-parsley-trigger="focusout"
							 data-parsley-required-message="验证码不可为空"
							 data-parsley-errors-container="#nameError"
							/>
							<div class="input-group-btn">
								<button type="button" class="btn btn-sm btn-warning" tabindex="-1" id="yzmBtn">获取验证码</button>
							</div> <!-- /input-group-btn -->
						</div>
						<ul class="parsley-errors-list filled" id="nameError"><li class="parsley-required"></li></ul>
					</div>

					<hr/>
					<a class="btn btn-success btn-sm bounceIn animation-delay5 pull-right" href="###" id="submitButton"><i class="fa fa-sign-in"></i> 提交</a>
				</form>				
			</div>
		</div><!-- /panel -->
	</div><!-- /login-widget -->
</div><!-- /login-wrapper -->

<script language="javascript">
$("#yzmBtn").click(function(){
	if($('#accountId').parsley().validate()){
		$.ajax({
        cache: true,
        type: "POST",
        url:"${basePath}/main/sendCode",
        data:"accountId="+$("#accountId").val(),
        async: false,
        error: function(request) {
            alertify.alert("错误：服务器异常！");
        },
        success: function(data) {
        	if(data.success){  
	        	notification();
			}
			else{
            	alertify.alert("错误:" + data.message);
			}
        }
    });
	}
});
$("#submitButton").click(function(){
	if($('#loginForm').parsley().validate()){
		$('#loginForm').submit();
	}
});

function notification(){
	$.gritter.add({
		title: '<i class="fa fa-check-circle"></i>提示',
		text: '验证码发送成功，有效期5分钟',
		sticky: false,
		time: '3000',
		class_name: 'gritter-success',
		position: 'bottom-left'
	});
	return false;
}
$(document).ready(function(){
	<#if msg??>
	$.gritter.add({
		title: '<i class="fa fa-check-circle"></i>提示',
		text: '${msg}',
		sticky: false,
		time: '3000',
		class_name: 'gritter-success',
		position: 'bottom-left'
	});
	</#if>
})
</script>
</@master.masterBlank>