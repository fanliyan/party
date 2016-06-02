<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame showNotice=false >

<div id="portfolio" class="bg-light">
    <div class="section-header">
        <hr class="left visible-lg">
        <span>考试记录</span>
        <hr class="right visible-lg"></div>
    <div class="container">
        <div class="panel panel-default table-responsive">
            <div class="panel-heading">
                <span class="label label-info pull-right">${(response.scoreModelList?size)!"0"} 次</span>
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
                    <th>考试</th>
                    <th>考试时间</th>
                    <th>分数/总分</th>
                </tr>
                </thead>
                <tbody>
                    <#if response.scoreModelList??&&response.scoreModelList?size gt 0>
                        <#list response.scoreModelList as score>
                        <tr>
                            <td>${(score.examModel.name)!}</td>
                            <td>${score.createTime?string('yyyy-MM-dd')}</td>
                            <#if score.score/score.examModel.score gt 0.8>
                                <td><span class="label label-success">${(score.score)!}/${(score.examModel.score)!}</span></td>
                            <#elseif score.score/score.examModel.score gt 0.6>
                                <td><span class="label label-default">${(score.score)!}/${(score.examModel.score)!}</span></td>
                            <#else>
                                <td><span class="label label-warning">${(score.score)!}/${(score.examModel.score)!}</span></td>
                            </#if>

                            <#--<td>-->
                                <#--<button class="btn btn-info" onclick="$.watch(${question.id},1);">查看</button>-->
                            <#--</td>-->
                        </tr>
                        </#list>
                    <#else>
                    <tr><td colspan="3">暂无成绩</td></tr>
                    </#if>
                </tbody>
            </table>
            <form id="searchForm" action="${basePath}/profile/list"></form>
            <#if response.scoreModelList?? && response.scoreModelList?size gt 0>
                <@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />
            </#if>
        </div>
    </div>
</div>


<div class="content-padding bg-white">
    <div class="container">
        <div class="panel">
            <div class="panel-body content-padding">
                <div class="pull-left">
                    <p class="font-lg">向他人学习</p>
                    <p class="text-muted">了解更多党校知识</p>
                </div>
                <a href="${basePath}/exam/list"
                   class="btn btn-lg btn-danger pull-right m-top-xs no-animation animated-element">立即考试</a>
            </div>
        </div>
    </div>
</div>


</@master.masterFrame>
<script>
    $(function()	{
        $('.animated-element').waypoint(function() {

            $(this).removeClass('no-animation');

        }, { offset: '70%' });

        $('.nav').localScroll({duration:800});
    });
</script>