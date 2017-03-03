<#import "/master/master-frame.ftl" as master />
<#if banner??>
    <#assign title=["通知管理","banner管理","修改banner"]>
<#else>
    <#assign title=["通知管理","banner管理","新增banner"]>
</#if>
<@master.masterFrame pageTitle=title>
<div class="panel panel-default">
    <div class="panel-body">
        <form id="formTag" class="form-horizontal no-margin form-border">

            <#if banner??>
                <input type="hidden" name="id" value="${banner.id!}"/>
                <input type="hidden" name="isUpdate" value="true"/>
            </#if>
            <div class="form-group">
                <label class="col-lg-1 control-label">banner图</label>
                <div class="col-lg-5">
                    <img id="banner" width="100px" height="100px"
                         src="<#if banner?? && banner.pic?? && banner.pic?length gt 0>${banner.pic}</#if>">
                    <input name="pic" class="form-control insertFile" maxfile="1"
                           value="<#if banner??>${banner.pic!}</#if>"
                           data-target="#banner" type="text" required="" data-parsley-required-message="请上传banner图"
                           data-parsley-trigger="blur" placeholder="请点击上传banner图"/>
                </div><!-- /.col -->
            </div>
            <div class="form-group">
                <label class="col-lg-1 control-label">链接</label>
                <div class="col-md-5">
                    <input class="form-control parsley-validated" type="text" placeholder="点击banner后跳转链接"
                           data-parsley-maxlength="200"
                           data-parsley-maxlength-message="链接不能超过200字符"
                           data-parsley-required="true" name="url"
                           value="${(banner.url)!}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-1 control-label">标题</label>
                <div class="col-lg-5">
                    <textarea name="name" class="form-control "
                              data-parsley-required="true"    placeholder="输入标题">${(banner.name)!}</textarea>
                </div><!-- /.col -->
            </div>
            <div class="form-group">
                <label class="col-lg-1 control-label">内容</label>
                <div class="col-lg-5">
                    <textarea name="description" class="form-control "
                              data-parsley-required="true"     placeholder="输入内容">${(banner.description)!}</textarea>
                </div><!-- /.col -->
            </div>
            <div class="form-group">
                <label class="col-lg-1 control-label">权重</label>
                <div class="col-md-5">
                    <input class="form-control parsley-validated" type="number" placeholder="输入权重（数字越大越优先展示）"
                          name="weight" value="<#if banner??>${banner.weight!}</#if>">
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-1 control-label">展示位置</label>
                <div class="col-md-5">
                    <select class="form-control chzn-select" name="type" data-placeholder="选择展示位置"
                            data-parsley-required="true" data-parsley-required-message="位置不可为空">
                        <option value="1" <#if banner??&&banner.type == 1>selected</#if>>党建首页</option>
                        <option value="2" <#if banner??&&banner.type == 2>selected</#if>>党校首页</option>
                    </select>
                </div>
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
        //文件上传
        $(".insertFile").selectFile(function (clickbutton, uploadFiles) {
            if (uploadFiles.length > 0) {
                $("input[name='pic']").val(uploadFiles[0]);
                $("#banner").attr("src", uploadFiles[0]);
            }
        });

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
            url: "${basePath}/banner/addOrUpdate",
            data: $('#formTag').serialize(),
            async: false,
            error: function (request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function (data) {
                if (data.success) {
                    alertify.alert("操作成功！", function (e) {
                        location.href = "${basePath}/banner/list";
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