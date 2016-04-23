<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["课程管理","笔记审核","待审列表"]>

<div class="panel panel-default table-responsive">
    <div class="panel-heading">条件搜索</div>
    <div class="panel-body">
        <form id="searchForm" class="form-inline no-margin" action="${basePath}/note/list" method="post">

            <div class="row">
                <#--<div class="col-md-2">-->
                    <#--<div class="form-group" style="margin-right:10px;">-->
                        <#--<label class="control-label">文章名称</label>-->
                        <#--<div class="">-->
                            <#--<input name="title" type="text" class="form-control input-sm"-->
                                   <#--value="<#if article??>${article.title!}</#if>"/>-->
                        <#--</div>-->
                    <#--</div>-->
                    <#--<!-- /form-group &ndash;&gt;-->
                <#--</div>-->

                <div class="col-md-2">
                    <div class="form-group">
                        <label class="control-label">状态</label>
                        <select class="form-control chzn-select" id="status" name="status" data-placeholder="选择状态"
                                data-parsley-errors-container="#status_Error">
                            <option value="">选择状态</option>
                            <option value="1" <#if studyNoteModel??&&studyNoteModel.status??&&studyNoteModel.status==1>selected</#if>>等待审核
                            </option>
                            <option value="2" <#if studyNoteModel??&&studyNoteModel.status??&&studyNoteModel.status==2>selected</#if>>审核通过
                            </option>
                        </select>
                    </div>
                    <!-- /form-group -->
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-sm btn-success" style="margin:20px;">
                        <i class="fa fa-search" style="font-size:16px;"></i></button>
                </div>
            </div>
            <!-- /form-group -->

        </form>
    </div>
<#--<div class="panel-body">-->
<#--<a class="btn btn-xs btn-info" href="${basePath}/article/add"><i class="fa fa-plus fa-lg"></i> 新增</a>-->
<#--</div>-->
    <style>
        #responsiveTable tbody td {
            vertical-align: middle;
            text-align: center;
        }

        #responsiveTable thead th {
            /*vertical-align: middle;*/
            text-align: center;
        }
    </style>
    <table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
        <thead>
        <tr>
            <th>笔记ID</th>
            <th>笔记标题</th>
            <th>笔记作者</th>
            <th>笔记状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <style>
            .tooltip.fade.top.in {
                width: auto;
            }

            .tooltip.fade.top .tooltip-inner {
                max-width: 40em;
                word-break: keep-all;
                white-space: nowrap;
                background-color: #ffffff;
                color: #777;
                border: 1px solid rgba(0, 0, 0, .1);
                box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
                border-color: rgba(0, 0, 0, .2);
            }

            .tooltip.top .tooltip-arrow {
                border-top-color: rgba(0, 0, 0, .2);
                border-width: 10px;
                border-bottom-width: 0;
                bottom: -5px;
            }

            .tooltip.top .tooltip-arrow:after {
                position: absolute;
                display: block;
                bottom: 1px;
                left: -10px;
                width: 0;
                height: 0;
                border-color: transparent;
                border-style: solid
            }

            .tooltip.top .tooltip-arrow:after {
                border-width: 10px;
                border-bottom-width: 0;
                content: "";
                border-top-color: #fff;
            }

            popover-content {
                word-break: keep-all
            }
        </style>
        <tbody>
            <#if response.studyNoteModelList?? && response.studyNoteModelList?size gt 0>
                <#list response.studyNoteModelList as note>
                <tr>
                    <td>${note.id!}</td>
                    <td>${note.title}</td>
                    <td>${(note.studentModel.name)!}</td>
                    <td>
                        <#if note.status==1>
                            <span class="label label-danger">待审核</span>
                        <#elseif note.status==2>
                            <span class="label label-success">通过</span>
                        </#if>
                    </td>
                    <td>
                        <button class="btn btn-xs btn-warning" title="查 看" onclick="$.check(${note.id});">
                            审 核</button>

                        <style>
                            .dropdown-menu{min-width: 5em;max-width: 7em;}
                        </style>
                        <#if note.status==1>
                            <div class="btn-group">
                                <button data-toggle="dropdown" class="btn btn-xs btn-default dropdown-toggle" title="状 态"><i class="fa fa-tasks"></i><span class="caret"></span></button>
                                <ul class="dropdown-menu" style="width: auto;">
                                    <li><a href="javascript:$.changeStatus(${note.id},-1);">审核失败</a></li>
                                    <li class="divider"></li>
                                    <li><a href="javascript:$.changeStatus(${note.id},2);">审核通过</a></li>
                                </ul>
                            </div>
                        <#elseif note.status==2>
                            <div class="btn-group">
                                <button data-toggle="dropdown" class="btn btn-xs btn-default dropdown-toggle" title="状 态"><i class="fa fa-tasks"></i><span class="caret"></span></button>
                                <ul class="dropdown-menu" style="width: auto;">
                                    <li><a href="javascript:$.changeStatus(${note.id},0);">取消发布</a></li>
                                    <li class="divider"></li>
                                    <li><a href="javascript:$.changeStatus(${note.id},-1);">审核失败</a></li>
                                </ul>
                            </div>
                        </#if>
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
    <#if response.studyNoteModelList?? && response.studyNoteModelList?size gt 0>
        <@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />
    </#if>

    </div><!-- /panel -->

<div  id="review-modal" class="modal fade" style="display: none;" aria-hidden="true">
    <div class="modal-content">
        <div class="modal-header">
            <a class="close" data-dismiss="modal">×</a>
            <h3 id="modal-title"></h3>
        </div>
        <div class="modal-body" id="modal-content">

        </div>
        <div class="modal-footer">
            <#--<a href="javascript:;" class="btn btn-danger" data-dismiss="modal" id="fail-modal">审核不通过</a>-->
            <#--<a href="javascript:;" class="btn btn-success" data-dismiss="modal" id="success-modal">审核通过</a>-->
        </div>
        <input type="hidden" name="noteIdInModal" value="">
    </div>
</div>

    <script>
        $(function () {
            $("[data-toggle='popover']").popover({
                html: true
            });
        });
    </script>
    <script>
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
        $.check = function (id) {

            if($("input[noteIdInModal]").val()==id){
                $("#review-modal").modal();
                return;
            }

            $.ajax({
                cache: true,
                type: "GET",
                url: "${basePath}/note/getnote/"+id,
                data:null,
                async: false,
                error: function (request) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function (data) {
                    if (data.success) {

                        $("input[noteIdInModal]").val(id);

                        $("#modal-title").html(data.note.title);
                        $("#modal-content").html(decodeURIComponent(data.note.content));

                        $("#review-modal").modal();
                    }
                    else {
                        alertify.alert("错误:" + data.message);
                    }
                }
            });
        };

        $(function(){
           $("#fail-modal").on("click",function(){
               $.changeStatus($("input[noteIdInModal]").val(id), -1);
           });
            $("#success-modal").on("click",function(){
                $.changeStatus($("input[noteIdInModal]").val(id), 2);
            });
        });
    </script>
</@master.masterFrame>