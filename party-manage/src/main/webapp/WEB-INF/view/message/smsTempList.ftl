<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />
<#import "/control/policy/countrySelect.ftl" as countrySelect1>

<@master.masterFrame pageTitle=["基础数据管理","短信模板","短信模板列表"]>
	<div class="panel panel-default table-responsive">
	<div class="panel-body">
		<a class="btn btn-xs btn-info" href="${basePath}/smsTemp/addSmsTemp" ><i class="fa fa-plus fa-lg"></i> 新增</a>
	</div>
	
		<table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
			<thead>
				<tr>
					<th>模板ID</th>
					<th>模板名称</th>
					<th>模板内容</th>
					<th>模板类型</th>
					<th>有效标识</th>
					<th>创建时间</th>
					<th>最后修改时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			
				<#if smsTempList?? && smsTempList?size gt 0>
					<#list smsTempList as smsTemp>
						<tr>
							<td>${smsTemp.msgTemplateId!}</td>
							<td>${smsTemp.title!}</td>
							<td>${smsTemp.content!}</td>
							<td>${(smsTemp.tempType==1)?string('系统模板','用户模板')}</td>
							<td>${(smsTemp.isValid)?string('是','否')}</td>
							<td>${smsTemp.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
							<td>${smsTemp.lastModifyTime?string('yyyy-MM-dd HH:mm:ss')}</td>
							<td>
								<a class="btn btn-xs btn-success" href="${basePath}/smsTemp/editSmsTemp?tempId=${smsTemp.msgTemplateId}"><i class="fa fa-wrench fa-lg"></i> 编辑</a>
								
							</td>
						</tr>
					</#list>
				<#else>
					<tr><td colspan=9 class="text-center">没有数据</td></tr>
				</#if>
			</tbody>
		</table>

	</div><!-- /panel -->
	</div>

	<script language="javascript">

	$.delAttr = function(tempId){
		alertify.confirm("注意，短信模板属性一经删除，无法恢复！是否继续？", function (e) {
			if (e) {
				$.ajax({
			        cache: true,
			        type: "POST",
			        url:"${basePath}/smsTemp/del",
			        data:"tempId=" + tempId,
			        async: false,
			        error: function(request) {
			            alertify.alert("错误：服务器异常！");
			        },
			        success: function(data) {
			        	if(data.success){   
			            	location.href="${basePath}/smsTemp/list";
			        }   
			        else{   
		            	alertify.alert("错误:" + data.message);
			        }   
		        }
    		});
		}
	});
};
	</script>
</@master.masterFrame>