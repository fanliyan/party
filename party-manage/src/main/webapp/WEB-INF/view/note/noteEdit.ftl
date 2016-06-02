<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["课程管理","笔记审核","编辑"]>

<div class="panel panel-default table-responsive">
    <div class="panel-body">
        <form id="formarticle" class="form-horizontal no-margin form-border">

            <input type="hidden" name="id" value="${note.id}"/>

            <!-- /form-group -->
            <div class="form-group">
                <label class="col-lg-1 control-label"><span style="color: red">*</span>标题</label>

                <div class="col-lg-5">
                    <input class="form-control parsley-validated" type="text" placeholder="输入标题"
                           data-parsley-required="true" name="title" id="title"
                           data-parsley-minlength="4"
                           data-parsley-maxlength="30"
                           data-parsley-minlength-message="标题不能小于4字"
                           data-parsley-maxlength-message="标题不能超过30字"
                           value="${(note.title)!}">
                </div>
                <!-- /.col -->
            </div>
            <!-- /form-group -->

            <style>
                .edui-default  input[type=checkbox], input[type=radio]{
                    opacity: 1;
                    position: inherit;
                    width: inherit;
                    height: inherit;
                }
            </style>
            <div class="form-group">
                <label class="col-md-1 control-label"><span style="color: red">*</span>内容</label>

                <div class="col-md-11" style="z-index: 0">
                                <textarea id="content" name="content" class="wysihtml5"

                                          data-parsley-required="true"
                                          placeholder="内容必填"
                                          data-parsley-required-message="内容不可为空"
                                >${(note.content)!}</textarea>
                </div>
                <!-- /.col -->
            </div>
            <!-- /form-group -->

            <div class="panel-footer text-center">
                <button type="button" class="btn btn-success" id="submitButton">保存</button>
                <button type="button" class="btn btn-default" onclick="history.go(-1);">取消</button>
            </div>

            <!-- 防止下拉框显示不全 -->
            <br><br><br><br><br><br><br><br><br><br>
        </form>

    </div>
    </div><!-- /panel -->


    <script>
        $(function () {
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
                    initialFrameHeight: 500,
                    initialFrameWidth: "100%",
                    minFrameWidth: 100,
                    maximumWords: 100000,
                    scaleEnabled:true,
                    enableAutoSave:false,
                    iframeCssUrl :"${basePath}/resources/css/manage-article-ueditor-a.css",
                });

            });


            $("#submitButton").click(function () {
                if (!$('#formarticle').parsley().validate()) {
                    alertify.alert("校验失败");
                    return;
                }

                $.submitarticle();
            });
        });
    </script>
    <script>

        $.submitarticle = function () {
            $.ajax({
                cache: true,
                type: "POST",
                url: "${basePath}/note/addOrUpdate",
                data: $('#formarticle').serialize(),
                async: false,
                error: function (request) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function (data) {
                    if (data.success) {
                        alertify.alert("操作成功！", function (e) {
                            location.href = "${basePath}/note/list";
                        });
                    }
                    else {
                        alertify.alert("错误:" + data.message);
                    }
                }
            });
        };
        $.changeStatus = function (id, status) {
            alertify.confirm("是否修改状态?", function (e) {
                if (e) {
                    $.ajax({
                        cache: true,
                        type: "POST",
                        url: "${basePath}/note/changeStatus/"+id+"/"+status,
                        data:null,
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
                }
            });
        };

    </script>
</@master.masterFrame>