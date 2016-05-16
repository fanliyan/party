<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["考试管理","成绩","成绩列表"]>

<div class="panel panel-default table-responsive">

    <div class="panel-heading">条件搜索</div>
    <div class="panel-body">
        <form id="searchForm" class="form-inline no-margin" action="${basePath}/score/list" method="post">
            <div class="form-group" style="margin-right:10px;">
                <label class="control-label">学生名</label>
                <div>
                    <input name="name" type="text" class="form-control input-sm"
                           value="${(studentModel.name)!}"/>
                </div>
            </div>


            <button type="submit" class="btn btn-sm btn-success"><i class="fa fa-search" style="font-size:16px;"></i>
            </button>
        </form>
        <#--<div class="panel-body ">-->
            <#--<a class="btn btn-xs btn-info" href="${basePath}/question/add"><i class="fa fa-plus fa-lg"></i> 新增</a>-->
        <#--</div>-->
    </div>
    <div class="padding-md clearfix">
        <table class="table table-condensed table-hover table-striped" id="dataTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>考试名</th>
                <th>分数</th>
                <th>学生</th>
                <th>创建时间</th>
            </tr>
            </thead>
            <tbody>
                <#if response.scoreModelList?? && response.scoreModelList?size gt 0>
                    <#list response.scoreModelList as score>
                    <tr>
                        <td>${score.id!}</td>
                        <td>${(score.examModel.name)!}</td>

                        <#if score.score/score.examModel.score gt 0.8>
                            <td><span class="label label-success">${(score.score)!}/${(score.examModel.score)!}</span></td>
                        <#elseif score.score/score.examModel.score gt 0.6>
                            <td><span class="label label-default">${(score.score)!}/${(score.examModel.score)!}</span></td>
                        <#else>
                            <td><span class="label label-warning">${(score.score)!}/${(score.examModel.score)!}</span></td>
                        </#if>

                        <td>
                        ${(score.studentModel.name)!}
                        </td>
                        <td>${score.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>

                        <#--<td>-->
                            <#--<a class="btn btn-xs btn-warning"-->
                               <#--href="${basePath}/question/edit?id=${question.id}">-->
                                <#--<i class="fa fa-info-circle fa-lg"></i> 编辑</a>-->
                            <#--<button class="btn btn-xs btn-danger"-->
                                    <#--onclick="$.del(${question.id})">-->
                                <#--<i class="fa fa-wrench fa-lg"></i> 删除-->
                            <#--</button>-->
                        <#--</td>-->
                    </tr>
                    </#list>
                <#else>
                <tr>
                    <td colspan=9 class="text-center">没有数据</td>
                </tr>
                </#if>
            </tbody>
        </table>
        <#if response.scoreModelList?? && response.scoreModelList?size gt 0>
            <@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />
        </#if>
    </div><!-- /.padding-md -->
</div><!-- /panel -->

</@master.masterFrame>