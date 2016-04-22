<#import "/master/master-frame.ftl" as master />
<#if roleModel??>
	<#assign title=["系统管理","角色管理","更新角色"]>
<#else>
	<#assign title=["系统管理","角色管理","新增角色"]>
</#if>
<@master.masterFrame pageTitle=title>
<div class="panel panel-default">
		<div class="panel-body">
			<form id="fromRole" class="form-horizontal no-margin form-border" >
				<#if roleModel??>
				<input type="hidden" name="roleId" value="${roleModel.roleId!}">
				</#if>
				<div class="form-group">
					<label class="col-lg-1 control-label">角色名称</label>
					<div class="col-lg-11">
						<input class="form-control parsley-validated" type="text" placeholder="输入角色名称" data-parsley-required="true" name="roleName" value="<#if roleModel??>${roleModel.name}</#if>">
					</div><!-- /.col -->					
				</div>
				
				<div class="form-group">	
					<label class="col-lg-1 control-label">此角色包含的模块</label>
					<div class="col-lg-11">
						
						<table class="table table-condensed" id="dataTable">
							<thead>
								<tr class="bg-theme">
									<th>
										<label class="label-checkbox">
											<input type="checkbox" class="chk-row" id="checkAll">
											<span class="custom-checkbox"></span>
										</label>
									</th>
									<th>模块名称</th>
									<#--<th>特殊权限</th>-->
									<th>创建时间</th>
									<th>最后修改时间</th>
								</tr>
							</thead>
							<tbody>
								<#list allModuleGroupList as moduleGroup>
									<tr class="warning">
										<td>
											<label class="label-checkbox">
												<input type="checkbox" class="chk-row _module" id="groupCheckBox" onclick="groupSelect(this);" value="${moduleGroup.id}">
												<span class="custom-checkbox"></span>
											</label>
										</td>
										<td>${moduleGroup.groupName}</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>	
									<#if moduleGroup.moduleModelList??>
										<#list moduleGroup.moduleModelList as module>
											<tr>
												<td>
													<label class="label-checkbox">
														&nbsp;<input type="checkbox" class="chk-row _groupid${moduleGroup.id} _module" name="moduleid" value="${module.moduleId}" ${checked(module.moduleId)}>
														<span class="custom-checkbox"></span>
													</label>
												</td>
												<td style="padding-left:20px">${module.name}</td>
												<#--<td>-->
													<#--<#if module.permissionModels??>-->
														<#--<#list module.permissionModels as permissionModel>-->
														<#--<label class="label-checkbox">-->
															<#--<input type="checkbox" class="chk-row" name="permissionId" value="${permissionModel.permissionId}" ${checked1(permissionModel.permissionId)}>-->
															<#--<span class="custom-checkbox">${permissionModel.permissionName}</span>-->
														<#--</label>-->
														<#--</#list>-->
													<#--</#if>-->
												<#--</td>-->
												<td>${module.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
												<td>${module.lastModifyTime?string('yyyy-MM-dd HH:mm:ss')}</td>
											</tr>	
										</#list>
									</#if>				
								</#list>
							</tbody>
						</table>
					</div><!-- /.col -->
				
				</div><!-- /form-group -->
				
				<div class="panel-footer text-center">
					<button type="button" class="btn btn-success" id="submitButton">提交</button>
					<button type="button" class="btn btn-default" onclick="javascript:history.go(-1);">取消</button>
				</div>
			</form>
	</div>
</div><!-- /panel -->
<#function checked moduelId>
	<#if roleModel??>
		<#list roleModel.moduleModelList as m>
			<#if m.moduleId == moduelId>
				<#return "checked='checked'">
			</#if>
		</#list>
	</#if>
	<#return "">   
</#function>

<#--<#function checked1 permissionId>-->
	<#--<#if roleModel??>-->
		<#--<#list roleModel.moduleModelList as m>-->
			<#--<#if m.permissionIdList ?? && m.permissionIdList?contains(permissionId+"")>-->
				<#--<#return "checked='checked'">-->
			<#--</#if>-->
		<#--</#list>-->
	<#--</#if>-->
	<#--<#return "">   -->
<#--</#function>-->

<script language="javascript">
$("#submitButton").click(function(){
	if($('#fromRole').parsley().validate()){
		if($('input[name="moduleid"]:checked').length==0){
			return alertify.confirm("此角色没包含任何权限，是否继续？", function (e) {
				if (e) {
					$.submitRole();
				} 
			});
		}
		else{
			$.submitRole();
		}
	}
});

$.submitRole = function(){
	$.ajax({
        cache: true,
        type: "POST",
        url:"${basePath}/role/addoredit",
        data:$('#fromRole').serialize(),
        async: false,
        error: function(request) {
            alertify.alert("错误：服务器异常！");
        },
        success: function(data) {
        	if(data.success){   
            	alertify.alert("操作成功！",function(e){location.href="${basePath}/role/list";});
	        }   
	        else{   
            	alertify.alert("错误:" + data.message);
	        }   
        }
    });
}

$("#checkAll").click(function(){
	$("._module").prop('checked',$("#checkAll").is(':checked'));
});

/*$("#groupCheckBox").click(function(){
	$("._groupid" + $(this).val()).prop('checked',$(this).is(':checked'));
});*/

function groupSelect(obj){
	$("._groupid" + $(obj).val()).prop('checked',$(obj).is(':checked'));
}
</script>
</@master.masterFrame>