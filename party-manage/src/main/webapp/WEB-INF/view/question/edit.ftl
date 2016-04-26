<#import "/master/master-frame.ftl" as master />
<#if question??>
	<#assign title=["考试管理","问题","修改问题"]>
<#else>
	<#assign title=["考试管理","问题","新增问题"]>
</#if>
<@master.masterFrame pageTitle=title>
<div class="panel panel-default">
		<div class="panel-body">
			<form id="formTag" class="form-horizontal no-margin form-border" >

				<#if question??>
                    <input type="hidden" name="id" value="${question.id!}" />
                    <input type="hidden" name="isUpdate" value="true" />
				</#if>
                <div class="form-group">
                    <label class="col-lg-1 control-label">问题名称</label>
                    <div class="col-md-5">
                        <input class="form-control parsley-validated" type="text" placeholder="输入名称"
                               data-parsley-maxlength="200"
                               data-parsley-maxlength-message="名称不能超过200字"
                               data-parsley-required="true" name="name" value="${(question.name)!}">
                    </div><!-- /.col -->
                </div>
                <div class="form-group">
                    <label class="col-lg-1 control-label">问题</label>
                    <div class="col-md-5">
                        <textarea class="form-control parsley-validated" name="question"
                                  data-parsley-maxlength="300"
                                  data-parsley-maxlength-message="问题不能超过300字"
                                  data-parsley-required="true"
                        >${(question.question)!}</textarea>
                    </div><!-- /.col -->
                </div>
                <div class="form-group">
                    <label class="col-md-1 control-label">考试学生类型</label>
                    <div class="col-md-2">
                        <select name="roleId" id="roleId" class="form-control chzn-select"
                                data-placeholder="请选择标签类别">
                            <option value="">选填</option>
                            <#if sRoleList ?? >
                                <#list sRoleList as role >
                                    <#if (question.roleId)?? && question.roleId==role.roleId>
                                        <option value="${role.roleId}" selected>${role.name}</option>
                                    <#else>
                                        <option value="${role.roleId}">${role.name}</option>
                                    </#if>
                                </#list>
                            </#if>
                        </select>
                    </div>
                    <label class="col-md-1 control-label">问题状态</label>
                    <div class="col-md-2">
                        <select name="status" id="status" class="form-control chzn-select"
                                data-placeholder="请选择状态">
                            <option value="0" <#if ((question.status)??&&question.status=0)||!(question??)>selected</#if>>正常</option>
                            <option value="1" <#if (question.status)??&&question.status=1>selected</#if>>公开</option>
                            <option value="2" <#if (question.status)??&&question.status=2>selected</#if>>保密</option>
                            <option value="-1" <#if (question.status)??&&question.status=-1>selected</#if>>禁用</option>
                        </select>
                    </div><!-- /.col -->
                    <label class="col-md-1 control-label">难度</label>
                    <div class="col-md-2">
                        <input class="form-control parsley-validated" type="text" placeholder="默认5"
                               data-parsley-max="20"
                               data-parsley-min="0"
                               name="weight" value="${(question.weight)!}">
                    </div><!-- /.col -->
                    <label class="col-md-1 control-label">分数</label>
                    <div class="col-md-2">
                        <input class="form-control parsley-validated" type="text" placeholder="请输入分数"
                               data-parsley-max="100"
                               data-parsley-min="0"
                               name="score" value="${(question.score)!}">
                    </div><!-- /.col -->
                </div>
                <div class="form-group">
                    <label class="col-md-1 control-label">问题类型</label>
                    <div class="col-md-11">
                        <div class="btn-group btn-group-justified" id="type">
                            <a href="#" class="btn btn-default
                               <#if (question.type)??&&question.type=1 >active</#if>">单选</a>
                            <a href="#" class="btn btn-default
                               <#if (question.type)??&&question.type=2 >active</#if>">多选</a>
                            <a href="#" class="btn btn-default
                               <#if (question.type)??&&question.type=3 >active</#if>">判断</a>
                        </div>

                        <input type="hidden" name="type" value="${(question.type)!}">
                    </div><!-- /.col -->
                </div>
                <div class="form-group" >
                    <div class="col-md-12">
                        <button type="button" class="btn btn-info" id="addAnswer">添加答案</button>
                        <span class="label"> Tips:正确答案打钩</span>
                    </div>
                </div>
                <div class="form-group" id="transform">
                    <#if question??>
                        <#assign type=(question.type==2)?string("checkbox","radio")>
                    </#if>
                    <#if question??&&question.choiceModelList??&&question.choiceModelList?size gt 0 && question.rightAnswerList??&&question.rightAnswerList?size gt 0>
                        <#list question.choiceModelList as choice>
                            <div class="input-group">
                                <span class="input-group-addon answer-name-check-span" >
                                    <label class="label-${type} no-padding answer-name-check-label ">
                                         <input type="${type}" name='answer-name-check'
                                            <#list question.rightAnswerList as right>
                                                <#if choice.value==right>checked</#if>
                                            </#list>
                                         >
                                        <span class="custom-${type}"></span>
                                    </label>
                                </span>
                                <input type="text" name='answerNameArray' class="form-control parsley-validated" value="${choice.name}"  data-parsley-required="true">
                                <span class="input-group-addon" onclick='$(this).parent().remove();'>删除</span>
                            </div>
                        </#list>
                    </#if>
                </div>
                <div class="form-group" id="rightAnswer">
                    <#if (question.rightAnswerList)??>
                        <#list question.rightAnswerList as right>
                            <input type="hidden" name='rightAnswerArray' value='${right}'>
                        </#list>
                    </#if>
                </div>
				<div class="panel-footer text-center">
					<button type="button" class="btn btn-success" id="submitButton">提交</button>
					<button type="button" class="btn btn-default" onclick="javascript:history.go(-1);">取消</button>
				</div>
			</form>
	</div>
