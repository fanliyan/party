<#import "/master/master-frame.ftl" as master />
<#if articleKeywords??>
	<#assign title=["标签管理","标签","修改标签类型"]>
<#else>
	<#assign title=["标签管理","标签类型","新增标签类型"]>
</#if>
<@master.masterFrame pageTitle=title>
<div class="panel panel-default">
		<div class="panel-body">
			<form id="formTag" class="form-horizontal no-margin form-border" >
				
				<#if tag??>
                    <input type="hidden" name="tagId" value="${tag.tagId!}" />
                    <input type="hidden" name="isUpdate" value="true" />
				</#if>
				<div class="form-group">
					<label class="col-lg-1 control-label">标签类别名称</label>
					<div class="col-lg-5">
						<input class="form-control parsley-validated" type="text" placeholder="输入名称"
                               data-parsley-maxlength="100"
                               data-parsley-maxlength-message="名称不能超过100字"
                               data-parsley-required="true" name="tagName" value="<#if tag??>${tag.tagName!}</#if>">
					</div><!-- /.col -->

                    <label class="col-lg-1 control-label">标签类别</label>
                    <div class="col-md-5">
                        <select name="tagTypeId" id="tagTypeId" class="form-control chzn-select"
                                data-placeholder="请选择标签类别">
                            <option value="">请选择标签类别</option>
                            <#if tagTypeList ?? >
                                <#list tagTypeList as tagType >
                                    <#if tag?? && tagType.tagTypeId?? && tagType.tagTypeId==tag.tagTypeId>
                                        <option value="${tagType.tagTypeId}" selected>${tagType.tagTypeName}</option>
                                    <#else>
                                        <option value="${tagType.tagTypeId}">${tagType.tagTypeName}</option>
                                    </#if>
                                </#list>
                            </#if>
                        </select>
                    </div>
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
	if($('#formTag').parsley().validate()){
		$.submitformTag();
	}
});

$.submitformTag = function(){
	$.ajax({
        cache: true,
        type: "POST",
        url:"${basePath}/tag/addOrUpdate",
        data:$('#formTag').serialize(),
        async: false,
        error: function(request) {
            alertify.alert("错误：服务器异常！");
        },
        success: function(data) {
        	if(data.success){   
            	alertify.alert("操作成功！",function(e){location.href="${basePath}/tag/list";});
	        }   
	        else{   
            	alertify.alert("错误:" + data.message);
	        }   
        }
    });
}
</script>
</@master.masterFrame>