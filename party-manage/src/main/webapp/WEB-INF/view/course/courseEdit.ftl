<#import "/master/master-frame.ftl" as master />
<#if course??>
    <#assign title=["课程管理","课程","修改课程"]>
<#else>
    <#assign title=["课程管理","课程","新增课程"]>
</#if>
<@master.masterFrame pageTitle=title>

<link href="${basePath}/resources/css/video/video-js.css" rel="stylesheet">
<div>
    <div class="alert-inner">
        <div class="" style="color: red;text-align: center;">
            注意：仅支持 MP4格式 视频文件 且 码率为 H.264
        </div>
    </div>
</div>
<div class="panel panel-default">
    <div class="panel-body">

        <form id="formTag" class="form-horizontal no-margin form-border">

            <#if course??>
                <input type="hidden" name="courseId" value="${course.courseId!}"/>
                <input type="hidden" name="isUpdate" value="true"/>
            </#if>
            <div class="col-md-12">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-2 control-label">课程名</label>
                        <div class="col-md-10">
                            <input class="form-control parsley-validated" type="text" placeholder="课程名"
                                   data-parsley-required-message="课程名不能为空"
                                   data-parsley-required="true" name="courseName"
                                   value="${(course.courseName)!}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">描述</label>
                        <div class="col-md-10">
                    <textarea class="form-control parsley-validated"
                              placeholder="输入描述"
                              data-parsley-maxlength="300"
                              name="description">${(course.description)!}</textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-2">课程类型</label>
                        <div class="col-md-10">
                            <select name="courseType" class="form-control chzn-select"
                                    data-placeholder="请选择课程类型"
                                    data-parsley-required="true"
                                    data-parsley-required-message="请选择课程类型" >
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
                    </div>
                    <!-- /form-group -->
                    <div class="form-group">
                        <label class="col-md-2 control-label">教师</label>
                        <div class="col-md-10">
                            <input  class="form-control parsley-validated"
                                    placeholder="请输入教师姓名"
                                    name="teacher" value="${(course.description)!}"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">教师描述</label>
                        <div class="col-md-10">
                            <textarea  class="form-control parsley-validated"
                                       placeholder="请输入教师描述"
                                       name="teacherDescription"
                                       data-parsley-maxlength="300"
                            >${(course.teacherDescription)!}</textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">分数</label>
                        <div class="col-md-10">
                            <input  class="form-control parsley-validated"
                                    placeholder="请输入分数"
                                    data-parsley-range="[0,500]"
                                    name="score" value="${(course.score)!}"
                                    data-parsley-required="true" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">时长</label>
                        <div class="col-md-10">
                            <input  class="form-control parsley-validated"
                                    type="number"
                                    placeholder="请输入时长"
                                    name="time" value="${(course.time)!}"
                                    data-parsley-required="true" />
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="col-md-12">
                        <label class="col-md-4 control-label">课件列表</label>
                        <input name="bannerImg" id="addware" class="form-control insertFile" placeholder="点击上传课件"
                               maxfile="5" acceptedFile=".mp4"/>
                        <#--<button class="btn btn-info" id="addware" type="button">添加课件</button>-->
                    </div>
                    <div class="col-md-12" id="warelist">
                        <#if course??&&course.courseWareModelList??&&course.courseWareModelList?size gt 0>
                            <#list course.courseWareModelList as ware>
                                <div>
                                <div class='col-md-12'>
                                    <label>${ware.url}</label>
                                    <input type='hidden' name='courseWare' value='${ware.url}'>
                                    </div>
                                <div class='col-md-11'>
                                    <video id='my-video${ware_index}' class='video-js' controls preload='auto'
                                           poster='' data-setup='{}' width="300px">"
                                        <source src='${ware.url}' type='video/mp4'>
                                        </video>
                                    </div>
                                <div class='col-md-1'>
                                    <button class="btn" onclick="$(this).parent().parent().remove();">删除</button>
                                    </div>
                                </div>
                            </#list>
                        </#if>
                    </div>
                </div>
            </div>

            <div class="panel-footer text-center col-md-12">
                <button type="button" class="btn btn-success" id="submitButton">提交</button>
                <button type="button" class="btn btn-default" onclick="history.go(-1);">取消</button>
            </div>
        </form>
    </div>
</div><!-- /panel -->

<script src="${basePath}/resources/js/video/video.js" ></script>

<script language="javascript">
    $(function () {
        $("#submitButton").click(function () {
            if ($('#formTag').parsley().validate()) {
                $.submitformTag();
            }
        });

        $("#addware").selectFile(function (clickbutton, uploadFiles) {
            if (uploadFiles.length > 0) {
                for(i in uploadFiles){
                    $("#warelist").append(
                    "<div>"
                    +"<div class='col-md-12'>"
                    +"<label>"+uploadFiles[i]+"</label>"
                    +"<input type='hidden' name='courseWare' value='"+uploadFiles[i]+"'>"
                    +"</div>"
                    +"<div class='col-md-11'>"
                    +"<video id='my-video"+i+"' class='video-js' controls preload='auto' poster='' data-setup='{}'>"
                    +"<source src='"+uploadFiles[i]+"' type='video/mp4'>"
                    +"</video>"
                    +"</div>"
                    +"<div class='col-md-1'>"
                    +"<button class=\"btn\" onclick='$(this).parent().remove();'>删除</button>"
                    +"</div>"
                    +"</div>");


                }
            }
        });

    });

    function selectWareFile(id){
        $(".insertFile").selectFile(function (clickbutton, uploadFiles) {
            if (uploadFiles.length > 0) {
                $("input[name='bannerImg']").val(uploadFiles[0]);
                $("#banner").attr("src", uploadFiles[0]);
            }
        });
    };

    $.submitformTag = function () {

        var ware_input = $("#formTag input[name='courseWare']");
        var ware_vedio = $("#formTag video");
        for(i in ware_input){
            ware_input[i].value+=("::"+ware_vedio[i].duration);
        }

        $.ajax({
            cache: true,
            type: "POST",
            url: "${basePath}/course/addOrUpdate",
            data: $('#formTag').serialize(),
            async: false,
            error: function (request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function (data) {
                if (data.success) {
                    alertify.alert("操作成功！", function (e) {
                        location.href = "${basePath}/course/list";
                    });
                }
                else {
                    alertify.alert("错误:" + data.message);
                }
            }
        });
    }
</script>
</@master.masterFrame>