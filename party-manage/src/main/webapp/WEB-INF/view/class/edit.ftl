<#import "/master/master-frame.ftl" as master />
<#if class??>
    <#assign title=["院系管理","班级管理","修改班级"]>
<#else>
    <#assign title=["院系管理","班级管理","新增班级"]>
</#if>
<@master.masterFrame pageTitle=title>
<div class="panel panel-default">
    <div class="panel-body">
        <form id="formTag" class="form-horizontal no-margin form-border">

            <#if class??>
                <input type="hidden" name="id" value="${class.id!}"/>
                <input type="hidden" name="isUpdate" value="true"/>
            </#if>
            <input type="hidden" name="xiId" value="${id}">

            <div class="form-group">
                <label class="col-lg-1 control-label">名称</label>
                <div class="col-lg-5">
                    <input name="name" class="form-control "
                           placeholder="输入标题" value="${(class.name)!}"></input>
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
            url: "${basePath}/class/addOrUpdate",
            data: $('#formTag').serialize(),
            async: false,
            error: function (request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function (data) {
                if (data.success) {
                    alertify.alert("操作成功！", function (e) {
                        location.href = "${basePath}/class/list/${id}";
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