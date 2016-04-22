<#import "/master/master-frame.ftl" as master />
<#if articleKeywords??>
	<#assign title=["标签管理","标签类型","修改标签类型"]>
<#else>
	<#assign title=["标签管理","标签类型","新增标签类型"]>
</#if>
<@master.masterFrame pageTitle=title>
<div class="panel panel-default">
		<div class="panel-body">
			<form id="formTagType" class="form-horizontal no-margin form-border" >
				
				<#if tagType??>
					<input type="hidden" name="tagTypeId" value="${tagType.tagTypeId}" />
                    <input type="hidden" name="isUpdate" value="true" />
				</#if>
				<div class="form-group">
					<label class="col-lg-1 control-label">标签类别名称</label>
					<div class="col-lg-11">
						<input class="form-control parsley-validated" type="text" placeholder="输入名称"
                               data-parsley-maxlength="50"
                               data-parsley-maxlength-message="名称不能超过50字"
                               data-parsley-required="true" name="tagTypeName" value="<#if tagType??>${tagType.tagTypeName}</#if>">
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
	if($('#formTagType').parsley().validate()){
		$.submitformTagType();
	}
});

$.submitformTagType = function(){
	$.ajax({
        cache: true,
        type: "POST",
        url:"${basePath}/tagType/addOrUpdate",
        data:$('#formTagType').serialize(),
        async: false,
        error: function(request) {
            alertify.alert("错误：服务器异常！");
        },
        success: function(data) {
        	if(data.success){   
            	alertify.alert("操作成功！",function(e){location.href="${basePath}/tagType/list";});
	        }   
	        else{   
            	alertify.alert("错误:" + data.message);
	        }   
        }
    });
}
</script>
</@master.masterFrame>