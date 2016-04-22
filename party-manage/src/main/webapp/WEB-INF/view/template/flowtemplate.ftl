<#import "/master/master-frame.ftl" as master />
<#if policytemplate??>
    <#assign title=["模版管理","更新模版"]>
<#else>
    <#assign title=["模版管理","新增模版"]>
</#if>
<@master.masterFrame pageTitle=title>


<div class="panel-heading">政策:${policymodel.policyName!}</div>
<input type="hidden" id="policyId" value="${policyId!}"/>
<div class="padding-md">
            <div class="panel panel-default">
                <div class="panel-body panel panel-default table-responsive">
                    <form id="templateForm" class="form-horizontal no-margin form-border form-border " data-parsley-validate>
                        <table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
                            <thead>
                            <tr>
                                <th>节点序号</th>
                                <th>节点名称</th>
                                <th>节点描述</th>
                                <th>前置节点</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <#if policytemplate??>
                                <#list policytemplate as task>
                                <tr>
                                    <td><input type="text" value="${task.taskIdx}" disabled="disabled" /> </td>
                                    <td><input type="text" value="${task.taskName!}" disabled="disabled"
                                               placeholder="请输入节点名称"
                                               data-parsley-trigger="blur"
                                               data-parsley-required="true"
                                               data-parsley-required-message="节点名称不可为空"
                                               data-parsley-maxlength="6"
                                               data-parsley-maxlength-message="长度不能超过6个字符"
                                            /></td>
                                    <td><input type="text" value="${task.taskDescript!}" disabled="disabled"
                                               placeholder="请输入节点描述"
                                               data-parsley-trigger="blur"
                                               data-parsley-required="true"
                                               data-parsley-required-message="节点描述不可为空"
                                               data-parsley-maxlength="99"
                                               data-parsley-maxlength-message="长度不能超过100个字符"
                                            />
                                    </td>
                                    <td><input type="text" value="${task.preTaskIdx}" disabled="disabled" /></td>
                                    <td>
                                        <a data-action="save" style="display: none" class="btn btn-xs btn-success" href="javascript:void(0);"><i class="fa fa-wrench fa-lg"></i> 保存</a>
                                        <a data-action="cancel" style="display: none"  class="btn btn-xs btn-info" href="javascript:void(0);"><i class="fa fa-wrench fa-lg"></i> 取消</a>
                                        <a data-action="update" class="btn btn-xs btn-info" href="javascript:void(0);"><i class="fa fa-wrench fa-lg"></i> 编辑</a>
                                        <a data-action="del" class="btn btn-xs btn-danger" href="javascript:void(0);" ><i class="fa fa-trash-o fa-lg"></i> 删除</a>
                                    </td>
                                </tr>
                                </#list>
                            </#if>

                            </tbody>
                        </table>
                    </form>
                </div>
            </div><!-- /panel -->
</div>
<!--模版开始-->
<table>
<tr id="template" style="display: none">
    <td><input type="text" value="" placeholder="请输入节点序号"
               data-parsley-trigger="blur"
               data-parsley-required="true"
               data-parsley-required-message="节点序号不可为空"
               data-parsley-type="number"
               data-parsley-min="1"
               data-parsley-min-message="序号必须大于0"
               data-parsley-type-message="只能输入数字,且必须大于0"
            /></td>
    <td><input type="text" value=""
               placeholder="请输入节点名称"
               data-parsley-trigger="blur"
               data-parsley-required="true"
               data-parsley-required-message="节点名称不可为空"
               data-parsley-maxlength="6"
               data-parsley-maxlength-message="长度不能超过6个字符"
            /></td>
    <td><input type="text" value=""
               placeholder="请输入节点描述"
               data-parsley-trigger="blur"
               data-parsley-required="true"
               data-parsley-required-message="节点描述不可为空"
               data-parsley-maxlength="99"
               data-parsley-maxlength-message="长度不能超过100个字符"
            />
    </td>
    <td><input type="text" value="" placeholder="请输入前置节点序号"
               data-parsley-trigger="blur"
               data-parsley-required="true"
               data-parsley-required-message="前置节点序号不可为空"
               data-parsley-type="number"
               data-parsley-min="1"
               data-parsley-min-message="序号必须大于0"
               data-parsley-type-message="只能输入数字，且大于0"
            />
    </td>
    <td>
        <a data-action="save"  class="btn btn-xs btn-success" href="javascript:void(0);"><i class="fa fa-wrench fa-lg"></i> 保存</a>
        <a data-action="cancel" style="display: none"  class="btn btn-xs btn-info" href="javascript:void(0);"><i class="fa fa-wrench fa-lg"></i> 取消</a>
        <a data-action="update" style="display: none" class="btn btn-xs btn-info" href="javascript:void(0);"><i class="fa fa-wrench fa-lg"></i> 编辑</a>
        <a data-action="del" class="btn btn-xs btn-danger" href="javascript:void(0);" ><i class="fa fa-trash-o fa-lg"></i> 删除</a>
    </td>
