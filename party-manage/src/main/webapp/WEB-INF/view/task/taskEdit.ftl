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
                <label class="col-lg-1 control-label">任务名称</label>
                <div class="col-lg-11">
                    <input class="form-control parsley-validated" type="text" placeholder="输入名称"
                           data-parsley-maxlength="50"
                           data-parsley-maxlength-message="名称不能超过50字"
                           data-parsley-required="true" name="name" value="${(task.name)!}">
                </div><!-- /.col -->
            </div>
            <div class="form-group">
                <label class="col-lg-1 control-label">目标分数</label>
                <div class="col-lg-11">
                    <input class="form-control parsley-validated" type="text" placeholder="输入目标分数"
                           data-parsley-min="0"
                           data-parsley-max="1000"
                           name="targetScore" value="${(task.targetScore)!}">
                </div><!-- /.col -->
            </div>
            <div class="form-group">
                <label class="col-lg-1 control-label">目标时长</label>
                <div class="col-lg-11">
                    <input class="form-control parsley-validated" type="text" placeholder="输入名称"
                           data-parsley-min="0"
                           data-parsley-max="1000"
                           name="targetTime" value="${(task.targetTime)!}">
                </div><!-- /.col -->
            </div>
            <div class="form-group ">
                <label class="col-lg-1 control-label">开始时间</label>
                <div class="col-lg-5">
                    <input id="startTimeString" name="startTimeString" placeholder="请点击选择时间"
                           class="form-control"
                           type="text"
                           value="${(task.startTime?string("yyyy-MM-dd HH:mm:ss"))!}"
                           data-parsley-trigger="blur"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
                <label class="col-lg-1 control-label">结束时间</label>
                <div class="col-lg-5">
                    <input id="endTimeString" name="endTimeString" placeholder="请点击选择时间"
                           class="form-control"
                           type="text"
                           value="${(task.endTime?string("yyyy-MM-dd HH:mm:ss"))!}"
                           data-parsley-trigger="blur"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div><!-- /form-group -->
            <div class="form-group" style="margin-right:10px;">
                <label class="col-lg-1 control-label">角色</label>
                <div class="col-lg-11">
                    <select class="form-control chzn-select" id="roleId" name="roleId"
                            data-parsley-required="true"
                            data-placeholder="选择角色"
                            data-parsley-errors-container="#channelId_Error">
                        <option value="">选择角色</option>
                        <#if roleList??>
                            <#list roleList as role >
                                <option value="${role.roleId!}"
                                        <#if task??&&task.roleId??&&task.roleId == role.roleId>selected</#if>>${role.name!}</option>
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

<script>
    $(function(){
        //时间选择器
        $('#startTimeString,#endTimeString').datetimepicker({
            dateFormat: 'yy-mm-dd',
            timeFormat: "HH:mm:ss"
        });
    });
</script>
<script language="javascript">
    $("#submitButton").click(function () {
        if ($('#formTagType').parsley().validate()) {
            $.submitformTagType();
        }
    });

    $.submitformTagType = function () {

        //score/time 必须有一个

        var targetScore = $("input[name='targetScore']").val();
        var targetTime = $("input[name='targetTime']").val();

        if(targetScore||targetTime){
            $.ajax({
                cache: true,
                type: "POST",
                url: "${basePath}/task/addOrUpdate",
                data: $('#formTagType').serialize(),
                async: false,
                error: function (request) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function (data) {
                    if (data.success) {
                        alertify.alert("操作成功！", function (e) {
                            location.href = "${basePath}/task/list";
                        });
                    }
                    else {
                        alertify.alert("错误:" + data.message);
                    }
                }
            });
        }else{
            alertify.alert("目标时长与目标分数请至少选择其一");
        }
    }
</script>
</@master.masterFrame>