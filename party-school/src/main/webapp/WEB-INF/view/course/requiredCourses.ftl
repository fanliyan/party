<#import "/master/master-frame.ftl" as master />
<#--<#import "/control/common/splitPage.ftl" as splitPage1 />-->

<@master.masterFrame showNotice=false >
<div id="portfolio" class="bg-light">
    <div class="section-header">
        <hr class="left visible-lg">
        <span>要学课程</span>
        <hr class="right visible-lg"></div>
    <div id="getDiv">
        <a href="javascript:history.back()" id="getBack">后退</a>
        <a href="javascript:history.forward()">前进</a>
    </div>
    <div class="container">
        <div class="panel panel-default table-responsive">
            <div class="panel-heading">
                要学课程
                <span class="label label-info pull-right">${(courseList?size)!"0"}门</span>
            </div>
            <form id="searchForm">

            </form>
            <table class="table table-striped" id="responsiveTable">
                <thead>
                <tr>
                    <#--<th>
                        <label class="label-checkbox">
                            <input type="checkbox" id="chk-all">
                            <span class="custom-checkbox"></span>
                        </label>
                    </th>-->
                    <th>课程名</th>
                    <th>描述</th>
                    <th>教师</th>
                    <th>课程类型</th>
                    <th>时长</th>
                    <th>分数</th>
                    <th>创建时间</th>
                    <th>状态</th>
                </tr>
                </thead>
                <tbody>
                   <#if courseList??&&courseList?size gt 0>
                        <#list courseList as course>
                        <tr>
                           <#-- <td>
                                <label class="label-checkbox">
                                    <input type="checkbox" class="chk-row">
                                    <span class="custom-checkbox"></span>
                                </label>
                            </td>-->
                            <td>${course.course_name!}</td>
                            <td style="max-width: 10em;word-break: break-all">${course.description!}</td>
                            <td>${course.teacher!}</td>
                            <td>${(course.courseTypeModel.name)!}</td>
                            <td><span class="badge badge-warning">${course.time!}(分钟)</span></td>
                            <td>${course.score!}</td>
                            <td>${course.create_time?string('yyyy-MM-dd HH:mm:ss')}</td>
                            <td>

                                <#if course.choose>
                                    <span class="label label-default">已选</span>
                                <#else>
                                    <span class="label label-default">未选</span>
                                </#if>
                            </td>
                        </tr>
                      </#list>
                    <#else>
                  <tr><td colspan="7">还未有要学课程</td></tr>
                    </#if>
                </tbody>
            </table>
           <#-- <#if response.courseModelList?? && response.courseModelList?size gt 0>
                <@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />
            </#if>-->
        </div>
    </div>
</div>

</@master.masterFrame>