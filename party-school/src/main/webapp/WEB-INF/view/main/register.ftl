<#import "/master/master-blank.ftl" as master />
<@master.masterBlank title="网上党校-注册">

<div class="login-wrapper">
    <div class="text-center">
        <h2 class="fadeInUp animation-delay10" style="font-weight:bold">
            <span class="text-success">计算机学院</span> <span style="color:#ccc; text-shadow:0 1px #fff">网上党校</span>
        </h2>
    </div>
    <div class="login-widget animation-delay1">
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="fa fa-plus-circle fa-lg"></i> 注册
            </div>
            <div class="panel-body">
                <form class="form-login">
                    <div class="form-group">
                        <label>账号</label>
                        <input type="text" name="account" placeholder="Username" class="form-control input-sm bounceIn animation-delay2 parsley-validated"
                               data-parsley-required="true"
                               data-parsley-required-message="用户名不可为空"
                        >
                    </div><!-- /form-group -->
                    <div class="form-group">
                        <label>密码</label>
                        <input type="password" name="password" placeholder="Password" class="form-control input-sm bounceIn animation-delay3 parsley-validated"
                               data-parsley-required="true"
                               data-parsley-trigger="focusout"
                               data-parsley-required-message="密码不可为空"
                               data-parsley-minlength="6"
                               data-parsley-minlength-message="密码位数不可少于6位"
                        >
                    </div><!-- /form-group -->
                    <div class="form-group">
                        <label>姓名</label>
                        <input type="text" name="name" placeholder="Name" class="form-control input-sm bounceIn animation-delay4  parsley-validated"
                               data-parsley-required="true"
                               data-parsley-required-message="姓名不可为空"
                        >
                    </div><!-- /form-group -->
                    <div class="form-group">
                        <label>学号</label>
                        <input type="text" name="studentCode" placeholder="Student Code" class="form-control input-sm bounceIn animation-delay5  parsley-validated"
                               data-parsley-required="true"
                               data-parsley-required-message="学号不可为空"
                        >
                    </div><!-- /form-group -->
                    <#--<div class="form-group">-->
                        <#--<label class="label-checkbox">-->
                            <#--<input type="checkbox" class=" parsley-validated"-->
                                   <#--data-parsley-required="true"-->
                                   <#--data-parsley-required-message="倾"-->
                            <#--/>-->
                            <#--<span class="custom-checkbox info bounceIn animation-delay6"></span>-->
                            <#--我同意服务使用协议。-->
                        <#--</label>-->
                    <#--</div><!-- /form-group &ndash;&gt;-->

                    <div class="seperator"></div>
                    <div class="form-group">
                        <div class="controls">
                            已有账号？ <a href="${basePath}/main/login" class="primary-font login-link">登录</a>
                        </div>
                    </div><!-- /form-group -->

                    <hr/>
                    <div class="form-group">
                        <div class="controls text-right">
                            <a class="btn btn-success btn-sm bounceIn animation-delay7 "
                               id="submitButton" href="javascript:void(0)">
                                <i class="fa fa-plus-circle"></i> 注册</a>
                        </div>
                    </div><!-- /form-group -->
                </form>
            </div>
        </div><!-- /panel -->
    </div><!-- /login-widget -->
</div><!-- /login-wrapper -->

<@master.js>
<script language="javascript">
$("#submitButton").click(function(){

	if($('form').parsley().validate()){
		$.ajax({
        cache: true,
        type: "POST",
        url:"${basePath}/main/register",
        data:$('form').serialize(),
        async: false,
        error: function(data) {
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
</@master.js>

</@master.masterBlank>