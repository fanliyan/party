<#import "/master/master-frame.ftl" as master />
<#if exam??>
	<#assign title=["考试管理","考试","修改考试"]>
<#else>
	<#assign title=["考试管理","考试","新增考试"]>
</#if>
<@master.masterFrame pageTitle=title>
<div class="panel panel-default">
		<div class="panel-body">
			<form id="formTag" class="form-horizontal no-margin form-border" >

				<#if exam??>
                    <input type="hidden" name="id" value="${exam.id!}" />
                    <input type="hidden" name="isUpdate" value="true" />
				</#if>
                <div class="form-group">
                    <label class="col-lg-1 control-label">考试名称</label>
                    <div class="col-md-5">
                        <input class="form-control parsley-validated" type="text" placeholder="输入名称"
                               data-parsley-maxlength="200"
                               data-parsley-maxlength-message="名称不能超过200字"
                               data-parsley-required="true" name="name" value="${(exam.name)!}">
                    </div><!-- /.col -->
                    <label class="col-lg-1 control-label">描述</label>
                    <div class="col-md-5">
                        <textarea class="form-control parsley-validated" name="description"
                                  data-parsley-maxlength="300"
                                  data-parsley-maxlength-message="问题不能超过300字"
                                  data-parsley-required="true"
                        >${(exam.description)!}</textarea>
                    </div><!-- /.col -->
                </div>
                <div class="form-group">
                    <label class="col-md-1 control-label">考试时长</label>
                    <div class="col-md-3">
                        <input class="form-control parsley-validated" name="time"
                                  data-parsley-max="600"
                                  data-parsley-min="0"
                                  data-parsley-required="true"
                                  value="${(exam.time)!}"
                        />
                    </div><!-- /.col -->
                    <label class="col-md-1 control-label">开始时间</label>
                    <div class="col-md-3">
                        <div class="input-group">
                            <input id="startTime" name="startTimeString" placeholder="请点击选择时间" class="form-control"
                                   readonly type="text"
                                   value="${(exam.startTime?string("yyyy-MM-dd HH:mm:ss"))!}"
                                   data-parsley-trigger="blur"/>
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                    </div>
                    <!-- /.col -->
                    <label class="col-md-1 control-label">结束时间</label>
                    <div class="col-md-3">
                        <div class="input-group">
                            <input id="endTime" name="endTimeString" placeholder="请点击选择时间" class="form-control"
                                   readonly type="text"
                                   value="${(exam.endTime?string("yyyy-MM-dd HH:mm:ss"))!}"
                                   data-parsley-trigger="blur" />
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                    </div>
                    <!-- /.col -->
                </div>
                <div class="form-group">
                    <label class="col-md-1 control-label">考试学生类型</label>
                    <div class="col-md-3">
                        <select name="roleId" id="roleId" class="form-control chzn-select"
                                data-placeholder="请选择标签类别">
                            <option value="">选填</option>
                            <#if sRoleList ?? >
                                <#list sRoleList as role >
                                    <#if (exam.roleId)?? && exam.roleId==role.roleId>
                                        <option value="${role.roleId}" selected>${role.name}</option>
                                    <#else>
                                        <option value="${role.roleId}">${role.name}</option>
                                    </#if>
                                </#list>
                            </#if>
                        </select>
                    </div>
                    <label class="col-md-1 control-label">考试状态</label>
                    <div class="col-md-3">
                        <select name="status" id="status" class="form-control chzn-select"
                                data-placeholder="请选择状态">
                            <option value="0" <#if ((exam.status)??&&exam.status=0)||!(exam??)>selected</#if>>正常</option>
                            <option value="1" <#if (exam.status)??&&exam.status=1>selected</#if>>公开</option>
                            <option value="2" <#if (exam.status)??&&exam.status=2>selected</#if>>保密</option>
                            <option value="-1" <#if (exam.status)??&&exam.status=-1>selected</#if>>禁用</option>
                        </select>
                    </div><!-- /.col -->
                    <label class="col-md-1 control-label">分数</label>
                    <div class="col-md-3">
                        <input class="form-control parsley-validated" type="text" placeholder="请输入分数"
                               data-parsley-max="100"
                               data-parsley-min="0"
                               name="score" value="${(exam.score)!}">
                    </div><!-- /.col -->
                </div>
                <div class="form-group">
                    <label class="col-md-1 control-label">考试类型</label>
                    <div class="col-md-3">
                        <select name="type" id="type" class="form-control chzn-select"
                                data-placeholder="请选择类型">
                            <option value="0" <#if (exam.type)??&&exam.type=0>selected</#if>>单次考试</option>
                            <option value="1" <#if (exam.type)??&&exam.type=1>selected</#if>>多次考试</option>
                        </select>
                    </div><!-- /.col -->
                </div>
                <div class="form-group">
                    <label class="col-md-1 control-label">问题类型</label>
                </div>
                <div class="form-group">
                    <div class="col-xs-12">
                        <div class="col-xs-4">
                            <button type="button" class="btn btn-info addQuestion" data-type="1" >添加 单选 </button>
                            <div class="col-xs-12" id="singleChoiceBox">
                                <#if (exam.singleChoiceList)??&&exam.singleChoiceList?size gt 0>
                                    <#list exam.singleChoiceList as choice>
                                        <div class="input-group">
                                            <input class="form-control" title='${"分数："+choice.score}' value='${choice.name}' readonly >
                                            <input type="hidden" name='singleChoiceArray' class="form-control" value='${choice.id}' >
                                            <span class="input-group-addon" onclick='$(this).parent().remove();'>删除</span>
                                        </div>
                                    </#list>
                                </#if>
                            </div>
                        </div>
                        <div class="col-xs-4">
                            <button type="button" class="btn btn-info addQuestion" data-type="2" >添加 多选 </button>
                            <div class="col-xs-12" id="multipleChoiceBox">
                                <#if (exam.multipleChoiceList)??&&exam.multipleChoiceList?size gt 0>
                                    <#list exam.multipleChoiceList as choice>
                                        <div class="input-group">
                                            <input class="form-control" title='${"分数："+choice.score}' value='${choice.name}' readonly >
                                            <input type="hidden" name='multipleChoiceArray' class="form-control" value='${choice.id}' >
                                            <span class="input-group-addon" onclick='$(this).parent().remove();'>删除</span>
                                        </div>
                                    </#list>
                                </#if>
                            </div>
                        </div>
                        <div class="col-xs-4">
                            <button type="button" class="btn btn-info addQuestion" data-type="3" >添加 判断 </button>
                            <div class="col-xs-12" id="tofBox">
                                <#if (exam.tofList)??&&exam.tofList?size gt 0>
                                    <#list exam.tofList as choice>
                                        <div class="input-group">
                                            <input class="form-control" title='${"分数："+choice.score}' value='${choice.name}' readonly >
                                            <input type="hidden" name='tofArray' class="form-control" value='${choice.id}' >
                                            <span class="input-group-addon" onclick='$(this).parent().remove();'>删除</span>
                                        </div>
                                    </#list>
                                </#if>
                            </div>
                        </div>
                    </div><!-- /.col -->
                </div>
				<div class="panel-footer text-center">
					<button type="button" class="btn btn-success" id="submitButton">提交</button>
					<button type="button" class="btn btn-default" onclick="javascript:history.go(-1);">取消</button>
				</div>
			</form>
	</div>
