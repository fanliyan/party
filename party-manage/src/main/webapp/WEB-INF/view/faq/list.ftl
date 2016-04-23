<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["问答管理","问答","回答问题"]>

<div class="panel panel-default table-responsive">
    <div class="panel-heading">条件搜索</div>
    <div class="panel-body">
        <form id="searchForm" class="form-inline no-margin" action="${basePath}/faq/list" method="post">
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
    <table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
        <thead>
        <tr>
            <th>问题ID</th>
            <th>问题</th>
            <th>提问人</th>
            <th>提问时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
            <#if response.faqModelList??&&response.faqModelList?size gt 0>
                <#list response.faqModelList as faq>
                <tr>
                    <td>${faq.id!}</td>
                    <td>${faq.question}</td>
                    <td>${(faq.studentModel.name)!}</td>
                    <td>${(faq.createTime?string('yyyy-MM-dd hh:mm:ss'))!}</td>
                    <td>
                        <button class="btn btn-success" id="ask" data-id="${faq.id!}" >回答</button>
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
    <#if response.faqModelList?? && response.faqModelList?size gt 0>
        <@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />
    </#if>

</div><!-- /panel -->
<div  id="question-modal" class="modal fade" style="display: none;width: 50%;left: 25%" aria-hidden="true">
    <div class="modal-content">
        <div class="modal-header">
            <a class="close" data-dismiss="modal">×</a>
            <h3 id="modal-title">提问</h3>
        </div>
        <div class="modal-body" id="modal-content">
            <textarea id="question" class="form-control" placeholder="FAQ"></textarea>
        </div>
        <div class="modal-footer">
            <a href="javascript:;" class="btn btn-success" id="success-modal">提交</a>
        </div>
    </div>
</div>
<script>
    !function(){
        $(function () {
            var id;
            $("#ask").on("click",function(){
                $("#question").val("");
                $("#question-modal").modal();
                id = $(this).attr("data-id");
            });
            $("#success-modal").on("click",function(){
                var question = $("#question").val();

                if(question&&question!=""){
                    $.ajax({
                        cache: true,
                        type: "POST",
                        url: "${basePath}/faq/answer/",
                        data:{answer:question,id:id},
                        async: false,
                        error: function (request) {
                            alertify.alert("错误：服务器异常！");
                        },
                        success: function (data) {
                            if (data.success) {
                                alertify.alert("已回答~");
                                $("#question-modal").modal("hide");
                                Location.reload();
                            }
                            else {
                                alertify.alert("错误:" + data.message);
                            }
                        }
                    });
                }else{
                    alertify.alert("回答不能为空");
                }
            });
        });
    }();
</script>

</@master.masterFrame>