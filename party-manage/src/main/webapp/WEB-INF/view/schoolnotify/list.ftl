<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />



<@master.masterFrame pageTitle=["通知管理","党校通知管理","通知列表"]>

<div class="panel panel-default table-responsive">

    <#assign isBranch=isBranch??&&isBranch>

    <div class="panel-heading">通知列表[${department.name}]</div>
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
                        <style>
                            .edui-default  input[type=checkbox], input[type=radio]{
                                opacity: 1;
                                position: inherit;
                                width: inherit;
                                height: inherit;
                            }
                        </style>
                        <p><#if notifyList??><#list notifyList as notify><#if notify.roleId == role.roleId><#if isBranch>${notify.content!}</#if></#if></#list></#if></p>
                        <textarea class="wysihtml5" id="edit_${role_index}"><#if notifyList??><#list notifyList as notify><#if notify.roleId == role.roleId><#if isBranch>${notify.extraContent!}<#else>${notify.content!}</#if></#if></#list></#if></textarea>
                        <hr>
                        <button class="btn btn-info" onclick="$.change(this);">修改</button>
                    </div>
                </#list>
            </div>
        </div>
    </div>
</div><!-- /panel -->


<script language="javascript">

    $(function(){
        //编辑器
        $('.wysihtml5').each(function () {
            var ue = UE.getEditor($(this).attr("id"), {
                //  toolbars: [edittoolbars,'pagebreak'],
                toolbars:[['fullscreen', 'source', '|',
                    'autotypeset','|',
                    'fontfamily', //字体
                    'fontsize', //字号
                    'bold', 'italic', 'underline', 'strikethrough', 'removeformat', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
                    'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
                    'indent', '|',
                    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|',
                    'link', 'unlink', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|',
                    'searchreplace']],
                elementPathEnabled: false,
                autoHeightEnabled: false,
                initialFrameHeight: 200,
                initialFrameWidth: "100%",
                minFrameWidth: 100,
                maximumWords: 100000,
                scaleEnabled:true,
                enableAutoSave:false,
                iframeCssUrl :"${basePath}/resources/css/manage-article-ueditor-a.css",
            });

        });
    });

    $.change = function (obj) {
        var p = $(obj).parent();

       var id = p.find("div.wysihtml5").attr("id");
       var content = UE.getEditor(id).getContent();

        $.ajax({
            cache: true,
            type: "POST",
            url: "${basePath}/schoolnotify/addOrUpdate",
            data: {"departmentId":${department.id},"roleId": p.attr("id"),"${inputName}":content},
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