</div><!-- /panel -->

<div class="modal fade" id="formModal" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4>题目选择</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        搜索题目 （标题 或 ID）
                    </div>
                    <div class="form-group">
                        <input class="form-control" id="search-question">
                    </div>
                    <div class="form-group">
                        <div class="panel-body relative">
                            <select multiple="multiple" id="selectedBox1" class="select-box pull-left form-control">
                            </select>
                            <div class="select-box-option">
                                <a class="btn btn-sm btn-default" id="btnRemove">
                                    <i class="fa fa-angle-left"></i>
                                </a>
                                <a class="btn btn-sm btn-default" id="btnSelect">
                                    <i class="fa fa-angle-right"></i>
                                </a>
                                <div class="seperator"></div>
                                <a class="btn btn-sm btn-default" id="btnRemoveAll">
                                    <i class="fa fa-angle-double-left"></i>
                                </a>
                                <a class="btn btn-sm btn-default" id="btnSelectAll">
                                    <i class="fa fa-angle-double-right"></i>
                                </a>
                            </div>
                            <select multiple="multiple" id="selectedBox2" class="select-box pull-right form-control">
                            </select>
                        </div>
                    </div>

                    <div class="form-group text-right">
                        <a href="#" data-dismiss="modal" class="btn btn-default">取消</a>
                        <a href="#" class="btn btn-success" id="modal-confirm">确定</a>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>


