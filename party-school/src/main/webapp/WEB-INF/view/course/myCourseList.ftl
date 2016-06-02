<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame showNotice=false >

<div id="portfolio" class="bg-light">
    <div class="section-header">
        <hr class="left visible-lg">
        <span>在学课程</span>
        <hr class="right visible-lg"></div>
    <div class="container">
        <div class="panel panel-default table-responsive">
            <div class="panel-heading">
                已选课程
                <span class="label label-info pull-right">${(response.courseModelList?size)!"0"} 门</span>
            </div>
            <form id="searchForm">
            <#--<div class="panel-body">-->
                <#--<div class="row">-->
                    <#--<div class="col-md-4 col-sm-4">-->
                        <#--<select class="input-sm form-control inline" style="width:130px;">-->
                            <#--<option value="0">课程名</option>-->
                            <#--<option value="1">介绍</option>-->
                            <#--<option value="2">Women</option>-->
                            <#--<option value="3">Accessary</option>-->
                        <#--</select>-->
                        <#--<a class="btn btn-default btn-sm" onclick="$('searchForm').submit()">搜索</a>-->
                    <#--</div>-->
                    <#--<!-- /.col &ndash;&gt;-->
                <#--</div>-->
                <#--<!-- /.row &ndash;&gt;-->
            <#--</div>-->
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
                    <th>描述</th>
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
                        <td style="max-width: 10em;word-break: break-all">${course.description!}</td>
                        <td>${course.teacher!}</td>
                        <td>${(course.courseTypeModel.name)!}</td>
                        <td><span class="badge badge-warning">${course.time!}(分钟)</span></td>
                        <td>${course.score!}</td>
                        <td>${course.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                        <td>

                            <#if course.courseWareModelList??&&course.courseWareModelList?size gt 0>
                                <#list course.courseWareModelList as ware1>
                                    <button class="btn startCourse"
                                            data-courseId="${course.courseId}"
                                            data-wareId="${ware1.id}"
                                          >学习课件${ware1_index+1}</button>
                                    <#--<button class="btn">继续学习</button>-->
                                    <#--<button class="btn">已完成</button>-->

                                </#list>
                            <#else >
                                暂无课件
                            </#if>
                        </td>
                    </tr>
                    </#list>
                <#else>
                <tr><td colspan="7">您还未选择课程</td></tr>
                </#if>
                </tbody>
            </table>
            <#if response.courseModelList?? && response.courseModelList?size gt 0>
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
<script>
    !function(){
        $(function () {
           $(".startCourse").on("click",function(){
               var courseId=$(this).attr("data-courseId");
               var wareId=$(this).attr("data-wareId");
               $.ajax({
                   cache: false,
                   type: "POST",
                   url:"${basePath}/study/check/"+courseId+"/"+wareId,
                   data:null,
                   async: false,
                   error: function(request) {
                       alertify.alert("错误：服务器异常！");
                   },
                   success: function(data) {
                       if(data.success){
                           alertify.alert("错误:您已在学习其他课程！");
                       }else{
                           location.href='${basePath}/study/'+courseId+'/'+wareId;
                       }
                   }
               });
           });
        });
    }();
</script>