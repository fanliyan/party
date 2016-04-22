		<table border="1">
			<thead>
				<tr>
					<th>序号</th>
					<th>客户编码</th>
					<th>姓名</th>
					<th>居住城市</th>
					<th>客户来源</th>
					<th>来源说明</th>
					<th>录入日期</th>
					<th>跟进顾问</th>
					<th>最新进度</th>
					<th>最新跟进日期</th>
					<th>客户状态</th>
					<th>跟进记录</th>
					<th>备注</th>
				</tr>
			</thead>
			<tbody>
				<#list customerList as customer>
				<tr>
					<td>${customer_index+1}</td>
					<td>${customer.customerId}</td>
					<td>${customer.name}</td>
					<td>${(customer.province.provinceName)!}<#if (customer.province.provinceName)??&&(customer.city.cityName)??>-</#if>${(customer.city.cityName)!}</td>
					<td>${customer.sourceName!}</td>
					<td>${customer.sourceRemark!}</td>
					<td>${customer.createTime?string('yyyy-MM-dd')}</td>
					<td>${(customer.adviserUser.userName)!}</td>
					<td>
						<#if (customer.followLog)?? && customer.followLog?size gt 0>
							已跟进
						<#else>
							未跟进
						</#if>
					</td>
					<td>
						<#if (customer.followLog)?? && customer.followLog?size gt 0>
							<#list customer.followLog as followLog>
								<#if followLog_index == 0>
									${followLog.followTime?string('yyyy-MM-dd')}
								</#if>
							</#list>
						</#if>
					</td>
					<td>${(customer.statusName)!}</td>
					<td>
						<#if (customer.followLog)?? && customer.followLog?size gt 0>
							<#list customer.followLog as followLog>
								${followLog.followTime?string('yyyy-MM-dd')}&nbsp;${followLog.followDesc!}<br/>
							</#list>
						</#if>
					</td>
					<td>${customer.remark!}</td>
				</tr>
				</#list>
			</tbody>
		</table>