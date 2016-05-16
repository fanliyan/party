<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["通知管理","党校通知管理","banner列表"]>

<div class="panel panel-default table-responsive">

    <div class="panel-heading">通知列表</div>
    <div class="panel-body no-padding">
        <div class="tab-left">
            <ul class="tab-bar">
                <#list roleList as role>
                    <li class="<#if role_index==0>active</#if>"><a href="#${role.roleId}" data-toggle="tab">
                        <i class="fa fa-pencil"></i> ${(role.name)!}</a>
                    </li>
                </#list>
            </ul>
            <div class="tab-content">
                <#list roleList as role>
                    <div class="tab-pane fade <#if role_index==0>active in</#if>" id="${role.roleId}"  >
                        <textarea class="form-control"><#if notifyList??><#list notifyList as notify><#if notify.roleId == role.roleId>${notify.content}</#if></#list></#if></textarea>
                        <hr>
                        <button class="btn btn-info" onclick="$.change(this);">修改</button>
                    </div>
                </#list>
            </div>
        </div>
    </div>
</div><!-- /panel -->

<script language="javascript">
    $.change = function (obj) {
        var p = $(obj).parent();

        $.ajax({
            cache: true,
            type: "POST",
            url: "${basePath}/schoolnotify/addOrUpdate",
            data: {"roleId": p.attr("id"),"content":p.find("textarea").val()},
            async: false,
            error: function (request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function (data) {
                if (data.success) {
                    location.reload();
                }
                else {
                    alertify.alert("错误:" + data.message);
                }
            }
        });
    };
</script>
</@master.masterFrame>