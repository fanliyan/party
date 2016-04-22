<#import "/master/master-frame.ftl" as master />
<@master.masterFrame showNotice=false>

<div class="main-header clearfix">
	<div class="page-title">
		<h3 class="no-margin">欢迎回来！</h3>
		<span>欢迎回到云平台，您上次登录的IP：${loginUserModel.lastLoginIp!"暂无"} 登录时间：${loginUserModel.lastLoginTime?string('yyyy-MM-dd HH:mm:ss')}</span>
	</div><!-- /page-title -->
</div>
<div class="col-md-12 col-lg-12">
	<div class="panel panel-default">
		<div class="panel-heading">
			您在云平台拥有的角色
		</div>
		<div class="panel-body">
			<span class="label label-primary">云平台用户</span>
			<#list loginUserModel.hasRoles as role>
				<span class="label label-success">${role.name}</span>
			</#list>
		</div>
	</div>
</div>

<#--<#if listMap ?? && (listMap?size >0)>-->
	<#--<#list listMap as info>-->
		<#--<#list info?keys as key>-->
			<#--<div class="col-md-6 col-lg-6">-->
				<#--<div class="panel panel-default">-->
					<#--<div class="panel-body">-->
						<#--<div id='${key}'></div>-->
					<#--</div>-->
				<#--</div>-->
			<#--</div>	-->
		<#--</#list>-->
	<#--</#list>-->
<#--<#else>	-->
<#--</#if>						-->
<script src="${basePath}/resources/js/highcharts/highcharts.js"></script>
<script>
$(document).ready(function(){
<#if listMap ?? && (listMap?size >0)>
	<#list listMap as info>
		<#list info?keys as key>
			<#assign response=info[key]/>
			<#if response.sqlInfoList?size gt 0>
				$('#${key}').highcharts({
					chart: {
						type: '${response.reportInfo.reportType}'
					},
					title: {
						text: '${response.reportInfo.reportName}'
					},
					xAxis: {
						categories: [
							<#if response??>
								<#list response.sqlInfoList as sqlInfo>
									<#if sqlInfo_index==0>
										${sqlInfo.xaxisData}
									</#if>
								</#list>
							</#if>
						]
					},
					yAxis: {
						min: 0, 
						allowDecimals:false,
						title: {
							text: '${response.reportInfo.yaxisTip}'
						},
						labels: {
							formatter: function () {
								return this.value + '(${response.reportInfo.yaxisUnit})';
							}
						}
					},
					tooltip: {
						crosshairs: true,
						shared: true
					},
					plotOptions: {
						spline: {
							marker: {
								radius: 4,
								lineColor: '#666666',
								lineWidth: 1
							},dataLabels: {
								enabled: true
							},
							enableMouseTracking: false
						}
					},
					 series: [
					 	<#if response??>
							<#list response.sqlInfoList as sqlInfo>
								{
								name: '${sqlInfo.exampleName}',
								data: [${sqlInfo.yaxisData}]
								}
								<#if sqlInfo_index lt (response.sqlInfoList?size-1)>
									,
								</#if>
							</#list>
						</#if>
					],
					lang:{
						noData: "没有数据"
					}
				});
			</#if>			
		</#list>
	</#list>
<#else>	
</#if>	
});

</script>
</@master.masterFrame>
