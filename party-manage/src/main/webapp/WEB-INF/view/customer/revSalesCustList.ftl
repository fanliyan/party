<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />
<@master.masterFrame pageTitle=["系统管理","客户","已报备客户列表"]>
	<div class="panel panel-default table-responsive">
		<div class="panel-heading">条件搜索</div>
		<div class="panel-body">
			<form id="searchForm" class="form-inline no-margin" action="${basePath}/preSalesCust/list">
				<div class="form-group" >
					<label class="control-label">姓名</label>
					<div>
					<input name="name" type="text" class="form-control input-sm" value="<#if customer ??> ${customer.name! }</#if>"/>
					</div>
				</div><!-- /form-group -->
				<div class="form-group" >
					<label class="control-label">手机号码</label>
					<div>
					<input name="phone" type="text" class="form-control input-sm" value="<#if customer ??> ${customer.phone! }</#if>"/>
					</div>
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
					<th>经纪人</th>
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
					<td>${customer.salesUser.userName!}</td>
					<td>${customer.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
					<td>
						<a class="btn btn-xs btn-success" href="${basePath}/preSalesCust/edit?customerId=${customer.customerId}"><i class="fa fa-wrench fa-lg"></i> 审核</a>
					</td>
				</tr>
				</#list>
			</tbody>
		</table>
		<@splitPage1.splitPage pageCount=response.splitPage.pageCount pageNo=response.splitPage.pageNo formId="searchForm" recordCount=response.splitPage.recordCount />
	</div><!-- /panel -->
</@master.masterFrame>