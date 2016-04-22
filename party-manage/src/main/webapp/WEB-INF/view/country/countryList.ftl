<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />
<@master.masterFrame pageTitle=["系统管理","国家管理","国家列表"]>
	<div class="panel panel-default table-responsive">
		<div class="panel-heading">条件搜索</div>
		<div class="panel-body">
			<form id="searchForm" class="form-inline no-margin" action="${basePath}/country/list" method="post">
				<div class="form-group" style="margin-right:10px;">
					<label class="control-label">是否意向国家</label>
					<select class="form-control chzn-select" name="isMigrant" id="" >
						<option value="">全部</option>
						<option value="1" <#if isMigrant?? && isMigrant==1>selected="selected"</#if>>是</option>
						<option value="0" <#if isMigrant?? && isMigrant==0>selected="selected"</#if>>否</option>
					</select>
				</div><!-- /form-group -->
				<div class="form-group" style="margin-right:10px;">
					<label class="control-label">国家名称</label>
					<div>
						<input name="countryName" class="form-control" type="text" value="${countryName!}"/>
					</div>
				</div><!-- /form-group -->
				<button type="submit" class="btn btn-sm btn-success"><i class="fa fa-search" style="font-size:16px;"></i></button>
			</form>
		</div>
		<table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
			<thead>
				<tr>
					<th>国家ID</th>
					<th>国家名称</th>
					<th>是否移民国家</th>
					<th>国家英文名</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<#list response.countryList as country>
				<tr>
					<td>${country.countryId}</td>
					<td>${country.countryName}</td>
					<td>
						<#if country.isMigrant?? && country.isMigrant>
							<span class="label label-success">是</span>
						<#else>
							<span class="label label-default">否</span>
						</#if>
					</td>
					<td>${country.eName!}</td>
					<td>
						<a class="btn btn-xs btn-warning" href="${basePath}/country/info?countryId=${country.countryId}"><i class="fa fa-info-circle fa-lg"></i> 查看</a>
						<a class="btn btn-xs btn-success" href="${basePath}/country/edit?countryId=${country.countryId}"><i class="fa fa-wrench fa-lg"></i> 编辑</a>
					</td>
				</tr>
				</#list>
			</tbody>
		</table>
		<@splitPage1.splitPage pageCount=response.splitPage.pageCount pageNo=response.splitPage.pageNo formId="searchForm" recordCount=response.splitPage.recordCount />
	</div><!-- /panel -->
	<script language="javascript">
	$.delCompany = function(companyCode){
		alertify.confirm("注意，机构一经删除，无法恢复！是否继续？", function (e) {
			if (e) {
				$.ajax({
			        cache: true,
			        type: "POST",
			        url:"${basePath}/company/del",
			        data:"companyCode=" + companyCode,
			        async: false,
			        error: function(request) {
			            alertify.alert("错误：服务器异常！");
			        },
			        success: function(data) {
			        	if(data.success){   
			            	location.href="${basePath}/company/list"; 	             
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