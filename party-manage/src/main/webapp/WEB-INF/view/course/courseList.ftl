<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["课程管理","课程","课程列表"]>

<div class="panel panel-default table-responsive">

    <div class="panel-heading">条件搜索</div>
    <div class="panel-body">
        <form id="searchForm" class="form-inline no-margin" action="${basePath}/course/list" method="post">
            <div class="form-group" style="margin-right:10px;">
                <label class="control-label">课程名称</label>
                <div>
                    <input name="courseName" type="text" class="form-control input-sm" value="${(course.courseName)!}"/>
                </div>
            </div>
            <!-- /form-group -->

            <div class="form-group">
                <label class="control-label">课程类型</label>
                <select name="courseType" id="tagTypeId" class="form-control chzn-select"
                        data-placeholder="请选择课程类型">
                    <option value="">请选择课程类型</option>
                    <#if courseType ?? >
                        <#list courseType as type >
                            <#if course?? && course.courseType?? && type.id==course.courseType>
                                <option value="${type.id}" selected>${type.name}</option>
                            <#else>
                                <option value="${type.id}">${type.name}</option>
                            </#if>
                        </#list>
                    </#if>
                </select>
            </div>
            <!-- /form-group -->

            <button type="submit" class="btn btn-sm btn-success"><i class="fa fa-search" style="font-size:16px;"></i>
            </button>
        </form>
        <div class="panel-body ">
            <a class="btn btn-xs btn-info" href="${basePath}/course/add"><i class="fa fa-plus fa-lg"></i> 新增</a>
        </div>
    </div>
    <div class="padding-md clearfix">

        <div class="col-sm-12">
            <table class="table table-bordered table-condensed table-hover table-striped" id="dataTable">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>课程名</th>
                    <th>描述</th>
                    <th>课程类型</th>
                    <th>教师</th>
                    <th>学分</th>
                    <th>时长（秒）</th>
                    <th>创建时间</th>
                    <th>修改时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                    <#if response.courseModelList??&&response.courseModelList?size gt 0>
                        <#list response.courseModelList as course>
                        <tr>
                            <td>${course.courseId!}</td>
                            <td>${course.courseName!}</td>
                            <td>${course.description!}</td>
                            <td>${(course.courseTypeModel.name)!}</td>
                            <td>${course.teacher!}</td>
                            <td>${course.score!}</td>
                            <td>${course.time!}</td>
                            <td>${course.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                            <td>${course.lastModifyTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                            <td>
                                <#--<a class="btn btn-xs btn-danger" href="javascript:$.del(${course.courseId});"><i-->
                                        <#--class="fa  fa-times  fa-lg"></i> 编辑课件</a>-->

                                <a class="btn btn-xs btn-warning"
                                   href="${basePath}/course/edit?id=${course.courseId}"><i
                                        class="fa  fa-edit  fa-lg"></i> 编辑</a>
                                <a class="btn btn-xs btn-danger" href="javascript:$.del(${course.courseId});"><i
                                        class="fa  fa-times  fa-lg"></i> 删除</a>
                            </td>
                        </tr>
                        </#list>
                    <#else>
                    <tr>
                        <td colspan=10 class="text-center">没有数据</td>
                    </tr>
                    </#if>
                </tbody>
            </table>
            <#if response.courseModelList?? && response.courseModelList?size gt 0>
                <@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />
            </#if>
        </div>

    </div><!-- /.padding-md -->
</div><!-- /panel -->

<script language="javascript">
    $.del = function (id) {
        alertify.confirm("注意，一经删除，无法恢复！是否继续？", function (e) {
            if (e) {
                $.ajax({
                    cache: true,
                    type: "POST",
                    url: "${basePath}/course/del",
                    data: {"id": id},
                    async: false,
                    error: function (request) {
                        alertify.alert("错误：服务器异常！");
                    },
                    success: function (data) {
                        if (data.success) {
                            location.reload();
                        }
                        else {
                            alertify.alert("错误:" + data.message);
                        }
                    }
                });
            }
        });
    }
</script>
</@master.masterFrame>