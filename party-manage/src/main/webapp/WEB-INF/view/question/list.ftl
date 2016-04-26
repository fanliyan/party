<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["考试管理","问题","问题列表"]>

<div class="panel panel-default table-responsive">

    <div class="panel-heading">条件搜索</div>
    <div class="panel-body">
        <form id="searchForm" class="form-inline no-margin" action="${basePath}/question/list" method="post">
            <div class="form-group" style="margin-right:10px;">
                <label class="control-label">问题名</label>
                <div>
                    <input name="name" type="text" class="form-control input-sm"
                           value="${(question.name)!}"/>
                </div>
            </div>
            <!-- /form-group -->
            <div class="form-group">
                <label class="control-label">适用角色</label>
                <select name="roleId" id="roleId" class="form-control chzn-select"
                        data-placeholder="请选择">
                    <option value="">请选择</option>
                    <#if sRoleList ?? >
                        <#list sRoleList as role >
                            <#if (question.roleId)?? && question.roleId==role.roleId>
                                <option value="${role.roleId}" selected>${role.name}</option>
                            <#else>
                                <option value="${role.roleId}">${role.name}</option>
                            </#if>
                        </#list>
                    </#if>
                </select>
            </div>
            <!-- /form-group -->
            <div class="form-group" style="margin-right:10px;">
                <label class="control-label">状态</label>
                <div>
                    <select class="form-control chzn-select" id="status" name="status" data-placeholder="选择状态">
                        <option value="">请选择</option>
                        <option value="1" <#if (question.status)??&&question.status==0>selected</#if>>正常</option>
                        <option value="0" <#if (question.status)??&&question.status==1>selected</#if>>公开</option>
                        <option value="0" <#if (question.status)??&&question.status==2>selected</#if>>保密</option>
                        <option value="0" <#if (question.status)??&&question.status==-1>selected</#if>>已禁用</option>
                    </select>
                </div>
            </div><!-- /form-group -->


            <button type="submit" class="btn btn-sm btn-success"><i class="fa fa-search" style="font-size:16px;"></i>
            </button>
        </form>
        <div class="panel-body ">
            <a class="btn btn-xs btn-info" href="${basePath}/question/add"><i class="fa fa-plus fa-lg"></i> 新增</a>
        </div>
    </div>
    <div class="padding-md clearfix">
        <table class="table table-condensed table-hover table-striped" id="dataTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>问题名称</th>
                <th>分值</th>
                <th>类型</th>
                <th>状态</th>
                <th>创建人</th>
                <th>适用角色</th>
                <th>创建时间</th>
                <th>修改时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
                <#if response.questionModelList?? && response.questionModelList?size gt 0>
                    <#list response.questionModelList as question>
                    <tr>
                        <td>${question.id!}</td>
                        <td>${question.name!}</td>
                        <td>${question.score!}</td>
                        <td>
                            <#if question.type == 1>
                                <span class="label label-info">单选</span>
                            <#elseif question.type == 2>
                                <span class="label label-warning">多选</span>
                            <#elseif question.type == 3>
                                <span class="label label-success">判断</span>
                            </#if>
                        </td>
                        <td>
                            <#if question.status==0>
                                <span class="label label-xs label-default">正常</span>
                            <#elseif question.status==1>
                                <span class="label label-xs label-info">公开</span>
                            <#elseif question.status==2>
                                <span class="label label-xs label-warning">保密</span>
                            <#elseif question.status==-1>
                                <span class="label label-xs label-danger">已禁用</span>
                            </#if>
                        </td>
                        <td>${(question.userModel.name)!}</td>
                        <td>
                            <#if question.roleId??>
                            ${(question.sRoleModel.name)!}
                            <#else>
                                公用
                            </#if>
                        </td>
                        <td>${question.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                        <td>${question.lastModifyTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                        <td>
                            <a class="btn btn-xs btn-warning"
                               href="${basePath}/question/edit?id=${question.id}">
                                <i class="fa fa-info-circle fa-lg"></i> 编辑</a>
                            <button class="btn btn-xs btn-danger"
                                    onclick="$.del(${question.id})">
                                <i class="fa fa-wrench fa-lg"></i> 删除
                            </button>
                        </td>
                    </tr>
                    </#list>
                <#else>
                <tr>
                    <td colspan=9 class="text-center">没有数据</td>
                </tr>
                </#if>
            </tbody>
        </table>
        <#if response.questionModelList?? && response.questionModelList?size gt 0>
            <@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />
        </#if>
    </div><!-- /.padding-md -->
</div><!-- /panel -->

<script language="javascript">
    $.del = function (id) {
        alertify.confirm("注意：一旦删除无法回复", function (e) {
            if (e) {
                $.ajax({
                    cache: true,
                    type: "POST",
                    url: "${basePath}/question/del",
                    data: {"id": id},
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