<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame showNotice=false >

<div id="portfolio" class="bg-light">
    <div class="section-header">
        <hr class="left visible-lg">
        <span>在线考试</span>
        <hr class="right visible-lg"></div>
    <div class="container">
        <div class="panel panel-default table-responsive">
            <div class="panel-heading">
                <span class="label label-info pull-right">${(response.examModelList?size)!"0"} 个</span>
            </div>
            <form id="searchForm">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-4 col-sm-4">
                            <#--<a class="btn btn-warning btn-sm" href="${basePath}/note/add">添加笔记</a>-->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
            </form>
            <table class="table table-striped" id="responsiveTable">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>考试名</th>
                    <th>描述</th>
                    <th>类型</th>
                    <th>时长(分钟)</th>
                    <th>开始时间</th>
                    <th>结束时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                    <#if response.examModelList??&&response.examModelList?size gt 0>
                        <#list response.examModelList as exam>
                        <tr>
                            <td>${exam_index+1!}</td>
                            <td>${exam.name!}</td>
                            <td>${exam.description!}</td>
                            <td>
                                <#if exam.type==0><span class="label label-success">单次</span><#else><span class="label label-warning">多次</span></#if>
                            </td>
                            <td><span class="label label-primary">${exam.time!}</span></td>
                            <td>${(exam.startTime?string('yyyy-MM-dd'))!"不限"}</td>
                            <td>${(exam.endTime?string('yyyy-MM-dd'))!"不限"}</td>
                            <td>
                                <a class="btn btn-info" href="${basePath}/exam/start/${exam.id}">开始考试</a>
                            </td>
                        </tr>
                        </#list>
                    <#else>
                    <tr><td colspan="6">暂无题目</td></tr>
                    </#if>
                </tbody>
            </table>
            <form id="searchForm" action="${basePath}/exam/list"></form>
            <#if response.examModelList?? && response.examModelList?size gt 0>
                <@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />
            </#if>
        </div>
    </div>
</div>


<#--<div class="content-padding bg-white">-->
    <#--<div class="container">-->
        <#--<div class="panel">-->
            <#--<div class="panel-body content-padding">-->
                <#--<div class="pull-left">-->
                    <#--<p class="font-lg">向他人学习</p>-->
                    <#--<p class="text-muted">了解更多党校知识</p>-->
                <#--</div>-->
                <#--<a href="${basePath}/exam/list"-->
                   <#--class="btn btn-lg btn-danger pull-right m-top-xs no-animation animated-element">立即考试</a>-->
            <#--</div>-->
        <#--</div>-->
    <#--</div>-->
<#--</div>-->

</@master.masterFrame>
<script>
    $(function()	{
        $('.animated-element').waypoint(function() {

            $(this).removeClass('no-animation');

        }, { offset: '70%' });

        $('.nav').localScroll({duration:800});
    });
</script>
