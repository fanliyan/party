<#import "/master/master-frame.ftl" as master />
<#if banner??>
    <#assign title=["商城数据维护","banner管理","修改banner"]>
<#else>
    <#assign title=["商城数据维护","banner管理","新增banner"]>
</#if>
<@master.masterFrame pageTitle=title>
<div class="panel panel-default">
    <div class="panel-body">
        <form id="formTag" class="form-horizontal no-margin form-border">

            <#if banner??>
                <input type="hidden" name="bannerConfigId" value="${banner.bannerConfigId!}"/>
                <input type="hidden" name="isUpdate" value="true"/>
            </#if>
            <div class="form-group">
                <label class="col-lg-1 control-label">banner图</label>
                <div class="col-lg-5">
                    <img id="banner"
                         src="<#if banner?? && banner.bannerImg?? && banner.bannerImg?length gt 0>${banner.bannerImg + '@100h_200w_0e'}</#if>">
                    <input name="bannerImg" class="form-control insertFile" maxfile="1"
                           value="<#if banner??>${banner.bannerImg!}</#if>"
                           data-target="#banner" type="text" required="" data-parsley-required-message="请上传banner图"
                           data-parsley-trigger="blur" placeholder="请点击上传banner图"/>
                </div><!-- /.col -->
            </div>
            <div class="form-group">
                <label class="col-lg-1 control-label">链接</label>
                <div class="col-md-5">
                    <input class="form-control parsley-validated" type="text" placeholder="点击banner后跳转链接"
                           data-parsley-maxlength="100"
                           data-parsley-maxlength-message="链接不能超过100字符"
                           data-parsley-required="true" name="bannerLink"
                           value="<#if banner??>${banner.bannerLink!}</#if>">
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-1 control-label">权重</label>
                <div class="col-md-5">
                    <input class="form-control parsley-validated" type="number" placeholder="输入权重（数字越大越优先展示）"
                           data-parsley-required="true" name="bannerWeight"
                           value="<#if banner??>${banner.bannerWeight!}</#if>">
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-1 control-label">展示位置</label>
                <div class="col-md-5">
                    <select class="form-control chzn-select" name="bannerPosition" data-placeholder="选择展示位置"
                            data-parsley-required="true" data-parsley-required-message="位置不可为空">
                        <option value="home" <#if banner??&&banner.bannerPosition == 'home'>selected</#if>>home（首页）
                        </option>
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
                $("input[name='bannerImg']").val(uploadFiles[0]);
                $("#banner").attr("src", uploadFiles[0] + '@100h_200w_0e');
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
            url: "${basePath}/mallbanner/addOrUpdate",
            data: $('#formTag').serialize(),
            async: false,
            error: function (request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function (data) {
                if (data.success) {
                    alertify.alert("操作成功！", function (e) {
                        location.href = "${basePath}/mallbanner/list";
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