<#import "/master/master-frame.ftl" as master />

<#if article??>
    <#assign title=["文章管理","文章","修改文章"]>
<#else>
    <#assign title=["文章管理","文章","新增文章"]>
</#if>
<@master.masterFrame pageTitle=title>
<div class="panel panel-default">
    <div class="panel-body">
        <form id="formarticle" class="form-horizontal no-margin form-border">


            <#if article??>
                <input type="hidden" name="articleId" value="${article.articleId}"/>
                <input type="hidden" name="isUpdate" value="true"/>
            </#if>

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
                           value="<#if article??>${article.title!}</#if>">
                </div>
                <!-- /.col -->
            </div>
            <div class="form-group">
                <label class="col-lg-1 control-label"><span style="color: red">*</span>摘要</label>

                <div class="col-lg-8">
                        <textarea class="form-control parsley-validated"
                                  id="summary" name="summary" rows="3"
                                  placeholder="输入摘要"
                                  data-parsley-maxlength="500"
                                  data-parsley-maxlength-message="摘要不能超过500字"
                                  data-parsley-required="true"
                                  data-parsley-required-message="摘要不可为空"
                                ><#if article??>${article.summary!}</#if></textarea>
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
                                        ><#if article??>${article.content!}</#if></textarea>
                </div>
                <!-- /.col -->
            </div>
            <!-- /form-group -->

            <div class="form-group">
                <label class="col-md-1 control-label"><span style="color: red">*</span>发布时间</label>

                <div class="col-md-5">
                    <div class="input-group">
                        <input id="publishTime" name="publishTimeString" placeholder="请点击选择发布时间" class="form-control"
                               readonly type="text"
                               value="<#if article??>${article.publishTime?string("yyyy-MM-dd HH:mm:ss")}</#if>"
                               required data-parsley-trigger="blur" data-parsley-required-message="发布时间不可为空"/>
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                </div>
                <!-- /.col -->

                <label class="col-md-1 control-label"><span style="color: red">*</span>状态</label>

                <div class="col-md-5">
                    <select class="form-control chzn-select" id="status" name="status" data-placeholder="选择状态"
                            data-parsley-required="true" data-parsley-required-message="请选择一个状态" >
                        <option value="0" <#if article??&&article.status==0>selected</#if> >等待审核</option>
                        <option value="1" <#if article??&&article.status==1>selected</#if> >审核通过</option>
                        <option value="-1" <#if article??&&article.status==-1>selected</#if> >草稿状态</option>
                        <#if article??>
                            <option value="-2" <#if article??&&article.status==-2>selected</#if> >审核失败</option>
                            <option value="-3" <#if article??&&article.status==-3>selected</#if> >已删除</option>
                            <option value="-4" <#if article??&&article.status==-4>selected</#if> >管理员删除</option>
                        </#if>

                    </select>
                </div>
                <!-- /.col -->
            </div>
            <!-- /form-group -->

            <div class="form-group">
                <label class="col-md-1 control-label"><span style="color: red">*</span>渠道</label>
                <div class="col-md-5">
                    <select name="channels" id="channels" class="form-control chzn-select" multiple
                            data-placeholder="请选择渠道" data-parsley-required="true" data-parsley-required-message="请选择一个渠道" >
                        <option value=""></option>
                            <#list articleChannelList as articleChannel >
                                <option value="${articleChannel.channelId}"
                                        <#if article??&&article.articleChannelModelList??>
                                            <#list article.articleChannelModelList as channel1>
                                                <#if channel1.channelId==articleChannel.channelId>selected</#if>
                                            </#list>
                                        </#if>
                                        >${articleChannel.name!}</option>
                            </#list>
                    </select>
                </div>
                <div class="col-md-2 pull-right">
                    <button type="button" class="btn btn-sm-2 btn-warning" id="preview"
                            onclick="javascript:$.previewDialog();">预览
                    </button>
                </div>
            </div>
            <!-- /form-group -->

            <div class="panel-footer text-center">
                <button type="button" class="btn btn-success" id="submitButton">提交</button>
                <button type="button" class="btn btn-default" onclick="history.go(-1);">取消</button>
            </div>

            <!-- 防止下拉框显示不全 -->
            <br><br><br><br><br><br><br><br><br><br>
        </form>
    </div>
