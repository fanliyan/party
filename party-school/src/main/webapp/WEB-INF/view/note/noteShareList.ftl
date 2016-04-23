<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame showNotice=false >

<div id="portfolio" class="bg-light">
    <div class="section-header">
        <hr class="left visible-lg">
        <span>笔记分享</span>
        <hr class="right visible-lg"></div>
    <div class="container">
        <div class="panel panel-default table-responsive">
            <div class="panel-heading">
                <span class="label label-info pull-right">${(response.studyNoteModelList?size)!"0"} 篇</span>
            </div>
            <form id="searchForm">
            <div class="panel-body">
                <div class="row">
                    <#--<div class="col-md-4 col-sm-4">-->
                        <#--<a class="btn btn-warning btn-sm" href="${basePath}/note/add">添加笔记</a>-->
                    <#--</div>-->
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </div>
            </form>
            <table class="table table-striped" id="responsiveTable">
                <thead>
                <tr>
                    <th>NO.</th>
                    <th>标题</th>
                    <th>创建日期</th>
                    <th>作者</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                    <#if response.studyNoteModelList??&&response.studyNoteModelList?size gt 0>
                        <#list response.studyNoteModelList as note>
                        <tr>
                            <td>${note_index+1}</td>
                            <td>${note.title}</td>
                            <td>${note.createTime?string('yyyy-MM-dd')}</td>
                            <td>${(note.studentModel.name)!}</td>
                            <td>
                                <a class="btn btn-md btn-warning" href="${basePath}/note/read/${note.id}">查看</a>
                            </td>
                        </tr>
                        </#list>
                    <#else>
                    <tr><td colspan="5
                ">暂无分享</td></tr>
                    </#if>
                </tbody>
            </table>
            <form id="searchForm" action="${basePath}/mote/sharelist"></form>
            <#if response.studyNoteModelList?? && response.studyNoteModelList?size gt 0>
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