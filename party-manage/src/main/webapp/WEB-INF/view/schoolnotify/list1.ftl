<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["通知管理","党校通知管理","院系列表"]>

<div class="panel panel-default table-responsive">
    <div class="padding-md clearfix">

        <div class="col-sm-12">
            <table class="table table-bordered table-condensed table-hover table-striped" id="dataTable">
                <thead>
                <tr>
                    <th>id</th>
                    <th>院系</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                    <#if list?? && list?size gt 0>
                        <#list list as d >
                        <tr>
                            <td>${d.id!}</td>
                            <td>${d.name!}</td>
                            <td>
                                <a class="btn btn-xs btn-info"
                                   href="${basePath}/schoolnotify/list/${d.id}"><i
                                        class="fa  fa-info  fa-lg"></i> 修改通知</a>

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

        </div>

    </div><!-- /.padding-md -->
</div><!-- /panel -->

</@master.masterFrame>