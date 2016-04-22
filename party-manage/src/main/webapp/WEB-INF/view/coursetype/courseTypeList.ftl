<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["课程管理","课程类型","课程类型列表"]>

<div class="panel panel-default table-responsive">

    <div class="panel-heading">条件搜索</div>
    <div class="panel-body">
        <form id="searchForm" class="form-inline no-margin" action="${basePath}/coursetype/list" method="post">
            <div class="form-group" style="margin-right:10px;">
                <label class="control-label">名称</label>
                <div>
                    <input name="name" type="text" class="form-control input-sm" value="${(courseType.name)!}"/>
                </div>
            </div>
            <!-- /form-group -->
            <button type="submit" class="btn btn-sm btn-success"><i class="fa fa-search" style="font-size:16px;"></i>
            </button>
        </form>
        <div class="panel-body ">
            <a class="btn btn-xs btn-info" href="${basePath}/coursetype/add"><i class="fa fa-plus fa-lg"></i> 新增</a>
        </div>
    </div>
    <div class="padding-md clearfix">

        <div class="col-sm-12">
            <table class="table table-bordered table-condensed table-hover table-striped" id="dataTable">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>名称</th>
                    <th>创建时间</th>
                    <th>修改时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                    <#if response.courseTypeModelList??&&response.courseTypeModelList?size gt 0>
                        <#list response.courseTypeModelList as courseType>
                        <tr>
                            <td>${courseType.id!}</td>
                            <td>${courseType.name!}</td>
                            <td>${courseType.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                            <td>${courseType.lastModifyTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                            <td>
                                <a class="btn btn-xs btn-warning"
                                   href="${basePath}/coursetype/edit?id=${courseType.id}"><i
                                        class="fa  fa-edit  fa-lg"></i> 编辑</a>
                                <a class="btn btn-xs btn-danger" href="javascript:$.del(${courseType.id});"><i
                                        class="fa  fa-times  fa-lg"></i> 删除</a>
                            </td>
                        </tr>
                        </#list>
                    <#else>
                    <tr>
                        <td colspan=5 class="text-center">没有数据</td>
                    </tr>
                    </#if>
                </tbody>
            </table>
            <#if response.courseTypeModelList?? && response.courseTypeModelList?size gt 0>
                <@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />
            </#if>
        </div>

    </div><!-- /.padding-md -->
</div><!-- /panel -->

<script language="javascript">
    $.del = function (id) {
        alertify.confirm("注意，一经删除，无法恢复！是否继续？", function (e) {
            if (e) {
                $.ajax({
                    cache: true,
                    type: "POST",
                    url: "${basePath}/coursetype/del",
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