<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["报表","报表详细"]>
	<div class="panel panel-default">
		<div class="panel-heading">按条件查看</div>
		<#if lectureModels?? && lectureModels?size gt 0>
		<div class="panel-body">
			<form id="searchForm" class="form-inline no-margin" action="${basePath}/lectureReport/report" method="post">
				<div class="form-group col-md-6">
					<label class="control-label col-md-2">按课程</label>
					<div class="col-md-10">
						<select id="fieldId" name="lectureId" class="form-control chzn-select"  data-placeholder="请选择课程" 
						data-parsley-group="groupTemp" >
							<option value="">请选择</option>
							<#list lectureModels as lectureModel >
								<#if lectureId?? && lectureId==lectureModel.lectureId>
									<option value="${lectureModel.lectureId}" selected>${lectureModel.title}</option>
								<#else>
									<option value="${lectureModel.lectureId}">${lectureModel.title}</option>
								</#if>
							</#list>
						</select>
					</div>
				</div>
				<button type="button" onclick="searchSubmit();" class="btn btn-sm btn-success"><i class="fa fa-search" style="font-size:16px;"></i></button>
			</form>
		</div>
		</#if>
		<div class="panel-body">
			<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto">
			</div>
		</div>
	</div><!-- /panel -->
	<div class="panel panel-default">
		<div class="panel-body">
			<div id="container1" style="min-width: 310px; height: 400px; margin: 0 auto">
			</div>
		</div>
	</div><!-- /panel -->
	<div class="panel panel-default">
		<div class="panel-body">
			<div id="container2" style="min-width: 310px; height: 400px; margin: 0 auto">
			</div>
		</div>
	</div><!-- /panel -->
	<div class="panel panel-default">
		<div class="panel-body">
			<div id="container3" style="min-width: 310px; height: 400px; margin: 0 auto">
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
	$(document).ready(function(){
		$('#container').highcharts({
			chart: {
				type: 'spline'
			},
			title: {
				text: '在线人数分时'
			},
			xAxis: {
				categories: [
					${onlineXData}
				]
			},
			yAxis: {
				min: 0, 
				allowDecimals:false,
				title: {
					text: '在线人数'
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
					enableMouseTracking: true
				}
			},
			 series: [
						{
						name: '同时在线人数',
						color: '#f00',
						data: [${onlineYData}]
						},
						{
						name: '进入人数总计',
						data: [${increaceYData}]
						}
			],
			lang:{
				noData: "没有数据"
			}
		});
		
		$('#container1').highcharts({
			chart: {
				type: 'column',
				margin: [ 50, 50, 100, 80]
			},
			title: {
				text: '收听时长概要分类'
			},
			xAxis: {
				categories: [
					${xData}
				]
			},
			yAxis: {
				min: 0,
				title: {
					text: '总人数(${total})'
				}
			},
			legend: {
				enabled: true
			},
			series: [{
				name: '人数',
				data: [${yData2}],
				dataLabels: {
					enabled: true,
					rotation: -90,
					color: '#FFFFFF',
					align: 'right',
					x: 4,
					y: 10,
					style: {
						fontSize: '13px',
						fontFamily: 'Verdana, sans-serif',
						textShadow: '0 0 3px black'
					}
				}
			},
			{
				name: '人数占比',
				data: [${yData}],
				dataLabels: {
					enabled: true,
					rotation: -90,
					color: '#CCCCCC',
					align: 'right',
					x: 4,
					y: 10,
				}
			}]
		});
		$('#container2').highcharts({
			chart: {
				type: 'column',
				margin: [ 50, 50, 100, 80]
			},
			title: {
				text: '按收听时长详细分类'
			},
			xAxis: {
				categories: [
					${timeXData}
				]
			},
			yAxis: {
				min: 0,
				title: {
					text: '总人数(${total})'
				}
			},
			legend: {
				enabled: true
			},
			series: [{
				name: '人数',
				data: [${timeYData}],
			}]
		});
		
		Highcharts.getOptions().colors = Highcharts.map(Highcharts.getOptions().colors, function(color) {
    return {
        radialGradient: { cx: 0.5, cy: 0.3, r: 0.7 },
        stops: [
            [0, color],
            [1, Highcharts.Color(color).brighten(-0.3).get('rgb')] // darken
        ]
    };
});
    $('#container3').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: '用户活跃图表'
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
            name: '占比',
            data: [
            ${oldUserData}
            ${highLightData}
            
               
            ]
        }]
    });
		
	});
	</script>
</@master.masterFrame>