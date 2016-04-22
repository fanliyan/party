<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["报表","报表详细"]>
	<div class="panel panel-default">
		<div class="panel-body">按条件查看
			<form id="searchForm" class="form-inline no-margin" action="${basePath}/advisorReport/report" method="post">
				<div class="form-group" >
					<label class="control-label">开始时间</label>
					<div>
						<input id="beginTime" name="begin" placeholder="请选择开始时间" class="form-control input-sm" 
						 data-parsley-pattern="\d{4}-\d{2}-\d{2}" data-parsley-pattern-message="日期必须是yyyy-MM-dd的格式"
						  data-parsley-required="true" data-parsley-message="开始时间不能为空"
						 type="text" value="${begin!}" />
						</div>
				</div>
				<div class="form-group">
					<label class="control-label">结束时间</label>
					<div>
						<input id="endTime" name="end" placeholder="请选择结束时间" class="form-control input-sm" 
						 data-parsley-pattern="\d{4}-\d{2}-\d{2}" data-parsley-pattern-message="日期必须是yyyy-MM-dd的格式"
						 data-parsley-required="true" data-parsley-message="结束时间不能为空
						 type="text" value="${end!}" />
					</div>
				</div>
				<!--<div class="form-group">
					<label class="control-label">分组字段</label>
					<div>
						<select id="fieldId" name="fieldId" class="form-control chzn-select"  data-placeholder="请选择分组字段" 
						data-parsley-group="groupTemp" >
							<option value="">请选择</option>
							<option value="day">按日</option>
							<option value="month">按月</option>
							<option value="year">按年</option>
						</select>
					</div>
				</div>-->
				<button type="button" onclick="searchSubmit();" class="btn btn-sm btn-success"><i class="fa fa-search" style="font-size:16px;"></i></button>
			</form>
		</div>
		<div class="panel-body">
			<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto">
			</div>
			<div id="container1" style="min-width: 310px; height: 400px; margin: 0 auto">
			</div>
		</div>
	</div><!-- /panel -->
	<script src="${basePath}/resources/js/highcharts/highcharts.js"></script>
	<script type="text/javascript">
	function searchSubmit(){
		if($('#searchForm').parsley().validate()){
			$("#searchForm").submit();
		}
	}
	$("#month").change(function(){
		if($("#month").val()==""){
			$("#year").attr("data-parsley-required","false");
		}else{
			$("#year").attr("data-parsley-required","true");
		}
	});
	$("#beginTime").change(function(){
		$("#endTime").datepicker( 'destroy' ) ;
		$("#endTime").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,
			minDate:$("#beginTime").val(),
			maxDate:new Date()
		});
	});
	$("#endTime").change(function(){
		$("#beginTime").datepicker( 'destroy' ) ;
		$("#beginTime").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,
			maxDate:$("#endTime").val()
		});
	});
	$(document).ready(function(){
		$("#beginTime").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,
			maxDate:new Date()
		});
		$("#endTime").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,
			maxDate:new Date()
		});
		$('#container').highcharts({
			chart: {
				type: 'spline'
			},
			title: {
				text: '顾问跟进客户数'
			},
			xAxis: {
				categories: [${xaxisData}]
			},
			yAxis: {
				min: 0, 
				allowDecimals:false,
				title: {
					text: '跟进客户'
				},
				labels: {
					formatter: function () {
						return this.value + '(人)';
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
			 		<#assign index=0>
					<#list advisorCustomer?keys as userName>
						{
						name: '${userName}',
						data: [${advisorCustomer[userName]}]
						}
						<#if index lt advisorCustomer?keys?size-1>
						,
						</#if>
						<#assign index=index+1>
					</#list>
			],
			lang:{
				noData: "没有数据"
			}
		});
		$('#container1').highcharts({
			chart: {
				plotBackgroundColor: null,
				plotBorderWidth: null,
				plotShadow: false
			},
			title: {
				text: '顾问跟进客户客户总数'
			},
			tooltip: {
				pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
			},
			plotOptions: {
				pie: {
					allowPointSelect: true,
					cursor: 'pointer',
					dataLabels: {
						enabled: true,
						color: '#000000',
						connectorColor: '#000000',
						format: '<b>{point.name}</b>: {point.percentage:.1f} %'
					}
				}
			},
			series: [{
				type: 'pie',
				name: '',
				data: [
					<#assign index=0>
					<#list advisorCustomerCount?keys as advisorName>
						['${advisorName}',${advisorCustomerCount[advisorName]}]
						<#if index lt advisorCustomerCount?keys?size-1>
						,
						</#if>
					</#list>
				]
			}]
		});
	});
	</script>
</@master.masterFrame>