</div><!-- /panel -->

<!-- 预览 样式  -->
<style>
    .floatingBtn{
        position:fixed;
        right:-45%;
        top:20px;
        filter:alpha(opacity=80);
        opacity:0.8;
        font-size: 20px;
        z-index:9999999;
        background-color: #ffffff;
        width: 60px;
    }
    .floatingBtn a{
        color:#000000 ;
        margin-left: 6px;
    }
    .floatingBtn a:hover{
        cursor: pointer;
    }
    .previewContent{
        width:150%;
        left:-15%;
    }
    #progressBar{
        height: 3%;
        left: 40%;
        position: fixed;
        top: 48%;
        width: 20%;
    }

    .article-detail .aricle-show{padding:40px;line-height: 26px;  max-height: 670px;overflow-y: auto;
        color: #333;margin: 0;}
    .article-detail .aricle-show img{max-width:100%;}
    .article-detail .aricle-show a{color:#06c;text-decoration: underline;}
</style>

<div id="previewDialog" class="modal fade" style="display: none;" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content previewContent" >
            <div class="modal-body">

                    <div class="mod_main">
                        <div class="article-detail">
                            <div class="aricle-show">

                            </div>
                        </div>
                    </div>

                    <div id="floatingBtn" class="floatingBtn"  onClick="jQuery('#previewDialog').modal('hide');">
                       <a> 关闭</a>
                    </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<!-- 预览 样式  -->
<!-- 关键字替换进度条  -->
<div id="progressBar" class="progress progress-striped active" style="display: none">
    <div class="progress-bar progress-bar-warning" style="width: 100%;"></div>
</div>


<link href="${basePath}/resources/js/timepicker/jquery-ui-timepicker-addon.min.css" rel="stylesheet" type="text/css"/>
<script src="${basePath}/resources/js/timepicker/jquery-ui-timepicker-addon.min.js" type="text/javascript"></script>
<script src="${basePath}/resources/js/timepicker/jquery-ui-timepicker-zh-CN.js" type="text/javascript"></script>

<script language="javascript">

    $(function () {
        //时间选择器
        $('#publishTime').datetimepicker({
            dateFormat: 'yy-mm-dd',
            timeFormat: "HH:mm:ss",
//            minDate: new Date()
            //maxDate: new Date()
        });
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

        //预览
        $.previewDialog = function(){
            var ue = UE.getEditor('content');
            var  content = ue.getContent();
            $(".aricle-show").html(content);
            $("#previewDialog").modal('show');
        };

        //无其他网站链接检查
        var noOtherHref = function(hrefInPage){
            var ue = UE.getEditor('content');
            var content = ue.getContent();

            var a_reg=/<a[^>]*href=['"]([^"]*)['"].*?[^>]*>(.*?)<\/a>/g;

            while(a_reg.exec(content)!=null)  {
                var href=RegExp.$1;
                if(href.indexOf(hrefInPage)<0){
                   return false;
                }
            }
            return true;
        };

        $("#submitButton").click(function () {
//            if(!noOtherHref(".yiminbang.com")){
//                alertify.alert("出现其他网站链接！");
//                return;
//            }
            if (!$('#formarticle').parsley().validate()) {
                alertify.alert("校验失败");
                return;
            }
//            if($("#isSEO").is(':checked') && !SEO_validate()){
//                return;
//            }

            $.submitarticle();
        });

    });

    $.submitarticle = function () {
        $.ajax({
            cache: true,
            type: "POST",
            url: "${basePath}/article/addOrUpdate",
            data: $('#formarticle').serialize(),
            async: false,
            error: function (request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function (data) {
                if (data.success) {
                    alertify.alert("操作成功！", function (e) {
                        location.href = "${basePath}/article/list";
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