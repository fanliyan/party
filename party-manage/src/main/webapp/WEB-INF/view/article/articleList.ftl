<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["文章管理","文章","文章列表"]>

<#--<div class="alert-animated">-->
<div>
    <div class="alert-inner">
        <div class="" style="color: red;text-align: center;">
        <#--<div class="alert-message" >-->
            注意：爬虫文章默认草稿状态 列表默认不显示草稿文章
        </div>
    </div>
</div>

<div class="panel panel-default table-responsive">
    <div class="panel-heading">条件搜索  </div>
    <div class="panel-body">
        <form id="searchForm" class="form-inline no-margin" action="${basePath}/article/list" method="post">

            <div class="row">
                <div class="col-md-2">
                    <div class="form-group" style="margin-right:10px;">
                        <label class="control-label">文章名称</label>
                        <div class="">
                            <input name="title" type="text" class="form-control input-sm" value="<#if article??>${article.title!}</#if>"/>
                        </div>
                    </div>
                    <!-- /form-group -->
                </div>

            <link href="${basePath}/resources/js/timepicker/jquery-ui-timepicker-addon.min.css" rel="stylesheet" type="text/css"/>
            <script src="${basePath}/resources/js/timepicker/jquery-ui-timepicker-addon.min.js" type="text/javascript"></script>
            <script src="${basePath}/resources/js/timepicker/jquery-ui-timepicker-zh-CN.js" type="text/javascript"></script>

                <div class="col-md-2">
                    <div class="form-group" >
                        <label class="control-label">状态</label>
                        <select class="form-control chzn-select" id="status" name="status" data-placeholder="选择状态"
                                data-parsley-errors-container="#status_Error">
                            <option value="" >选择状态</option>
                            <option value="0" <#if article??&&article.status??&&article.status==0>selected</#if> >等待审核</option>
                            <option value="1" <#if article??&&article.status??&&article.status==1>selected</#if> >审核通过</option>
                            <option value="-1" <#if article??&&article.status??&&article.status==-1>selected</#if> >草稿状态</option>
                            <option value="-2" <#if article??&&article.status??&&article.status==-2>selected</#if> >审核失败</option>
                            <option value="-3" <#if article??&&article.status??&&article.status==-3>selected</#if> >已删除</option>
                            <option value="-4" <#if article??&&article.status??&&article.status==-4>selected</#if> >管理员删除</option>
                        </select>
                    </div>
                    <!-- /form-group -->
                </div>
                <div class="col-md-2">
                    <div class="form-group" >
                        <label class="control-label">渠道</label>
                        <select class="form-control chzn-select" id="channelId" name="channelCount" data-placeholder="选择渠道"
                                data-parsley-errors-container="#channelId_Error">
                            <option value="" >选择渠道</option>
                            <#if articleChannelList??>
                                <#list articleChannelList as articleChannel >
                                    <option value="${articleChannel.channelId!}" <#if article??&&article.channelCount??&&article.channelCount == articleChannel.channelId>selected</#if> >${articleChannel.name!}</option>
                                </#list>
                            </#if>
                        </select>
                    </div>
                    <!-- /form-group -->
                </div>

                <div class="col-md-2">
                    <div class="form-group ">
                        <label class="control-label">最小发布时间</label>
                        <div class="input-group">
                            <input id="publishTimeStartString" name="publishTimeStartString" placeholder="请点击选择时间" class="form-control"
                                   type="text" value="<#if publishTimeStart??>${publishTimeStart?string("yyyy-MM-dd HH:mm:ss")}</#if>"  data-parsley-trigger="blur"  />
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                    </div><!-- /form-group -->
                </div>
                <div class="col-md-2">
                    <div class="form-group ">
                        <label class="control-label">最大发布时间</label>
                        <div class="input-group">
                            <input id="publishTimeEndString" name="publishTimeEndString" placeholder="请点击选择时间" class="form-control"
                                   type="text" value="<#if publishTimeEnd??>${publishTimeEnd?string("yyyy-MM-dd HH:mm:ss")}</#if>"  data-parsley-trigger="blur"  />
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                    </div><!-- /form-group -->
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-sm btn-success" style="margin:20px;">
                        <i class="fa fa-search" style="font-size:16px;"></i></button>
                </div>
            </div>
            <!-- /form-group -->

        </form>
        <script>
            $(function(){
                //时间选择器
                $('#publishTimeStartString,#publishTimeEndString').datetimepicker({
                    dateFormat: 'yy-mm-dd',
                    timeFormat: "HH:mm:ss"
                });
            });
        </script>
    </div>
    <div class="panel-body">
        <a class="btn btn-xs btn-info" href="${basePath}/article/add"><i class="fa fa-plus fa-lg"></i> 新增</a>
    </div>
    <style>
        #responsiveTable tbody td{
            vertical-align: middle;
            text-align: center;
        }
        #responsiveTable thead th{
            /*vertical-align: middle;*/
            text-align: center;
        }
    </style>
    <table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable"  >
        <thead>
        <tr>
            <th>文章ID</th>
            <th>文章封面</th>
            <th>标题</th>
            <th>点击数</th>
            <th>发布时间</th>
            <th>修改记录</th>
            <th>创建人</th>
            <th>状态</th>
            <th>最后修改时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <style>
            .tooltip.fade.top.in{width: auto;}
            .tooltip.fade.top .tooltip-inner{max-width:40em;word-break:keep-all;white-space:nowrap;background-color: #ffffff;color: #777;border: 1px solid rgba(0,0,0,.1);box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);border-color:rgba(0,0,0,.2);}
            .tooltip.top .tooltip-arrow{border-top-color: rgba(0,0,0,.2);border-width:10px;border-bottom-width: 0;bottom:-5px;}
            .tooltip.top .tooltip-arrow:after{position:absolute;display:block;bottom:1px;left:-10px;width:0;height:0;border-color:transparent;border-style:solid}
            .tooltip.top .tooltip-arrow:after{border-width:10px;border-bottom-width: 0;content:"";border-top-color: #fff;}
            popover-content{word-break: keep-all}
        </style>
        <tbody>
            <#if response.articleModelList?? && response.articleModelList?size gt 0>
                <#list response.articleModelList as article>
                <tr>
                    <td>
                    ${article.articleId!}
                    </td>
                    <td style="min-width: 100px;">
                        <div class="row">
                            <div class="col">
                                <a class="cboxElement " href="javascript:$.changeCoverImg(${article.articleId!});">
                                    <img src="
                            <#if article.coverUrl??>
                                ${article.coverUrl}
                             <#else >
                            ${basePath}/resources/images/picture100x100.jpg
                            </#if>
                            " alt="点击上传封面图" width="100px" height="100px">
                                </a>
                                <div style="display: none">
                                    <input name="${article.articleId!}" id="${article.articleId!}"
                                           class="form-control insertFile" maxfile="1" data-target="#${article.articleId!}"
                                           type="text" placeholder="点击上传封面图"/>
                                </div>
                            </div>
                        </div>

                    </td>

                    <td>
                        <div title="" data-placement="top" data-toggle="tooltip" class="tooltip-test" data-original-title="
                        ${article.title}"> <#if article.title??&&article.title?length lt 10>
                        ${article.title}
                        <#else >
                        ${article.title?substring(0,10)}
                        </#if></div>
                    </td>

                    <td>
                    ${article.countclick!}
                    </td>

                    <td><div class="col">${article.publishTime?string('yyyy-MM-dd')}</div>
                        <div class="col">${article.publishTime?string('HH:mm:ss')}</div></td>

                    <td>
                    <#--<div class="col"><#if article.lastModifyTime??>${article.lastModifyTime?string('yyyy-MM-dd HH:mm:ss')}</#if></div>-->
                    <#--<div class="col">-->
                        <a class="btn btn-xs btn-primary"
                           href="${basePath}/articleHistory/list?articleId=${article.articleId}"
                           title="最后修改时间：<#if article.lastModifyTime??>${article.lastModifyTime?string('yyyy-MM-dd HH:mm:ss')}</#if>"
                                >操作历史</a>
                    <#--</div>-->
                    </td>

                    <td>${(article.userModel.name)!}</td>

                    <td>
                        <#if article.status==1  >
                            <label class="label label-success" >审核通过</label>
                        <#elseif article.status==0>
                            <label class="label label-info" >等待审核</label>
                        <#elseif article.status==-1>
                            <label class="label label-info" >草稿状态</label>
                        <#elseif article.status==-2>
                            <label class="label label-warning" >审核失败</label>
                        <#elseif article.status==-3>
                            <label class="label label-danger" >已删除</label>
                        <#elseif article.status==-4>
                            <label class="label label-danger" >管理员删除</label>
                        </#if>
                    </td>

                    <td>${article.lastModifyTime?string('yyyy-MM-dd HH:mm:ss')}</td>

                    <td>
                        <#--<button title=""-->
                                <#--data-content="-->
                                    <#--创建人：<#if article.userModel??>${article.userModel.name!}</#if><br>-->
                                    <#--最后修改时间：<#if article.lastModifyTime??>${article.lastModifyTime?string('yyyy-MM-dd HH:mm:ss')}</#if><br>-->
                                    <#--"-->
                                <#--data-placement="top" data-toggle="popover" data-container="body" class="btn btn-info btn-xs poptext" type="button">-->
                            <#--<i class="fa fa-bars"></i>-->
                        <#--</button>-->

                        <!-- 如果前台能看见直接跳前台 -->
                        <a class="btn btn-xs btn-primary" target="_blank"
                           href="
                               <#if article.status ==1 && article.publishTime?datetime lt .now?datetime>
                                 http://www.yiminbang.com/article/detail-${article.articleId}.html
                                   <#else >
                               ${basePath}/article/previewArticle?articleId=${article.articleId}
                               </#if>
                               " title="预 览">
                            <i class="fa fa-search"></i>
                        </a>

                        <a class="btn btn-xs btn-success"
                           href="${basePath}/article/edit?articleId=${article.articleId}"><i
                                class="fa fa-edit" title=" 编 辑"></i></a>

                        <style>
                            .dropdown-menu{min-width: 5em;max-width: 7em;}
                        </style>
                        <div class="btn-group">
                            <button data-toggle="dropdown" class="btn btn-xs btn-default dropdown-toggle" title="状 态"><i class="fa fa-tasks"></i><span class="caret"></span></button>
                            <ul class="dropdown-menu" style="width: auto;">
                                <li><a href="javascript:$.changeStatus(${article.articleId},-1);">草稿状态</a></li>
                                <li><a href="javascript:$.changeStatus(${article.articleId},0);">等待审核</a></li>
                                <li><a href="javascript:$.changeStatus(${article.articleId},-2);">审核失败</a></li>
                                <li class="divider"></li>
                                <li><a href="javascript:$.changeStatus(${article.articleId},1);">审核通过</a></li>
                            </ul>
                        </div>

                        <a class="btn btn-xs btn-danger" href="javascript: $.del(${article.articleId});"><i
                                class="fa fa-times" title=" 删 除"></i></a>
                    <#--</div>-->
                    <#--<br>-->
                    <#--<div class="col">-->
                    <#--<button class="btn btn-xs btn-warning" type="button"-->
                    <#--onclick="javascript:$.changeStatus(${article.articleId},-1);">草稿状态-->
                    <#--</button>-->
                    <#--<button class="btn btn-xs btn-warning" type="button"-->
                    <#--onclick="javascript:$.changeStatus(${article.articleId},0);">等待审核-->
                    <#--</button>-->
                    <#--<button class="btn btn-xs btn-warning" type="button"-->
                    <#--onclick="javascript:$.changeStatus(${article.articleId},-2);">审核失败-->
                    <#--</button>-->
                    <#--<button class="btn btn-xs btn-success" type="button"-->
                    <#--onclick="javascript:$.changeStatus(${article.articleId},1);">审核通过-->
                    <#--</button>-->
                    <#--</div>-->

                    </td>
                </tr>
                </#list>
            <#else>
            <tr>
                <td colspan=15 class="text-center">没有数据</td>
            </tr>
            </#if>
        </tbody>
    </table>
    <#if response.articleModelList?? && response.articleModelList?size gt 0>
        <@splitPage1.splitPage pageCount=(response.splitPage.pageCount)!1 pageNo=(response.splitPage.pageNo)!1 formId="searchForm" recordCount=(response.splitPage.recordCount)!0 />
    </#if>

</div><!-- /panel -->
</div>

<script src="${basePath}/resources/js/ymb.selectAndUploadFile.js"></script>
<script>
    $(function(){
        $("[data-toggle='popover']").popover({
            html : true
        });
    });
</script>
<script language="javascript">
    $.del = function (id) {
        alertify.confirm("注意，一经删除，无法恢复！是否继续？", function (e) {
            if (e) {
                $.ajax({
                    cache: true,
                    type: "POST",
                    url: "${basePath}/article/del",
                    data: "articleId=" + id,
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
    $.changeStatus = function (id, status) {
        alertify.confirm("是否修改状态?",function(e){
            if(e){
                $.ajax({
                    cache: true,
                    type: "POST",
                    url: "${basePath}/article/changeStatus",
                    data: {
                        "articleId": id
                        , "status": status
                    },
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

    $.changeCoverImg = function (id) {
        $("#" + id).click();
    };
    //文件上传
    $(".insertFile").selectFile(function (clickbutton, uploadFiles) {
        if (uploadFiles.length > 0) {
            $.ajax({
                cache: true,
                type: "POST",
                url: "${basePath}/article/changeCoverImg",
                data: {
                    "articleId": clickbutton.attr("id")
                    , "coverImg": uploadFiles[0]
                },
                async: false,
                error: function (request) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function (data) {
                    if (data.success) {
                        location.href = "${basePath}/article/list";
                    }
                    else {
                        alertify.alert("错误:" + data.message);
                    }
                }
            });
        }
    });

    $.recommend = function (id, status) {
        $.ajax({
            cache: true,
            type: "POST",
            url: "${basePath}/article/recommend",
            data: {
                "articleId": id
                , "status": status
            },
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