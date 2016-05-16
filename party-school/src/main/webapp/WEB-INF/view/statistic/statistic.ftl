<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame showNotice=false >
<div id="portfolio" class="bg-light">
    <div class="section-header">
        <hr class="left visible-lg">
        <span>排行榜</span>
        <hr class="right visible-lg"></div>
    <div class="container">
        <div class="panel panel-default">
            <div class="panel-body">

                <div class="col-xs-12">
                    <div class="col-xs-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                完成课程排行榜
                            </div>
                            <table class="table table-bordered table-condensed table-hover table-striped">
                                <thead>
                                <tr>
                                    <th>NO.</th>
                                    <th>姓名</th>
                                    <th>完成课程数</th>
                                </tr>
                                </thead>
                                <tbody>
                                <#list courseTop as model>
                                    <tr>
                                        <td>
                                            ${model_index+1}
                                        </td>
                                        <td>
                                            ${(model.name)!}
                                        </td>
                                        <td>
                                            ${(model.count)!}
                                        </td>
                                    </tr>
                                </#list>
                                </tbody>
                            </table>
                            <#--<form id="searchForm" action="${basePath}/statistic/course"></form>-->
                            <#--<#if response.courseTop?? && response.courseTop?size gt 0>-->
                                <#--<@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />-->
                            <#--</#if>-->
                        </div><!-- /panel -->
                    </div>


                    <div class="col-xs-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                视频观看排行榜
                            </div>
                            <table class="table table-bordered table-condensed table-hover table-striped">
                                <thead>
                                <tr>
                                    <th>NO.</th>
                                    <th>课程</th>
                                    <th>观看次数</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <#list watchTop as model>
                                    <tr>
                                        <td>
                                        ${model_index+1}
                                        </td>
                                        <td>
                                        ${(model.name)!}
                                        </td>
                                        <td>
                                        ${(model.count)!}
                                        </td>
                                    </tr>
                                    </#list>
                                </tbody>
                            </table>
                        </div><!-- /panel -->
                    </div>
                </div>


            </div>
        </div><!-- /panel -->
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