</tr>
</table>
<!--模版结束-->
<div class="panel-body text-center">
    <span class="btn btn-xs btn-info" id="add"><i class="fa fa-plus fa-lg"></i> 新增节点</span>
</div>
<script language="javascript">
    $(function(){
        //保存节点
        $('td > a[data-action="save"]').on('click',function(){
            if($('#templateForm').parsley().validate() ) {
                var tr = $(this).parent().parent();
                var parameter = {};
                parameter.policyId = $('#policyId').val();
                parameter.taskIdx = tr.find('input').first().val();
                parameter.preTaskIdx = tr.find('input').eq(3).val();
                parameter.taskName = tr.find('input').eq(1).val();
                parameter.taskDescript = tr.find('input').eq(2).val();

                if(parseInt(parameter.taskIdx) ==  1 && parseInt(parameter.preTaskIdx)!=1){
                    alertify.alert("首节点的前置节点序号等于首节点的序号");
                    return false;
                }
                if(parseInt(parameter.taskIdx) !=1 && parseInt(parameter.preTaskIdx) >= parseInt(parameter.taskIdx) ){
                    alertify.alert("除首节点外，前置节点序号应该小于当前节点序号！");
                    return false;
                }

                $.updatetask(parameter);
                tr.find('input').attr('disabled', 'disabled');
                tr.find('a').show();
                tr.find('a[data-action="save"],a[data-action="cancel"]').hide();
            }
        });

        //更新节点
        $('td > a[data-action="update"]').on('click',function(){
            var tr = $(this).parent().parent();
            tr.find('a').hide();
            tr.find('input:eq(1),input:eq(2)').removeAttr("disabled");
            tr.find('a[data-action="save"],a[data-action="cancel"]').show();
        });

        //取消更新
        $('td > a[data-action="cancel"]').on('click',function(){
            var tr = $(this).parent().parent();
            tr.find('a').show();
            tr.find('input').attr("disabled","disabled");
            tr.find('a[data-action="save"],a[data-action="cancel"]').hide();
        });

        //删除节点
        $('td > a[data-action="del"]').on('click',function(){
            var tr = $(this).parent().parent();

            var paramater = {};
            paramater.policyId = $('#policyId').val();
            paramater.taskIdx = tr.find('input').first().val();

            var isold = tr.find('input').first().attr("disabled") == "disabled";

            if(isold){
                $.deltask(paramater,tr);
            }else{
                tr.fadeOut('slow',function(){
                    tr.remove();
                });
            }

        });

        $.addTemplate = function(){
            var clone = $('#template').clone(true).attr('id','');
            clone.fadeIn('slow').appendTo($('#templateForm tbody'));
        };

        //新增节点
        $('#add').on('click',$.addTemplate);


        $.addtask = function(parameter){
            $.ajax({
                cache: false,
                type: "POST",
                url:"${basePath}/flowtemplate/addtask",
                data:parameter,
                async: true,
                error: function(request) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function(data) {
                    if(data.success){
                        alertify.alert("添加成功！");
                    }
                    else{
                        alertify.alert("错误:" + data.message);
                    }
                }
            });
        }


        $.deltask = function(parameter,task){
            $.ajax({
                cache: false,
                type: "POST",
                url:"${basePath}/flowtemplate/deltask",
                data:parameter,
                async: false,
                error: function(request) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function(data) {
                    if(data.success){
                        task.fadeOut('slow',function(){
                            task.remove();
                        });
                    }
                    else{
                        alertify.alert("错误:" + data.message);
                    }
                }
            });
        }

        $.updatetask = function(parameter){
            $.ajax({
                cache: false,
                type: "POST",
                url:"${basePath}/flowtemplate/updatetask",
                data:parameter,
                async: false,
                error: function(request) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function(data) {
                    if(data.success){
                        alertify.alert("更新成功！");
                    }
                    else{
                        alertify.alert("错误:" + data.message);
                    }
                }
            });
        }
    });


</script>
</@master.masterFrame>