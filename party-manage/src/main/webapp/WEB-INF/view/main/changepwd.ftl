<#import "/master/master-frame.ftl" as master />
<#assign title=["修改密码"]>
<@master.masterFrame pageTitle=title>
<div class="panel panel-default">
	<form class="form-horizontal form-border" name="resetPasswordFrom" data-parsley-validate id="resetPasswordFrom" method="post">
		<div class="panel-heading">
			密码
		</div>
		<div class="panel-body">
			<div class="form-group">
				<label class="control-label col-md-2">原密码</label>												
				<div class="col-md-10">
					<input type="password" class="form-control input-sm parsley-validated" data-parsley-required="true" data-parsley-required-message="请输入原密码" placeholder="6-20位之间" name="oldPassword">
				</div><!-- /.col -->
			</div><!-- /form-group -->
			<div class="form-group">
				<label class="control-label col-md-2">新密码</label>
				<div class="col-md-10">
					<input type="password" class="form-control input-sm parsley-validated" data-parsley-required="true" data-parsley-required-message="请输入密码" data-parsley-length="[6,20]" data-parsley-length-message="必须在6-20位之间" placeholder="6-20位之间" name="password" id="password">
				</div><!-- /.col -->
			</div><!-- /form-group -->
			<div class="form-group">
				<label class="control-label col-md-2">重新输入新密码</label>
				<div class="col-md-10">
					<input type="password" class="form-control input-sm parsley-validated" data-parsley-required="true" data-parsley-required-message="请再次输入密码" data-parsley-equalto="#password" data-parsley-equalto-message="两次密码输入不一致" data-parsley-length="[6,20]" data-parsley-length-message="6-20位之间" placeholder="6位以上，必须包含数字和字母" name="password2">
				</div><!-- /.col -->
			</div><!-- /form-group -->
		</div>
		<div class="panel-footer">
			<div class="text-right">
				<button class="btn btn-sm btn-success validate" type="button" id="btnResetPassword">重置密码</button>
			</div>
		</div>
	</form>
</div><!-- /panel -->		
				
<script language="javascript">

	$("#btnResetPassword").click(function(){
		if($('#resetPasswordFrom').parsley().validate()){
			$.ajax({
		        cache: true,
		        type: "POST",
		        url:"${basePath}/main/resetpwd",
		        data:$('#resetPasswordFrom').serialize(),
		        async: false,
		        error: function(request) {
		            alertify.error("错误：服务器异常！");
		        },
		        success: function(data) {
		        	if(data.success){   
            			alertify.alert("密码修改成功！",function(e){location.href="${basePath}/main/index";});
			        }   
			        else{   
		            	alertify.alert("错误:" + data.message);
			        }   
		        }
		    });
		}
	});
</script>	
</@master.masterFrame>	