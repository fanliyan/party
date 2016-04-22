<#import "/master/master-blank.ftl" as master />
<@master.masterBlank bodyClass="">

<div class="login-wrapper">
	<div class="text-center">
		<h2 class="fadeInUp animation-delay8" style="font-weight:bold">
			<span class="text-success">计算机党校</span> <span style="color:#ccc; text-shadow:0 1px #fff">云平台</span>
		</h2>
	</div>
	<div class="login-widget animation-delay1">	
		<div class="panel panel-default">
			<div class="panel-heading clearfix">
				<div class="pull-left">
					<i class="fa fa-lock fa-lg"></i> 登录
				</div>
				<!--<div class="pull-right">
					<span style="font-size:11px;">没有账号?</span>
					<a class="btn btn-default btn-xs login-link" href="${basePath}/main/register" style="margin-top:-2px;"><i class="fa fa-plus-circle"></i> 注册</a>
				</div>-->
			</div>
			<div class="panel-body">
				<form class="form-login" id="loginForm">
					<div class="form-group">
						<label>用户名</label>
						<input type="text" placeholder="请输入用户名" data-parsley-required="true" class="form-control input-sm bounceIn animation-delay2 parsley-validated" id="userId" name="userId" value="${userId!}">
					</div>
					<div class="form-group">
						<label>密码</label>
						<input type="password" placeholder="请输入密码" data-parsley-required="true" class="form-control input-sm bounceIn animation-delay4 parsley-validated" id="password" name="password">
					</div>
					<div class="form-group">
						<label class="label-checkbox inline">
							<input type="checkbox" name="rememberUserid" data-parsley-ui-enabled="false" <#if userId??>checked="checked"</#if>/>
							<span class="custom-checkbox info bounceIn animation-delay4"></span>
						</label>
						记住我的用户名	
					</div>
	
					<div class="seperator"></div>
					<div class="form-group">
						忘记了密码?
						<a href="${basePath}/main/tofindpwd">点击找回</a>
					</div>

					<hr/>
					<a class="btn btn-success btn-sm bounceIn animation-delay5 pull-right" href="###" id="submitButton"><i class="fa fa-sign-in"></i> 登 录</a>
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

$(document).ready(function(){
	if($('#userId').val()!=''){
		$('#password')[0].focus();
	}
})

document.onkeydown = function(e){ 
    var ev = document.all ? window.event : e;
    if(ev.keyCode==13) {
          $('#submitButton').click();
     }
}
</script>
</@master.masterBlank>