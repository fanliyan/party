<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["考试管理","考试","考试列表"]>

<div class="panel panel-default table-responsive">

    <div class="panel-heading">条件搜索</div>
    <div class="panel-body">
        <form id="searchForm" class="form-inline no-margin" action="${basePath}/exam/list" method="post">
            <div class="form-group" style="margin-right:10px;">
                <label class="control-label">问题名</label>
                <div>
                    <input name="name" type="text" class="form-control input-sm"
                           value="${(exam.name)!}"/>
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
                            <#if (exam.roleId)?? && exam.roleId==role.roleId>
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
                        <option value="1" <#if (exam.status)??&&exam.status==0>selected</#if>>正常</option>
                        <option value="0" <#if (exam.status)??&&exam.status==1>selected</#if>>公开</option>
                        <option value="0" <#if (exam.status)??&&exam.status==2>selected</#if>>保密</option>
                        <option value="0" <#if (exam.status)??&&exam.status==-1>selected</#if>>已禁用</option>
                    </select>
                </div>
            </div><!-- /form-group -->
            <div class="form-group" style="margin-right:10px;">
                <label class="control-label">考试类型</label>
                <div>
                    <select class="form-control chzn-select" id="type" name="type" data-placeholder="选择考试类型">
                        <option value="">请选择</option>
                        <option value="0" <#if (exam.type)??&&exam.type==0>selected</#if>>单次考试</option>
                        <option value="1" <#if (exam.type)??&&exam.type==-1>selected</#if>>多次考试</option>
                    </select>
                </div>
            </div><!-- /form-group -->


            <button type="submit" class="btn btn-sm btn-success"><i class="fa fa-search" style="font-size:16px;"></i>
            </button>
        </form>
        <div class="panel-body ">
            <a class="btn btn-xs btn-info" href="${basePath}/exam/add"><i class="fa fa-plus fa-lg"></i> 新增</a>
        </div>
    </div>
    <div class="padding-md clearfix">
        <table class="table table-condensed table-hover table-striped" id="dataTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>问题名称</th>
                <th>描述</th>
                <th>考试类型</th>
                <th>分值</th>
                <th>状态</th>
                <th>创建人</th>
                <th>适用角色</th>
                <th>创建时间</th>
                <th>修改时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
                <#if response.examModelList?? && response.examModelList?size gt 0>
                    <#list response.examModelList as exam>
                    <tr>
                        <td>${exam.id!}</td>
                        <td>${exam.name!}</td>
                        <td>${exam.description!}</td>
                        <td>
                            <#if exam.type==0><span class="label label-success">单次</span><#else><span class="label label-warning">多次</span></#if>
                        </td>
                        <td>${exam.score!}</td>
                        <td>
                            <#if exam.status==0>
                                <span class="label label-xs label-default">正常</span>
                            <#elseif exam.status==1>
                                <span class="label label-xs label-info">公开</span>
                            <#elseif exam.status==2>
                                <span class="label label-xs label-warning">保密</span>
                            <#elseif exam.status==-1>
                                <span class="label label-xs label-danger">已禁用</span>
                            </#if>
                        </td>
                        <td>${(exam.userModel.name)!}</td>
                        <td>
                            <#if exam.roleId??>
                            ${(exam.sRoleModel.name)!}
                            <#else>
                                公用
                            </#if>
                        </td>
                        <td>${exam.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                        <td>${exam.lastModifyTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                        <td>
                            <a class="btn btn-xs btn-warning"
                               href="${basePath}/exam/edit?id=${exam.id}">
                                <i class="fa fa-info-circle fa-lg"></i> 编辑</a>
                            <button class="btn btn-xs btn-danger"
                                    onclick="$.del(${exam.id})">
                                <i class="fa fa-wrench fa-lg"></i> 删除
                            </button>
                        </td>
                    </tr>
                    </#list>
                <#else>
                <tr>
                    <td colspan=10 class="text-center">没有数据</td>
                </tr>
                </#if>
            </tbody>
        </table>
        <#if response.examModelList?? && response.examModelList?size gt 0>
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
                    url: "${basePath}/exam/del",
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