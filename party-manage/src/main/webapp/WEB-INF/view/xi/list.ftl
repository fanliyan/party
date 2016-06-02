<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["院系管理","院系管理","院系列表"]>

<div class="panel panel-default table-responsive">

    <#--<div class="panel-heading">条件搜索</div>-->
    <div class="panel-body">
        <div class="panel-body ">
            <a class="btn btn-xs btn-info" href="${basePath}/xi/add/${id}"><i class="fa fa-plus fa-lg"></i> 新增</a>
        </div>
    </div>
    <div class="padding-md clearfix">

        <div class="col-sm-12">
            <table class="table table-bordered table-condensed table-hover table-striped" id="dataTable">
                <thead>
                <tr>
                    <th>id</th>
                    <th>名称</th>
                    <th>创建时间</th>
                    <th>修改时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                    <#if list?? && list?size gt 0>
                        <#list list as d >
                        <tr>
                            <td>${d.id!}</td>
                            <td>${d.name!}</td>

                            <td>${d.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                            <td>${d.lastModifyTime?string('yyyy-MM-dd HH:mm:ss')}</td>

                            <td>
                                <a class="btn btn-xs btn-info"
                                   href="${basePath}/class/list/${d.id}"><i
                                        class="fa  fa-info  fa-lg"></i> 修改班</a>

                                <a class="btn btn-xs btn-warning"
                                   href="${basePath}/xi/edit?id=${d.id}"><i
                                        class="fa  fa-edit  fa-lg"></i> 编辑</a>

                                <a class="btn btn-xs btn-danger" href="javascript:$.del(${d.id});"><i
                                        class="fa  fa-times  fa-lg"></i> 删除</a>
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
        <#--<#if response.tagModels?? && response.tagModels?size gt 0>-->
        <#--<@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />-->
        <#--</#if>-->

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
                    url: "${basePath}/xi/del",
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