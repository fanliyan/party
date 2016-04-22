<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />
<@master.masterFrame pageTitle=["模版管理","模版列表"]>
<div class="panel panel-default table-responsive">
    <form id="searchForm" class="form-inline no-margin" action="${basePath}/flowtemplate/list" method="post">
    </form>
    <table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
        <thead>
        <tr>
            <th>政策名称</th>
            <th>所属国家</th>
            <#--<th>最近更新时间</th>-->
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <#if policyModelList?? && policyModelList?size &gt; 0>
            <#list policyModelList as policyModel>
            <tr id="${policyModel.policyId}">
                <td title="${policyModel.policyName!}"><#if policyModel.policyName?length &lt; 40 >${policyModel.policyName}<#else>${policyModel.policyName?substring(0,40) + '...'}</#if></td>
                <td>${policyModel.country.countryName!}</td>
                <#--<td>${policyModel.lastModifyTime?string("yyyy-MM-dd HH:mm")}</td>-->
                <td>
                    <a class="btn btn-xs btn-success" href="${basePath}/flowtemplate/flowtemplate?policyId=${policyModel.policyId}"><i class="fa fa-wrench fa-lg"></i> 编辑模版</a>
                    <a class="btn btn-xs btn-danger" href="javascript:void(0);" onclick="$.delTemplate(${policyModel.policyId})"><i class="fa fa-wrench fa-lg"></i> 删除模版</a>
                    <!--a class="btn btn-xs btn-danger" href="javascript:void(0);" ><i class="fa fa-trash-o fa-lg"></i> 删除</--a-->
                </td>
            </tr>
            </#list>
        </#if>
        </tbody>
    </table>
    <@splitPage1.splitPage pageCount=splitPage.pageCount pageNo=splitPage.pageNo formId="searchForm" recordCount=splitPage.recordCount />
</div><!-- /panel -->



<div class="panel-heading">新增模版</div>
<div class="panel-body col-md-6 col-lg-11">
    <div class="form-group" style="margin-right:10px;">
        <label class="control-label">政策名称</label>
        <div class="search-block">
            <div class="input-group col-md-4">
                <input type="text" name="policyName" id="policyName"  class="form-control input-sm" placeholder="政策名称关键字">
						<span class="input-group-btn">
							<button class="btn btn-default btn-sm" id ="searchBtn"  type="button"><i class="fa fa-search"></i></button>
						</span>
            </div><!-- /input-group -->
        </div>
    </div><!-- /form-group -->



</div>
<table class="table table-bordered table-condensed table-hover table-striped" id="policytable" style="display: none">
    <thead>
    <tr>
        <th>政策ID</th>
        <th>政策名称</th>
        <th>所属国家</th>
        <th>最后修改时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>

    </tbody>
</table>
</div><!-- /panel -->

<script language="javascript">
    $.delTemplate = function(policyId){
        alertify.confirm("注意，模版一经删除，无法恢复！是否继续？", function (e) {
            if (e) {
                $.ajax({
                    cache: true,
                    type: "POST",
                    url:"${basePath}/flowtemplate/del",
                    data:"policyId=" + policyId,
                    async: false,
                    error: function(request) {
                        alertify.alert("错误：服务器异常！");
                    },
                    success: function(data) {
                        if(data.success){
                            var target = $('#'+policyId);
                            target.fadeOut('slow',function(){
                                target.remove();
                            });
                        }
                        else{
                            alertify.alert("错误:" + data.message);
                        }
                    }
                });
            }
        });
    };



    $('#searchBtn').on('click',function(){
        $.ajax({
            cache: true,
            type: "get",
            url:"${basePath}/flowtemplate/policysearch",
            data:"policyName=" + $('#policyName').val(),
            async: true,
            error: function(request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function(data) {
                $('#policytable tbody').html('');
                if(data.list && data.list.length>0){
                    for(var i=0;i<data.list.length;i++){
                        var html="<tr><td>" +
                                 data.list[i].policyId+
                                "</td><td>" +
                                 data.list[i].policyName+
                                "</td><td>" +
                                 data.list[i].country.countryName+
                                "</td><td>" +
                                 new Date(data.list[i].lastModifyTime).toLocaleDateString() +
                                 "</td><td>" +
                                 '<a class="btn btn-xs btn-success" href="javascript:void(0);$.addTemplate('+ data.list[i].policyId +
                                 ')"><i class="fa fa-wrench fa-lg"></i> 创建模版</a>'+
                                 "</td></tr>";
                        $('#policytable tbody').append(html);
                    }
                    $('#policytable').fadeIn('slow');

                }
                else{
                    alertify.alert("错误:" + data.message);
                }
            }
        });
    });


    $.addTemplate = function(policyId){
        $.ajax({
            cache: true,
            type: "POST",
            url:"${basePath}/flowtemplate/checkexist",
            data:"policyId=" + policyId,
            async: true,
            error: function(request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function(data) {
                if(data.success){
                    alertify.alert("错误"+data.msg);
                }
                else{
                    window.location.href = '${basePath}/flowtemplate/flowtemplate?policyId='+policyId;
                }
            }
        });
    };
</script>
</@master.masterFrame>