<#import "/master/master-frame.ftl" as master />
<#if smsTemp??>
	<#assign title=["基础数据管理","短信模板","修改短信模板"]>
<#else>
	<#assign title=["基础数据管理","短信模板","新增短信模板"]>
</#if>
<@master.masterFrame pageTitle=title>
<div class="panel panel-default">
		<div class="panel-body">
			<form id="formSmsTemp" class="form-horizontal no-margin form-border" >
				
				
				<#if smsTemp??>
					<input type="hidden" name="msgTemplateId" value="${smsTemp.msgTemplateId}" />
					<input type="hidden" name="isUpdate" value="true" />
				</#if>
				<div class="form-group">
					<label class="col-lg-1 control-label">短信模板名称</label>
					<div class="col-lg-11">
						<input class="form-control parsley-validated" type="text" placeholder="输入短信模板名称" 
						data-parsley-maxlength="25"
						data-parsley-maxlength-message="内容不能超过25字"
						data-parsley-required="true" name="title" value="<#if smsTemp??>${smsTemp.title}</#if>">
					</div><!-- /.col -->					
				</div>
				<div class="form-group">
					<label class="col-lg-1 control-label">短信模板内容</label>
					<div class="col-lg-11">
						<input class="form-control parsley-validated" type="text"
						data-parsley-maxlength="120"
						data-parsley-maxlength-message="内容不能超过120字"
						 placeholder="输入短信模板内容" data-parsley-required="true" name="content" value="<#if smsTemp??>${smsTemp.content}</#if>">
					</div><!-- /.col -->					
				</div>
				<div class="form-group">
					<label class="col-lg-1 control-label">是否有效</label>
					<div class="col-lg-11">
						<select id="isValid" name="isValid" class="form-control chzn-select" required data-placeholder="请选择有效标识" data-parsley-required-message="有效标识不可为空">
							<#if smsTemp??>
								<option value="true"  <#if smsTemp.isValid==true>selected="selected"</#if>>是</option>
								<option value="false" <#if smsTemp.isValid==false>selected="selected"</#if>>否</option>
							<#else>
								<option value="true"  selected="selected">是</option>
								<option value="false" >否</option>
							</#if>

						</select>
					</div><!-- /.col -->					
				</div>
				<div class="form-group">
					<label class="col-lg-1 control-label">模板类型</label>
					<div class="col-lg-11">
						<select id="tempType" name="tempType" class="form-control chzn-select" required data-placeholder="请选择模板类型" data-parsley-required-message="模板类型不可为空">
							<#if smsTemp??>
								<option value=1  <#if smsTemp.tempType==1>selected="selected"</#if>>系统模板</option>
								<option value=2 <#if smsTemp.tempType==2>selected="selected"</#if>>用户模板</option>
							<#else>
								<option value=1  selected="selected">系统模板</option>
								<option value=2 >用户模板</option>
							</#if>

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
	if($('#formSmsTemp').parsley().validate()){		
		$.submitSmsTemp();
	}
});

$.submitSmsTemp = function(){
	$.ajax({
        cache: true,
        type: "POST",
        url:"${basePath}/smsTemp/addOrEditSmsTemp",
        data:$('#formSmsTemp').serialize(),
        async: false,
        error: function(request) {
            alertify.alert("错误：服务器异常！");
        },
        success: function(data) {
        	if(data.success){   
            	alertify.alert("操作成功！",function(e){location.href="${basePath}/smsTemp/list";});
	        }   
	        else{   
            	alertify.alert("错误:" + data.message);
	        }   
        }
    });
}
</script>
</@master.masterFrame>