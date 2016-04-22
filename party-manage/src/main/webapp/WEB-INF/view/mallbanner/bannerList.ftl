<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["商城数据维护","banner管理","banner列表"]>

<div class="panel panel-default table-responsive">

    <div class="panel-heading">条件搜索</div>
    <div class="panel-body">
    <#--<form id="searchForm" class="form-inline no-margin" action="${basePath}/malltag/list" method="post">-->
    <#--<div class="form-group" style="margin-right:10px;">-->
    <#--<label class="control-label">标签名称</label>-->
    <#--<div>-->
    <#--<input name="name" type="text" class="form-control input-sm" value="<#if name??>${name!}</#if>"/>-->
    <#--</div>-->
    <#--</div>-->
    <#--<!-- /form-group &ndash;&gt;-->

    <#--<div class="form-group">-->
    <#--<label class="control-label">标签类别</label>-->
    <#--<select name="tagTypeId" id="tagTypeId" class="form-control chzn-select"-->
    <#--data-placeholder="请选择标签类别">-->
    <#--<option value="">请选择标签类别</option>-->
    <#--<#if tagTypeList ?? >-->
    <#--<#list tagTypeList as tagType >-->
    <#--<#if tagTypeId?? && tagType.tagTypeId?? && tagType.tagTypeId==tagTypeId>-->
    <#--<option value="${tagType.tagTypeId}" selected>${tagType.name}</option>-->
    <#--<#else>-->
    <#--<option value="${tagType.tagTypeId}">${tagType.name}</option>-->
    <#--</#if>-->
    <#--</#list>-->
    <#--</#if>-->
    <#--</select>-->
    <#--</div>-->
    <#--<!-- /form-group &ndash;&gt;-->

    <#--<button type="submit" class="btn btn-sm btn-success"><i class="fa fa-search" style="font-size:16px;"></i>-->
    <#--</button>-->
    <#--</form>-->
        <div class="panel-body ">
            <a class="btn btn-xs btn-info" href="${basePath}/mallbanner/add"><i class="fa fa-plus fa-lg"></i> 新增</a>
        </div>
    </div>
    <div class="padding-md clearfix">

        <div class="col-sm-12">
            <table class="table table-bordered table-condensed table-hover table-striped" id="dataTable">
                <thead>
                <tr>
                    <th>bannerID</th>
                    <th>banner</th>
                    <th>链接</th>
                    <th>位置</th>
                    <th>权重</th>
                    <th>创建时间</th>
                    <th>修改时间</th>
                    <th>修改人</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                    <#if bannerList?? && bannerList?size gt 0>
                        <#list bannerList as banner >
                        <tr>
                            <td>${banner.bannerConfigId!}</td>
                            <td>
                                <img src="${banner.bannerImg}@100h_200w_0e">
                            </td>
                            <td>${banner.bannerLink!}</td>
                            <td>${banner.bannerPosition!}</td>
                            <td>${banner.bannerWeight!}</td>

                            <td>${banner.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                            <td>${banner.lastModifyTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                            <td><#if banner.userModel??></#if>${banner.userModel.nickName!}</td>

                            <td>
                                <a class="btn btn-xs btn-warning"
                                   href="${basePath}/mallbanner/edit?bannerId=${banner.bannerConfigId}"><i
                                        class="fa  fa-edit  fa-lg"></i> 编辑</a>
                                <a class="btn btn-xs btn-danger" href="javascript:$.del(${banner.bannerConfigId});"><i
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
                    url: "${basePath}/mallbanner/del",
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