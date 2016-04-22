<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />
<@master.masterFrame pageTitle=["系统管理","客户","客户列表"]>
	<div class="panel-body">
		<a class="btn btn-xs btn-info" href="${basePath}/salesCust/add"><i class="fa fa-plus fa-lg"></i> 新增客户</a>
	</div>
	<div class="panel panel-default table-responsive">
		<div class="panel-heading">条件搜索</div>
		<div class="panel-body">
			<form id="searchForm" class="form-inline no-margin" action="${basePath}/salesCust/list">
				<div class="form-group" >
					<label class="control-label">报备状态</label>
					<select name="filingStatus" class="form-control chzn-select">
						<option value="">全部</option>
						<option value="0" <#if customer?? && customer.filingStatus ?? && customer.filingStatus==0>selected="selected"</#if>>未报备</option>
						<option value="1" <#if customer?? && customer.filingStatus ?? && customer.filingStatus==1>selected="selected"</#if>>已报备</option>
					</select>
				</div><!-- /form-group -->
				<div class="form-group" >
				    <label class="control-label">审核状态</label>
				    <select name="reviewStatus" class="form-control chzn-select">
						<option value="">全部</option>
						<option value="0" <#if customer?? && customer.reviewStatus?? && customer.reviewStatus==0>selected="selected"</#if>>待审核</option>
						<option value="1" <#if customer?? && customer.reviewStatus?? && customer.reviewStatus==1>selected="selected"</#if>>审核通过</option>
						<option value="-1" <#if customer?? && customer.reviewStatus?? && customer.reviewStatus==-1>selected="selected"</#if>>审核未通过</option>
					</select>
				</div><!-- /form-group -->
			 	
				<button type="submit" class="btn btn-sm btn-success"><i class="fa fa-search" style="font-size:16px;"></i></button>
			</form>
		</div>
		<table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
			<thead>
				<tr>
					<th>姓名</th>
					<th>性别</th>
					<th>手机号码</th>
					<th>居住城市</th>
					<th>报备状态</th>
					<th>审核状态</th>
					<th>创建时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<#list response.customerList as customer>
				<tr>
					<td>${customer.name}</td>
					<td><#if customer.gender=="M">男<#else>女</#if></td>
					<td>${customer.phone}</td>
					<td>${customer.city.cityName}</td>
					<td>
						<#if customer.filingStatus==0>
							<span class="label label-warning">未报备</span>
						<#else>
							<span class="label label-success">已报备</span>
						</#if>
					</td>
					<td>
						<#if customer.reviewStatus??>
							<#if customer.reviewStatus==0>
								<span class="label label-default">等待审核</span>
							<#elseif customer.reviewStatus==1>
								<span class="label label-success">审核通过</span>
							<#else>
								<span class="label label-danger">审核未通过</span>
							</#if>
						</#if>
					</td>
					<td>${customer.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
					<td>
						<a class="btn btn-xs btn-warning" href="${basePath}/salesCust/info?customerId=${customer.customerId}"><i class="fa fa-info-circle fa-lg"></i> 查看</a>
						<a class="btn btn-xs btn-success" href="${basePath}/salesCust/edit?customerId=${customer.customerId}"><i class="fa fa-wrench fa-lg"></i> 编辑</a>
						<a class="btn btn-xs btn-danger" href="javascript:void(0);" onclick="$.delSales(${customer.customerId});"><i class="fa fa-trash-o fa-lg"></i> 删除</a>
						<#if customer.filingStatus==0 || (customer.filingStatus==1&&customer.reviewStatus??&&customer.reviewStatus==-1)>
							<a  href="${basePath}/salesCust/edit?customerId=${customer.customerId}&flag=pre" class="btn btn-xs btn-info"><i class="fa fa-upload fa-lg"></i> 报备</a>
						</#if>
						
					</td>
				</tr>
				</#list>
			</tbody>
		</table>
		<@splitPage1.splitPage pageCount=response.splitPage.pageCount pageNo=response.splitPage.pageNo formId="searchForm" recordCount=response.splitPage.recordCount />
	</div><!-- /panel -->
	<script language="javascript">
	$.delSales = function(customerId){
		alertify.confirm("注意，客户一经删除，无法恢复！是否继续？", function (e) {
			if (e) {
				$.ajax({
			        cache: true,
			        type: "POST",
			        url:"${basePath}/salesCust/del",
			        data:"customerId=" + customerId,
			        async: false,
			        error: function(request) {
			            alertify.alert("错误：服务器异常！");
			        },
			        success: function(data) {
			        	if(data.success){   
			            	location.href="${basePath}/salesCust/list";
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