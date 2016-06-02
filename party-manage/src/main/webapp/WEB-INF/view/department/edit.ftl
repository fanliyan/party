<#import "/master/master-frame.ftl" as master />
<#if department??>
    <#assign title=["院系管理","学院管理","修改学院"]>
<#else>
    <#assign title=["院系管理","学院管理","新增学院"]>
</#if>
<@master.masterFrame pageTitle=title>
<div class="panel panel-default">
    <div class="panel-body">
        <form id="formTag" class="form-horizontal no-margin form-border">

            <#if department??>
                <input type="hidden" name="id" value="${department.id!}"/>
                <input type="hidden" name="isUpdate" value="true"/>
            </#if>
            <div class="form-group">
                <label class="col-lg-1 control-label">名称</label>
                <div class="col-lg-5">
                    <input name="name" class="form-control "
                           placeholder="输入标题" value="${(department.name)!}"></input>
                </div><!-- /.col -->
            </div>

            <div class="panel-footer text-center">
                <button type="button" class="btn btn-success" id="submitButton">提交</button>
                <button type="button" class="btn btn-default" onclick="history.go(-1);">取消</button>
            </div>
        </form>
    </div>
</div><!-- /panel -->

<script language="javascript">
    $(function () {
        $("#submitButton").click(function () {
            if ($('#formTag').parsley().validate()) {
                $.submitformTag();
            }
        });
    });


    $.submitformTag = function () {
        $.ajax({
            cache: true,
            type: "POST",
            url: "${basePath}/department/addOrUpdate",
            data: $('#formTag').serialize(),
            async: false,
            error: function (request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function (data) {
                if (data.success) {
                    alertify.alert("操作成功！", function (e) {
                        location.href = "${basePath}/department/list";
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