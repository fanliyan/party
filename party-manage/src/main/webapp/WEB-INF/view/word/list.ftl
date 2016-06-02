<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["课程管理","年度要求","年度要求列表"]>

<div class="panel panel-default table-responsive">

    <div class="panel-heading">条件搜索</div>
    <div class="panel-body">

        <div class="col-md-12">
            <form id="searchForm" class="form-inline no-margin" action="${basePath}/sensitiveword/list" method="post">
                <div class="col-md-4">
                    <div class="form-group" style="margin-right:10px;">
                        <label class="control-label">敏感词</label>
                        <input name="name" type="text" class="form-control input-sm" value="${name!}"/>
                    </div>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-sm btn-success"><i class="fa fa-search"></i></button>
                </div>
            </form>
        </div>
        <div class="panel-body ">
            <button class="btn btn-xs btn-info" onclick="$.add()"><i class="fa fa-plus fa-lg"></i> 新增</button>
        </div>
    </div>
    <div class="padding-md clearfix">
        <table class="table table-condensed table-hover table-striped" id="dataTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>敏感词</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
                <#if response.sensitiveWordsModelList?? && response.sensitiveWordsModelList?size gt 0>
                    <#list response.sensitiveWordsModelList as word>
                    <tr>
                        <td>${word.wordId!}</td>
                        <td>${word.word!}</td>
                        <td>${word.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                        <td>
                            <a class="btn btn-xs btn-danger" href="javascript:$.del(${word.wordId});">
                                <i class="fa fa-edit fa-lg"></i> 删除</a>
                        </td>
                    </tr>
                    </#list>
                <#else>
                <tr>
                    <td colspan=4 class="text-center">没有数据</td>
                </tr>
                </#if>
            </tbody>
        </table>
        <#if response.sensitiveWordsModelList?? && response.sensitiveWordsModelList?size gt 0>
            <@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />
        </#if>
    </div><!-- /.padding-md -->
</div><!-- /panel -->
<div  id="review-modal" class="modal fade" style="display: none;" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <a class="close" data-dismiss="modal">×</a>
                <h3 id="modal-title">添加关键词</h3>
            </div>
            <div class="modal-body" id="modal-content">
                <input class="form-control" id="addName">
            </div>
            <div class="modal-footer">
                <button onclick="$.adddo()" class="btn btn-success" >添加</button>
            </div>
        </div>
    </div>
</div>
<script language="javascript">
    $.del = function (id) {
        alertify.confirm("注意，一经删除，无法恢复！是否继续？", function (e) {
            if (e) {
                $.ajax({
                    cache: true,
                    type: "POST",
                    url: "${basePath}/sensitiveword/del",
                    data: "id=" + id,
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
    $.add = function () {
        $("#addName").val("");
        $("#review-modal").modal();
    };
    $.adddo = function(){
        var name =$("#addName").val();
        if(name!=''){
            $.ajax({
                cache: true,
                type: "POST",
                url: "${basePath}/sensitiveword/add",
                data: "name=" +name ,
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
    };
</script>
</@master.masterFrame>