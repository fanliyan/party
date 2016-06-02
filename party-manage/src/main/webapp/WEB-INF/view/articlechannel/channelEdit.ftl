<#import "/master/master-frame.ftl" as master />
<#if channel??>
	<#assign title=["文章频道管理","频道","修改频道"]>
<#else>
	<#assign title=["文章频道管理","频道","新增频道"]>
</#if>
<@master.masterFrame pageTitle=title>
<div class="panel panel-default">
		<div class="panel-body">
			<form id="formTag" class="form-horizontal no-margin form-border" >
				
				<#if channel??>
                    <input type="hidden" name="channelId" value="${channel.channelId!}" />
                    <input type="hidden" name="isUpdate" value="true" />
				</#if>
				<div class="form-group col-md-12">
					<label class="col-md-6 control-label"><span style="color: red">*</span>标签名称</label>
					<div class="col-md-6">
						<input class="form-control parsley-validated" type="text" placeholder="输入名称"
                               data-parsley-maxlength="50"
                               data-parsley-maxlength-message="名称不能超过50字"
                               data-parsley-required="true" name="name" value="${(channel.name)!}">
					</div><!-- /.col -->
                </div>
                <div class="form-group col-md-12">
                    <label class="col-md-6 control-label">父标签</label>
                    <div class="col-md-6">
                        <select name="parentId" id="tagTypeId" class="form-control chzn-select"
                                data-placeholder="请选择">
                            <option value="0">无</option>
                            <#if channelList ?? >
                                <#list channelList as channelModel >
                                    <#if channel?? && channel.channelId?? && (channel.channelId==channelModel.channelId ) >
                                    <#--非自己 -->
                                    <#--<option value="${tagModel.tagId}" selected>${tagModel.tagName}</option>-->
                                    <#else>
                                        <option value="${channelModel.channelId}" <#if channel??&&channelModel.channelId==channel.parentId>selected</#if>>${channelModel.name}</option>
                                    </#if>
                                </#list>
                            </#if>
                        </select>
                    </div>
                </div>
                <div class="form-group col-md-12">
                    <label class="col-md-6 control-label">权重</label>
                    <div class="col-md-6">
                        <input class="form-control parsley-validated" type="text" placeholder="输入权重 0-500"
                               data-parsley-type="integer"
                               data-parsley-min="0"
                               data-parsley-max="500"
                               data-parsley-min-message="权重不能小于0"
                               data-parsley-max-message="权重不能超过500"
                               name="weight" value="${(channel.weight)!}">
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
	if($('#formTag').parsley().validate()){
		$.submitformTag();
	}
});

$.submitformTag = function(){
	$.ajax({
        cache: true,
        type: "POST",
        url:"${basePath}/articlechannel/addOrUpdate",
        data:$('#formTag').serialize(),
        async: false,
        error: function(request) {
            alertify.alert("错误：服务器异常！");
        },
        success: function(data) {
        	if(data.success){   
            	alertify.alert("操作成功！",function(e){location.href="${basePath}/articlechannel/list";});
	        }   
	        else{   
            	alertify.alert("错误:" + data.message);
	        }   
        }
    });
}
</script>
</@master.masterFrame>