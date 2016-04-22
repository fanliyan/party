<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["课程管理","年度要求","年度要求列表"]>

<div class="panel panel-default table-responsive">

    <div class="panel-heading">条件搜索</div>
    <div class="panel-body">

        <div class="col-md-12">
            <form id="searchForm" class="form-inline no-margin" action="${basePath}/task/list" method="post">
                <div class="col-md-2">
                    <div class="form-group" style="margin-right:10px;">
                        <label class="control-label">标签类别名称</label>
                        <input name="name" type="text" class="form-control input-sm" value="${(taskModel.name)!}"/>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="form-group" style="margin-right:10px;">
                        <label class="control-label">标签类别名称</label>
                        <select class="form-control chzn-select" id="channelId" name="roleId" data-placeholder="选择角色"
                                data-parsley-errors-container="#channelId_Error">
                            <option value="" >选择角色</option>
                            <#if roleList??>
                                <#list roleList as role >
                                    <option value="${role.roleId!}" <#if taskModel??&&taskModel.roleId??&&taskModel.roleId == role.roleId>selected</#if> >${role.name!}</option>
                                </#list>
                            </#if>
                        </select>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="form-group ">
                        <label class="control-label">开始时间</label>
                        <div class="input-group">
                            <input id="publishTimeStartString" name="startTime" placeholder="请点击选择时间"
                                   class="form-control"
                                   type="text"
                                   value="${(startTime?string("yyyy-MM-dd HH:mm:ss"))!}"
                                   data-parsley-trigger="blur"/>
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                    </div><!-- /form-group -->
                </div>
                <div class="col-md-2">
                    <div class="form-group ">
                        <label class="control-label">结束时间</label>
                        <div class="input-group">
                            <input id="publishTimeEndString" name="endTime" placeholder="请点击选择时间"
                                   class="form-control"
                                   type="text"
                                   value="${(endTime?string("yyyy-MM-dd HH:mm:ss"))!}"
                                   data-parsley-trigger="blur"/>
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                    </div><!-- /form-group -->
                </div>
                <div class="col-md-1">
                    <button type="submit" class="btn btn-sm btn-success"><i class="fa fa-search"
                                                                            style="font-size:16px;"></i></button>
                </div>
            </form>
        </div>
        <div class="panel-body ">
            <a class="btn btn-xs btn-info" href="${basePath}/task/add"><i class="fa fa-plus fa-lg"></i> 新增</a>
        </div>
    </div>
    <div class="padding-md clearfix">
        <table class="table table-condensed table-hover table-striped" id="dataTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>名称</th>
                <th>目标分数</th>
                <th>目标时间（分钟）</th>
                <th>开始时间</th>
                <th>结束时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
                <#if response.taskModelList?? && response.taskModelList?size gt 0>
                    <#list response.taskModelList as task>
                    <tr>
                        <td>${task.id!}</td>
                        <td>${task.name!}</td>
                        <td>${task.targetScore!}</td>
                        <td>${(task.startTime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
                        <td>${(task.endTime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
                        <td>${task.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                        <td>${task.lastModifyTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                        <td>
                            <a class="btn btn-xs btn-success" href="${basePath}/task/edit?id=${task.id}">
                                <i class="fa fa-edit fa-lg"></i> 修改</a>
                            <a class="btn btn-xs btn-danger" href="javascript:$.del(${task.id});">
                                <i class="fa fa-edit fa-lg"></i> 删除</a>
                        </td>
                        de
                    </tr>
                    </#list>
                <#else>
                <tr>
                    <td colspan=5 class="text-center">没有数据</td>
                </tr>
                </#if>
            </tbody>
        </table>
        <#if response.taskModelList?? && response.taskModelList?size gt 0>
            <@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />
        </#if>
    </div><!-- /.padding-md -->
</div><!-- /panel -->

<script language="javascript">
    $.del = function (id) {
        alertify.confirm("注意，一经删除，无法恢复！是否继续？", function (e) {
            if (e) {
                $.ajax({
                    cache: true,
                    type: "POST",
                    url: "${basePath}/tagType/del",
                    data: "tagTypeId=" + id,
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
    }
</script>
</@master.masterFrame>