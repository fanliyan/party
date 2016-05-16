<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["客户","用户管理","用户详情"]>
<div class="padding-md col-md-6 col-md-offset-3">
	<div class="row">
		<div class="panel panel-default">
			<div class="panel-heading">基本资料</div>
			<form class="form-horizontal form-border" id="userForm" >
			<div class="panel-body">
				<div class="form-group">
					<label class="col-md-4 control-label text-right">姓名</label>
					<div class="col-md-8 ">
						<input name="name" type="text" class="form-control input-sm" id="" placeholder="必填,字符最大长度20"
							 data-parsley-trigger="blur"
							 data-parsley-required="true"
							 data-parsley-required-message="姓名不可为空"
							 value="${(user.name)!}"
							/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label text-right">性别</label>
					<div class="col-md-8">
						<label class="label-radio inline">
							<input type="radio" name="gender" value="M" <#if (user.gender)??><#if user.gender=="M">checked="checked"</#if><#else>checked="checked"</#if>>
							<span class="custom-radio"></span>
							男
						</label>
						<label class="label-radio inline">
							<input type="radio" name="gender" value="F" <#if (user.gender)??><#if user.gender=="F">checked="checked" </#if></#if>>
							<span class="custom-radio"></span>
							女
						</label>
					</div>
				</div>
		
				<#--<div class="form-group">-->
					<#--<label class="col-md-4 control-label text-right">姓名</label>-->
					<#--<div class="col-md-8">-->
						<#--<p class="form-control-static"></p>-->
						<#--<input name="nickName" type="text" class="form-control input-sm" value="${(user.nickName)!}"/>-->
					<#--</div>-->
				<#--</div>-->
				<div class="form-group">
					<label class="col-md-4 control-label text-right">账号</label>
					<div class="col-md-8">
						<input name="account" type="text" class="form-control input-sm" value="${(user.account)!}"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label text-right">密码</label>
					<div class="col-md-8">
						<input name="password" type="text" class="form-control input-sm" value="${(user.password)!}"/>
					</div>
				</div>
			</div>
			<div class="panel-footer text-center">
				<button type="button" class="btn btn-success" onclick="submitr();">保存</button>
				<button type="button" class="btn btn-default" onclick="javascript:history.go(-1);">返回</button>
			</div>
			</form>
		</div>
	</div>
</div>
<script language="javascript">
	function submitr(){
		$.ajax({
			cache: true,
			type: "POST",
			url:"${basePath}/users/saveUser",
			data:$('#userForm').serialize(),
			async: false,
			error: function(request) {
				alertify.alert("错误：服务器异常！");
			},
			success: function(data) {
				if(data.success){
					alertify.alert("操作成功！",function(e){location.href="${basePath}/users/list";});
				}
				else{
					alertify.alert("错误:" + data.message);
				}   
			}
		});
	}
</script>
</@master.masterFrame>