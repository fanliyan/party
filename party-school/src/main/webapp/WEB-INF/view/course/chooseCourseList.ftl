<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame showNotice=false >

<div id="portfolio" class="bg-light">
    <div class="section-header">
        <hr class="left visible-lg">
        <span>选课</span>
        <hr class="right visible-lg"></div>
    <div class="container">
        <div class="panel panel-default table-responsive">
            <div class="panel-heading">
                课程列表
                <span class="label label-info pull-right">${(response.courseModelList?size)!"0"} 门</span>
            </div>
            <form id="searchForm">
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-4 col-sm-4">
                        <select class="input-sm form-control inline" style="width:130px;">
                            <option value="0">课程名</option>
                            <option value="1">介绍</option>
                            <option value="2">Women</option>
                            <option value="3">Accessary</option>
                        </select>
                        <a class="btn btn-default btn-sm" onclick="$('searchForm').submit()">搜索</a>
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </div>
            </form>
            <table class="table table-striped" id="responsiveTable">
                <thead>
                <tr>
                    <th>
                        <label class="label-checkbox">
                            <input type="checkbox" id="chk-all">
                            <span class="custom-checkbox"></span>
                        </label>
                    </th>
                    <th>课程名</th>
                    <th>教师</th>
                    <th>课程类型</th>
                    <th>时长</th>
                    <th>分数</th>
                    <th>创建时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <#if response.courseModelList??&&response.courseModelList?size gt 0>
                    <#list response.courseModelList as course>
                    <tr>
                        <td>
                            <label class="label-checkbox">
                                <input type="checkbox" class="chk-row">
                                <span class="custom-checkbox"></span>
                            </label>
                        </td>
                        <td>${course.courseName!}</td>
                        <td>${course.teacher!}</td>
                        <td>${(course.courseTypeModel.name)!}</td>
                        <td><span class="badge badge-warning formatMinute" >${course.time!}(分钟)</span></td>
                        <td>${course.score!}</td>
                        <td>${course.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                        <td>
                            <#if course.isChoose>
                                <span class="label label-default">已选</span>
                            <#else >
                                <button class="btn btn-warning" onclick="chooseCourse(${course.courseId})" >选课</button>
                            </#if>
                        </td>
                    </tr>
                    </#list>
                <#else>
                <tr><td colspan="7">暂无课程</td></tr>
                </#if>
                </tbody>
            </table>
            <#if response.courseModelList?? && response.courseModelList?size gt 0>
                <@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />
            </#if>
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

    function chooseCourse(id){
        $.ajax({
            cache: true,
            type: "POST",
            url: "${basePath}/course/chooseCourse",
            data: {id:id},
            async: false,
            error: function (request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function (data) {
                if (data.success) {
                    alertify.alert("操作成功！", function (e) {
                        location.reload();
                    });
                }
                else {
                    alertify.alert("错误:" + data.message);
                }
            }
        });
    };
</script>