<link href="${basePath}/resources/js/timepicker/jquery-ui-timepicker-addon.min.css" rel="stylesheet" type="text/css"/>
<script src="${basePath}/resources/js/timepicker/jquery-ui-timepicker-addon.min.js" type="text/javascript"></script>
<script src="${basePath}/resources/js/timepicker/jquery-ui-timepicker-zh-CN.js" type="text/javascript"></script>
<script language="javascript">
    $(function () {
        //时间选择器
        $('#startTime,#endTime').datetimepicker({
            dateFormat: 'yy-mm-dd',
            timeFormat: "HH:mm:ss",
//            minDate: new Date()
            //maxDate: new Date()
        });
        // Draggable Multiselect
        $('#btnSelect').click(function()	{
            $('#selectedBox1 option:selected').appendTo('#selectedBox2');
            return false;
        });
        $('#btnRemove').click(function()	{
            $('#selectedBox2 option:selected').appendTo('#selectedBox1');
            return false;
        });
        $('#btnSelectAll').click(function()	{
            $('#selectedBox1 option').each(function() {
                $(this).appendTo('#selectedBox2');
            });
            return false;
        });
        $('#btnRemoveAll').click(function()	{
            $('#selectedBox2 option').each(function() {
                $(this).appendTo('#selectedBox1');
            });
            return false;
        });
    });
</script>
<script language="javascript">
$("#submitButton").click(function(){
	if($('#formTag').parsley().validate()){

        var singleChoiceArray = $("#singleChoiceBox input[name='singleChoiceArray']");
        var multipleChoiceArray = $("#multipleChoiceBox input[name='multipleChoiceArray']");
        var tofArray = $("#tofBox input[name='tofArray']");

        if(singleChoiceArray.length>0||multipleChoiceArray.length>0||tofArray.length>0){
        }else{
            alertify.alert("请至少选择一个问题");
            return;
        }

		$.submitformTag();
	}
});

$.submitformTag = function(){
	$.ajax({
        cache: true,
        type: "POST",
        url:"${basePath}/exam/addOrUpdate",
        data:$('#formTag').serialize(),
        async: false,
        error: function(request) {
            alertify.alert("错误：服务器异常！");
        },
        success: function(data) {
        	if(data.success){
            	alertify.alert("操作成功！",function(e){location.href="${basePath}/exam/list";});
	        }
	        else{
            	alertify.alert("错误:" + data.message);
	        }
        }
    });
}
</script>
<script>
    !function () {
        var type = 1;
        $(function(){
            $(".addQuestion").on("click",function(){
                var typeString = $(this).attr("data-type");
                switch (typeString){
                    case "1":
                        type = 1;
                        break;
                    case "2":
                        type = 2;
                        break;
                    case "3":
                        type = 3;
                        break;
                }
                //清空
                $('#selectedBox1').html("");
                $('#selectedBox2').html("");
                $("#search-question").val("");

                $("#formModal").modal();

            });
            $("#search-question").on("keyup",function(){
                var text = $(this).val();
                if(text&&text!=''){
                    $.ajax({
                        cache: false,
                        type: "POST",
                        url:"${basePath}/exam/searchQuestion",
                        data:{text:text,type:type},
                        async: false,
                        error: function(request) {
                            alertify.alert("错误：服务器异常！");
                        },
                        success: function(data) {
                            if(data.success){
                                $('#selectedBox1').html("");
                                for(var i=0;i<data.list.length;i++){

                                    $("<option value='"+data.list[i].id+"'"+
                                            +"data-title='分数："+data.list[i].score+"'"
                                            +">"
                                            +data.list[i].name
                                            +"</option>").appendTo('#selectedBox1');
                                }
                            }else{
                                alertify.alert("错误:" + data.message);
                            }
                        }
                    });
                }
            });
            $("#modal-confirm").on("click",function(){
                var options = $('#selectedBox2 option');
                var box;
                var name;
                switch(type){
                    case 1:
                        box = $("#singleChoiceBox");
                        name = "singleChoiceArray";
                        break;
                    case 2:
                        box = $("#multipleChoiceBox");
                        name = "multipleChoiceArray";
                        break;
                    case 3:
                        box = $("#tofBox");
                        name = "tofArray";
                        break;
                }
                options.each(function(index,element){
                    //判断是否已经存在
                    var a = box.find("input[value='"+element.value+"']");
                    if(a.length==0){
                        box.append(
                                "<div class=\"input-group\">"
                                +"<input class=\"form-control\" "+
                                +"title='"+$(element).attr("data-title")+"'"
                                +" value='"+element.text+"' readonly >"
                                +"<input type=\"hidden\" name='"+name+"' class=\"form-control\" value='"+element.value+"' >"
                                +"<span class=\"input-group-addon\" onclick='$(this).parent().remove();'>删除</span>"
                                +"</div>"
                        );
                    }

                });
                $("#formModal").modal("hide");
            });
        });
    }();
</script>
</@master.masterFrame>