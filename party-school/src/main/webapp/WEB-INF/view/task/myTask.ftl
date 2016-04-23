<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame showNotice=false >

<div id="portfolio" class="bg-light">
    <div class="section-header">
        <hr class="left visible-lg">
        <span>我的任务</span>
        <hr class="right visible-lg"></div>
    <div class="container">
        <div class="panel panel-default table-responsive">
            <div class="panel-heading">

                <span class="label label-info pull-right">${(taskModelList?size)!"0"} 个</span>
            </div>
            <form id="searchForm">
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-4 col-sm-4">

                        <#--<a class="btn btn-default btn-sm" onclick="$('searchForm').submit()">搜索</a>-->
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </div>
            </form>
            <table class="table table-striped" id="responsiveTable">
                <thead>
                <tr>
                    <th>任务名称</th>
                    <th>目标分数</th>
                    <th>目标时间(分钟)</th>
                    <th>开始时间</th>
                    <th>结束时间</th>
                    <th>完成情况</th>
                </tr>
                </thead>
                <tbody>
                <#if taskModelList?? && taskModelList?size gt 0>
                    <#list taskModelList as task>
                    <tr>
                        <td>${task.name!}</td>
                        <td>${task.targetScore!"无"}</td>
                        <td>${task.targetTime!"无"}</td>
                        <td>${(task.startTime?string('yyyy-MM-dd HH:mm:ss'))!"不限"}</td>
                        <td>${(task.endTime?string('yyyy-MM-dd HH:mm:ss'))!"不限"}</td>
                        <td>
                            <#if task.finish>
                                <span class="label label-success">已完成</span>
                            <#else >
                                <span class="label label-danger">未完成</span>
                            </#if>
                        </td>
                    </tr>
                    </#list>
                <#else>
                    <tr><td colspan="6">您还没有任务</td></tr>
                </#if>
                </tbody>
            </table>
            <#--<#if response.courseModelList?? && response.courseModelList?size gt 0>-->
                <#--<@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />-->
            <#--</#if>-->
        </div>
    </div>
</div>


<div class="content-padding bg-white">
    <div class="container">
        <div class="panel">
            <div class="panel-body content-padding">
                <div class="pull-left">
                    <p class="font-lg">学习更多课程请点击选课</p>
                    <p class="text-muted">了解更多党校知识</p>
                </div>
                <a href="${basePath}/course/choose"
                   class="btn btn-lg btn-danger pull-right m-top-xs no-animation animated-element">立即选课</a>
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