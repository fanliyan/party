<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame showNotice=false >

<div id="portfolio" class="bg-light">
    <div class="section-header">
        <hr class="left visible-lg">
        <span>学习笔记</span>
        <hr class="right visible-lg"></div>
    <div class="container">
        <div class="panel panel-default table-responsive">
            <div class="panel-heading">
                <span class="label label-info pull-right">${(response.studyNoteModelList?size)!"0"} 篇</span>
            </div>
            <form id="searchForm">
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-4 col-sm-4">
                        <a class="btn btn-warning btn-sm" href="${basePath}/note/add">添加笔记</a>
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </div>
            </form>
            <table class="table table-striped" id="responsiveTable">
                <thead>
                <tr>
                    <th>
                        <label class="label-checkbox">
                            <input type="checkbox" id="chk-all">
                            <span class="custom-checkbox"></span>
                        </label>
                    </th>
                    <th>笔记ID</th>
                    <th>标题</th>
                    <th>创建日期</th>
                    <th>最后修改日期</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                    <#if response.studyNoteModelList??&&response.studyNoteModelList?size gt 0>
                        <#list response.studyNoteModelList as note>
                        <tr>
                            <td>
                                <label class="label-checkbox">
                                    <input type="checkbox" class="chk-row">
                                    <span class="custom-checkbox"></span>
                                </label>
                            </td>
                            <td>${note.id!}</td>
                            <td>${note.title}</td>
                            <td>${note.createTime?string('yyyy-MM-dd')}</td>
                            <td>${note.lastModifyTime?string('yyyy-MM-dd')}</td>
                            <td>
                                <#if note.status==0>
                                    <span class="label label-info">未发布</span>
                                <#elseif note.status==1>
                                    <span class="label label-warning">审核中</span>
                                <#elseif note.status==2>
                                    <span class="label label-success">通过</span>
                                <#elseif note.status==-1>
                                    <span class="label label-danger">不通过</span>
                                </#if>
                            </td>
                            <td>
                                <#if note.status==0>
                                    <a class="btn btn-md btn-default" href="${basePath}/note/edit/${note.id}">编辑</a>
                                    <button class="btn btn-md btn-danger" onclick="$.delete(${note.id});">删除</button>
                                <#elseif note.status==1>
                                <#elseif note.status==2>
                                <#elseif note.status==-1>
                                    <a class="btn btn-md btn-default" href="${basePath}/note/edit/${note.id}">编辑</a>
                                    <button class="btn btn-md btn-danger" onclick="$.delete(${note.id});">删除</button>
                                </#if>

                                <#if note.status==0>
                                    <button class="btn btn-info" onclick="$.changeStatus(${note.id},1);">提交审核</button>
                                <#elseif note.status==1>
                                    <button class="btn btn-warning" onclick="$.changeStatus(${note.id},0);">取消审核</button>
                                <#elseif note.status==2>
                                    <button class="btn btn-success" onclick="$.changeStatus(${note.id},0);">取消发布</button>
                                <#elseif note.status==-1>
                                    <button class="btn btn-danger" onclick="$.changeStatus(${note.id},1);">重新审核</button>
                                </#if>
                            </td>
                        </tr>
                        </#list>
                    <#else>
                    <tr><td colspan="5
                ">您还没有笔记</td></tr>
                    </#if>
                </tbody>
            </table>
            <form id="searchForm" action="${basePath}/mote/list"></form>
            <#if response.studyNoteModelList?? && response.studyNoteModelList?size gt 0>
                <@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />
            </#if>
        </div>
    </div>
</div>


<div class="content-padding bg-white">
    <div class="container">
        <div class="panel">
            <div class="panel-body content-padding">
                <div class="pull-left">
                    <p class="font-lg">向他人学习</p>
                    <p class="text-muted">了解更多党校知识</p>
                </div>
                <a href="${basePath}/note/sharelist"
                   class="btn btn-lg btn-danger pull-right m-top-xs no-animation animated-element">总结交流</a>
            </div>
        </div>
    </div>
</div>

</@master.masterFrame>
<script>
    $(function()	{
        $('.animated-element').waypoint(function() {

            $(this).removeClass('no-animation');

        }, { offset: '70%' });

        $('.nav').localScroll({duration:800});
    });
</script>
<script language="javascript">
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
    $.delete = function (id) {
        alertify.confirm("是否删除，一经删除无法恢复?", function (e) {
            if (e) {
                $.ajax({
                    cache: true,
                    type: "POST",
                    url: "${basePath}/note/delete/"+id,
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