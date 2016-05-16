<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["学生管理","角色管理","分配角色"]>
<div class="padding-md col-md-6 col-md-offset-3">
    <form id="roleForm">
        <div class="row">
            <div class="panel panel-default">
                <div class="panel-heading">角色</div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="col-md-4 control-label text-right">角色</label>
                                <div class="col-md-8">
                                    <select name="roleId" id="role" class="form-control chzn-select">
                                        <#list allRoles as role>
                                            <option value="${role.roleId}"
                                                    <#if roleModel.roleId==role.roleId>selected</#if>>${role.name}</option>
                                        </#list>
                                    </select>
                                </div>
                                <input type="hidden" name="userId" value="${userId}">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="panel-footer text-center">
            <button type="button" class="btn btn-success" onclick="submitRole();">保存</button>
            <button type="button" class="btn btn-default" onclick="javascript:history.go(-1);">返回</button>
        </div>
    </form>
</div>

<script language="javascript">
    function submitRole() {
            submitr();
    }

    function submitr() {
        $.ajax({
            cache: true,
            type: "POST",
            url: "${basePath}/student/editRole",
            data: $('#roleForm').serialize(),
            async: false,
            error: function (request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function (data) {
                if (data.success) {
                    alertify.alert("操作成功！", function (e) {
                        location.href = "${basePath}/student/list";
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