</div><!-- /panel -->

<script language="javascript">
$("#submitButton").click(function(){
	if($('#formTag').parsley().validate()){

        var a = $("#rightAnswer");
        a.html("");
        $("input[name='answer-name-check']:checked").each(function(index,element){
            var b = $(element).parent().parent().next("input").val();
            if(b==""){
                alertify.alert("选项不能为空");
                return;
            }
            a.append("<input type=\"hidden\" name='rightAnswerArray' value='"+b+"'>");
        });

        if($("input[name='type']").val()==''){
            alertify.alert("请选择题型");
            return;
        }
        if($("input[name='rightAnswerArray']").length==0){
            alertify.alert("请添加答案(必须有正确答案)");
            return;
        }


		$.submitformTag();
	}
});

$.submitformTag = function(){
	$.ajax({
        cache: true,
        type: "POST",
        url:"${basePath}/question/addOrUpdate",
        data:$('#formTag').serialize(),
        async: false,
        error: function(request) {
            alertify.alert("错误：服务器异常！");
        },
        success: function(data) {
        	if(data.success){
            	alertify.alert("操作成功！",function(e){location.href="${basePath}/question/list";});
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
        $(function(){
            var i=0;
            //最多20选项
            var maxInputDefault = 20;
            var maxInput;
            $("#type a").on("click",function(){
                $("#type a").not(this).removeClass("active");
                $(this).addClass("active");
                $("input[name='type']").val($(this).index()+1);
                $("#transform").html("");
                $("#rightAnswer").html("");
                i=0;
            });
            $("#addAnswer").on("click",function(){
                var n = $("input[name='type']").val();
                if(n==''){
                    alertify.alert("请选择题型");
                    return;
                }

                var type;
                switch (n){
                    case "1":
                        type="radio";
                        maxInput = maxInputDefault;
                        break;
                    case "2":
                        type="checkbox";
                        maxInput = maxInputDefault;
                        break;
                    case "3":
                        type="radio";
                        maxInput = 2;
                        break;
                }

                if(i>=maxInput){
                    alertify.alert("超过最大选项值：" +maxInput);
                    return;
                }

               $("#transform").append(
                "<div class=\"input-group\">"
                +"<span class=\"input-group-addon answer-name-check-span\" >"
                +"<label class=\"label-"+type+" no-padding answer-name-check-label\">"
                +"<input type=\""+type+"\" name='answer-name-check'>"
                +"<span class=\"custom-"+type+"\"></span>"
                +"</label>"
                +"</span>"
                +"<input type=\"text\" name='answerNameArray' class=\"form-control parsley-validated\"  data-parsley-required=\"true\">"
                +"<span class=\"input-group-addon\" onclick='$(this).parent().remove();'>删除</span>"
                +"</div>");

                i++;
            });
//            $(document).on("click",".answer-name-check-span",function(){
//                var a = $("#rightAnswer");
//                a.html("");
//                $("input[name='answer-name-check']:checked").each(function(index,element){
//                    var b = $(element).parent().parent().next("input").val();
//                    if(b==""){
//                        $(element).parent().parent().next("input").removeProp("checked");
//                        $(element).removeClass("active");
//                        alertify.alert("请先输入选项");
//                        return;
//                    }
//                    a.append("<input type=\"hidden\" name='rightAnswerArray' value='"+b+"'>");
//                });
//            });

        });
    }();
</script>
</@master.masterFrame>