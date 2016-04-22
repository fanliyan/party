<#import "/master/master-frame.ftl" as master />
<#if task??>
    <#assign title=["课程管理","年度要求","修改年度要求"]>
<#else>
    <#assign title=["课程管理","年度要求","新增年度要求"]>
</#if>
<@master.masterFrame pageTitle=title>
<div class="panel panel-default">
    <div class="panel-body">
        <form id="formTagType" class="form-horizontal no-margin form-border">

            <#if task??>
                <input type="hidden" name="id" value="${task.id}"/>
                <input type="hidden" name="isUpdate" value="true"/>
            </#if>
            <div class="form-group">
                <label class="col-lg-1 control-label">标签类别名称</label>
                <div class="col-lg-11">
                    <input class="form-control parsley-validated" type="text" placeholder="输入名称"
                           data-parsley-maxlength="50"
                           data-parsley-maxlength-message="名称不能超过50字"
                           data-parsley-required="true" name="tagTypeName" value="${(task.name)!}">
                </div><!-- /.col -->
            </div>
            <div class="form-group">
                <label class="col-lg-1 control-label">标签类别名称</label>
                <div class="col-lg-11">
                    <input class="form-control parsley-validated" type="text" placeholder="输入名称"
                           data-parsley-maxlength="50"
                           data-parsley-maxlength-message="名称不能超过50字"
                           data-parsley-required="true" name="tagTypeName" value="${(task.name)!}">
                </div><!-- /.col -->
            </div>
            <div class="form-group" style="margin-right:10px;">
                <label class="col-lg-1 control-label">标签类别名称</label>
                <div class="col-lg-11">
                    <select class="form-control chzn-select" id="roleId" name="roleId"
                            data-parsley-required="true"
                            data-placeholder="选择角色"
                            data-parsley-errors-container="#channelId_Error">
                        <option value="">选择角色</option>
                        <#if roleList??>
                            <#list roleList as role >
                                <option value="${role.roleId!}"
                                        <#if taskModel??&&taskModel.roleId??&&taskModel.roleId == role.roleId>selected</#if>>${role.name!}</option>
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
    $("#submitButton").click(function () {
        if ($('#formTagType').parsley().validate()) {
            $.submitformTagType();
        }
    });

    $.submitformTagType = function () {
        $.ajax({
            cache: true,
            type: "POST",
            url: "${basePath}/tagType/addOrUpdate",
            data: $('#formTagType').serialize(),
            async: false,
            error: function (request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function (data) {
                if (data.success) {
                    alertify.alert("操作成功！", function (e) {
                        location.href = "${basePath}/tagType/list";
                    });
                }
                else {
                    alertify.alert("错误:" + data.message);
                }
            }
        });
    }
</script>
</@master.masterFrame>