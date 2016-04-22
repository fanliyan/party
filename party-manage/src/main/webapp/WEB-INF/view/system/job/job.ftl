<#import "/master/master-frame.ftl" as master />
<#if model??>
	<#assign title=["系统管理","Job管理","更新Job"]>
<#else>
	<#assign title=["系统管理","Job管理","新增Job"]>
</#if>
<@master.masterFrame pageTitle=title>
<div class="panel panel-default">
		<div class="panel-body">
			<form id="fromJob" class="form-horizontal no-margin form-border" >
				<div class="form-group">
					<label class="col-lg-1 control-label">Job ID</label>
					<div class="col-lg-11">
						<#if model??>
							<p class="form-control-static">${model.jobScheduleId}</p>
							<input type="hidden" name="jobScheduleId" value="${model.jobScheduleId}" />
							<input type="hidden" name="isUpdate" value="true" />
						<#else>						
							<input class="form-control parsley-validated" type="text" placeholder="输入Job ID" data-parsley-required="true" name="jobScheduleId" value="<#if model??>${model.jobScheduleId}</#if>">
						</#if>
					</div><!-- /.col -->					
				</div>
				
				<div class="form-group">
					<label class="col-lg-1 control-label">Job名称</label>
					<div class="col-lg-11">
						<input class="form-control parsley-validated" type="text" placeholder="输入Job名称" data-parsley-required="true" name="jobName" value="<#if model??>${model.jobName}</#if>">
					</div><!-- /.col -->					
				</div>
				
				<div class="form-group">
					<label class="col-lg-1 control-label">类名(全名)</label>
					<div class="col-lg-11">					
						<#if model??>
							<p class="form-control-static"><#if model??>${model.jobClassName}</#if></p>
						<#else>
							<input class="form-control parsley-validated" type="text" placeholder="输入类名(全名)" data-parsley-required="true" name="jobClassName" value="<#if model??>${model.jobClassName}</#if>">
						</#if>
					</div><!-- /.col -->					
				</div>
				
				<div class="form-group">
					<label class="col-lg-1 control-label">执行参数</label>
					<div class="col-lg-11">				
						<#if model??>
							<p class="form-control-static">${model.jobParam!}</p>
						<#else>
							<input class="form-control" type="text" placeholder="输入执行参数" name="jobParam" value="<#if model??>${model.jobParam!}</#if>">
						</#if>
					</div><!-- /.col -->					
				</div>
				
				<div class="form-group">
					<label class="col-lg-1 control-label">Job描述</label>
					<div class="col-lg-11">
						<textarea class="form-control parsley-validated" rows="3" placeholder="输入Job描述" data-parsley-required="true" name="jobDesc"><#if model??>${model.jobDesc}</#if></textarea>
					</div><!-- /.col -->					
				</div>
				
				
				<div class="form-group">
					<label class="col-lg-1 control-label">运行时间表达式</label>
					<div class="col-lg-11">
						<input class="form-control parsley-validated" type="text" placeholder="输入运行时间表达式" data-parsley-required="true" name="cronExpression" value="<#if model??>${model.cronExpression}</#if>">
					</div><!-- /.col -->					
				</div>
				
				<div class="form-group">
					<label class="col-lg-1 control-label">同步/异步执行</label>
					<div class="col-lg-11">
						<label class="label-radio inline">
							<input type="radio" name="isSync" value="true" <#if model?? && model.isSync || !model??>checked="checked"</#if>>
							<span class="custom-radio"></span>
							同步
						</label>
						<label class="label-radio inline">
							<input type="radio" name="isSync" value="false" <#if model?? && !model.isSync>checked="checked"</#if>>
							<span class="custom-radio"></span>
							异步
						</label>
					</div><!-- /.col -->
				</div>
				
				<div class="form-group">
					<label class="col-lg-1 control-label">Job状态</label>
					<div class="col-lg-11">
						<select class="input-sm form-control inline" style="width:130px;" name="status"> 
							<option value="0">正常</option> 
							<option value="1">禁用</option> 
						</select>
					</div><!-- /.col -->					
				</div>				
				
				<div class="panel-footer text-center">
					<button type="button" class="btn btn-success" id="submitButton">提交</button>
					<button type="button" class="btn btn-default" onclick="javascript:history.go(-1);">取消</button>
				</div>
			</form>
	</div>
</div><!-- /panel -->

<script language="javascript">
$("#submitButton").click(function(){
	if($('#fromJob').parsley().validate()){		
		$.submitJob();
	}
});

$.submitJob = function(){
	$.ajax({
        cache: true,
        type: "POST",
        url:"${basePath}/job/addoredit",
        data:$('#fromJob').serialize(),
        async: false,
        error: function(request) {
            alertify.alert("错误：服务器异常！");
        },
        success: function(data) {
        	if(data.success){   
            	alertify.alert("操作成功！",function(e){location.href="${basePath}/job/list";});
	        }   
	        else{   
            	alertify.alert("错误:" + data.message);
	        }   
        }
    });
}
</script>
</@master.masterFrame>