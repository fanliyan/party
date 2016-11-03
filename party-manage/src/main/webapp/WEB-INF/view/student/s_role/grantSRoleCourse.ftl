<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["学生管理","学生角色管理","分配课程"]>
<div class="row">
    <form id="fromCourse">
    <div class="panel panel-default table-responsive">
        <div class="panel-heading">
            所有课程
            <span class="label label-info pull-right">目前共有${response.courseModelList?size}  门课程</span>
        </div>
        <table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
            <thead>
            <tr>
                <th>
                    <label class="label-checkbox">
                        <input type="checkbox" class="chk-row" id="checkAll" >
                        <span class="custom-checkbox"></span>
                    </label>
                    <input type="hidden" name="sroleId" value="${sroleId}"/>
                </th>
                <th>课程名称</th>
                <th>课程类型</th>
                <th>教师</th>
                <th>创建时间</th>
                <th>修改时间</th>
            </tr>
            </thead>
            <tbody>
            <#list response.courseModelList as course>
            <tr>
                <td>
                    <label class="label-checkbox">
                        <input type="checkbox" class="chk-row" name="courseId" value="${course.courseId}" ${checked(course.courseId)}>
                        <span class="custom-checkbox"></span>
                    </label>
                </td>
                <td>${course.courseName}</td>
                <td>${(course.courseTypeModel.name)!}</td>
                <td>${course.teacher!}</td>
                <td>${course.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                <td>${course.lastModifyTime?string('yyyy-MM-dd HH:mm:ss')}</td>
            </tr>
            </#list>
            </tbody>
        </table>
        <div class="panel-footer text-center">
            <button type="button" class="btn btn-success" onclick="submitCourse();">保存</button>
            <button type="button" class="btn btn-default" onclick="javascript:history.go(-1);">返回</button>
        </div>
    </div>
</div>
</form>
</div>
    <#function checked paraCourseId>
        <#if courseIdListId??>
            <#list courseIdListId as courseId>
                <#if courseId == paraCourseId>
                    <#return "checked='checked'">
                </#if>
            </#list>
        </#if>
        <#return "">
    </#function>
<script language="javascript">
    $("#checkAll").click(function(){
        $("input[name='courseId']").prop('checked',$("#checkAll").is(':checked'));
    });

    function submitCourse(){
        $.ajax({
            cache: true,
            type: "POST",
            url:"${basePath}/srole/addoredit",
            data:$('#fromCourse').serialize(),
            async: false,
            error: function(request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function(data) {
                if(data.result){
                    alertify.alert("操作成功！",function(e){location.href="${basePath}/srole/showAllSRole";});
                }
                else{
                    alertify.alert("错误:" + data.message);
                }
            }
        });
    }
</script>
</@master.masterFrame>