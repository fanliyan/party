<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["客户","用户管理","分配角色"]>
<div class="padding-md col-md-6 col-md-offset-3">
			<form id="roleForm">
	<div class="row">
		<div class="panel panel-default">
			<div class="panel-heading">基本资料</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="col-md-4 control-label text-right">姓名</label>
							<div class="col-md-8 ">
								<p class="form-control-static">${user.name!}</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="col-md-4 control-label text-right">性别</label>
							<div class="col-md-8">
								<p class="form-control-static"><#if user.gender??><#if user.gender=="M">男<#else>女</#if></#if></p>
							</div>
						</div>
					</div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">生日</label>
                            <div class="col-md-8">
                                <p class="form-control-static"><#if user.birthday??>${user.birthday}</#if></p>
                            </div>
                        </div>
                    </div>
				</div>
				
				<#--<div class="row">-->
					<#--<div class="col-md-6">-->
						<#--<div class="form-group">-->
							<#--<label class="col-md-4 control-label text-right">昵称</label>-->
							<#--<div class="col-md-8">-->
								<#--<p class="form-control-static">${user.nickName!}</p>-->
							<#--</div>-->
						<#--</div>-->
					<#--</div>-->
					<#--<div class="col-md-6">-->
						<#--<div class="form-group">-->
							<#--<label class="col-md-4 control-label text-right">生日</label>-->
							<#--<div class="col-md-8">-->
								<#--<p class="form-control-static"><#if user.birthday??>${user.birthday?string('yyyy-MM-dd')}</#if></p>-->
							<#--</div>-->
						<#--</div>-->
					<#--</div>-->
				<#--</div>-->
				<#--<div class="row">-->
					<#--<div class="col-md-6">-->
						<#--<div class="form-group">-->
							<#--<label class="col-md-4 control-label text-right">手机</label>-->
							<#--<div class="col-md-8">-->
								<#--<p class="form-control-static">${user.phone!}</p>-->
							<#--</div>-->
						<#--</div>-->
					<#--</div>-->
					<#--<div class="col-md-6">-->
						<#--<div class="form-group">-->
							<#--<label class="col-md-4 control-label text-right">邮箱</label>-->
							<#--<div class="col-md-8">-->
								<#--<p class="form-control-static">${user.email!}</p>-->
							<#--</div>-->
						<#--</div>-->
					<#--</div>-->
				<#--</div>-->
				
				<div class="row">
					<div class="col-md-6">
						<div class="form-group">
							<label class="col-md-4 control-label text-right">注册日期</label>
							<div class="col-md-8">
								<p class="form-control-static">${user.createTime?string('yyyy-MM-dd')}</p>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label class="col-md-4 control-label text-right">最后登录日期</label>
							<div class="col-md-8">
								<p class="form-control-static"><#if user.lastLoginTime??>${user.lastLoginTime?string('yyyy-MM-dd HH:mm:ss')}</#if></p>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<#--<div class="col-md-6">-->
						<#--<div class="form-group">-->
							<#--<label class="col-md-4 control-label text-right">用户级别</label>-->
							<#--<div class="col-md-8">-->
								<#--<select name="level" id="level" class="form-control chzn-select" >-->
									<#--<option value="0" <#if user.level==0>selected="selected"</#if>>网站用户</option>-->
									<#--<option value="10" <#if user.level==10>selected="selected"</#if>>云平台用户</option>-->
									<#--<option value="30" <#if user.level==30>selected="selected"</#if>>内部用户</option>-->
								<#--</select>-->
							<#--</div>-->
						<#--</div>-->
					<#--</div>-->
					<div class="col-md-12">
						<div class="form-group">
							<label class="col-md-4 control-label text-right">角色</label>
							<div class="col-md-8">
								<p class="form-control-static">
									<#if user.hasRoles??>
										<#list user.hasRoles as r>
											${r.name}&nbsp;
										</#list>
									</#if>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="panel panel-default table-responsive">
			<div class="panel-heading">
				所有角色
				<span class="label label-info pull-right">目前共有 ${allRoles?size} 个角色</span>
			</div>
			<table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
				<thead>
					<tr>
						<th>
							<label class="label-checkbox">
								<input type="checkbox" class="chk-row" id="checkAll" >
								<span class="custom-checkbox"></span>
							</label>
							<input type="hidden" name="userId" value="${user.userId}"/>
						</th>
						<th>角色名称</th>
						<th>创建时间</th>
					</tr>
				</thead>
				<tbody>
					<#list allRoles as rolesModel>
					<tr>
						<td>
							<label class="label-checkbox">
								<input type="checkbox" class="chk-row" name="roleId" value="${rolesModel.roleId}" ${checked(rolesModel.roleId)}>
								<span class="custom-checkbox"></span>
							</label>
						</td>		
						<td>${rolesModel.name}</td>
						<td>${rolesModel.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
					</tr>
					</#list>
				</tbody>
			</table>
			<div class="panel-footer text-center">
				<button type="button" class="btn btn-success" onclick="submitRole();">保存</button>
				<button type="button" class="btn btn-default" onclick="javascript:history.go(-1);">返回</button>
			</div>
		</div>
	</div>
</form>
</div>
<#function checked roleId>
	<#if user.hasRoles??>
		<#list user.hasRoles as r>
			<#if r.roleId == roleId>
				<#return "checked='checked'">
			</#if>
		</#list>
	</#if>
	<#return "">   
</#function>
<script language="javascript">
$("#checkAll").click(function(){
	$("input[name='roleId']").prop('checked',$("#checkAll").is(':checked'));
});

//function submitRole(){
//	var flags=$("input[name='roleId']:checked");
//	var level=$("#level").val();
//	if(flags.length>0 && level=="0"){
//		return alertify.confirm("请改变用户的级别，否则用户仍然无法登录云平台，是否继续？", function (e) {
//			if (e) {
//				submitr();
//			}
//		});
//	}else{
//		submitr();
//	}
//
//}
function submitRole(){
    var flags=$("input[name='roleId']:checked");
    if(flags.length>0){
        submitr();
    }else{
        alertify.alert("错误:" + data.message);
    }
}

function submitr(){
$.ajax({
	cache: true,
	type: "POST",
	url:"${basePath}/users/editRole",
	data:$('#roleForm').serialize(),
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