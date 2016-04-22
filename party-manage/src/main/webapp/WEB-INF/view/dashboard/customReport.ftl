<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["报表","报表详细"]>
<div class="panel panel-default">
        <div class="panel-body">按条件查看
            <form id="searchForm" class="form-inline no-margin" action="${basePath}/customReport/report" method="post">
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
                        <div class="form-group">
                            <label class="control-label">分组字段</label>
                            <div>
                                <select id="fieldId" name="fieldId" class="form-control chzn-select"  data-placeholder="请选择分组字段"
                                        data-parsley-group="groupTemp" >
                                    <option value="">请选择</option>
                                    <option value="1" <#if fieldId??&&fieldId==1>selected</#if>>按年</option>
                                    <option value="2" <#if fieldId??&&fieldId==2>selected</#if>>按月</option>
                                    <option value="3" <#if fieldId??&&fieldId==3>selected<#elseif fieldId??><#else >selected</#if>>按天</option>
                                </select>
                            </div>
                        </div>
                <input type="hidden" name="reportName" value="${reportName}">
                <input type="hidden" name="moduleId" value="${moduleId}"/>
                <button type="button" onclick="searchSubmit();" class="btn btn-sm btn-success"><i class="fa fa-search" style="font-size:16px;"></i></button>
            </form>
        </div>
    <div class="panel-body">
        <div id="container" style="min-width: 310px; height: 400px; margin: 0 auto">
            <#if response.sqlInfoList?size == 0>
                没有数据
            </#if>
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
        <#if response.sqlInfoList?size gt 0>
            $('#container').highcharts({
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
                                name: '${sqlInfo.exampleName!"默认名称"}',
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
    });
</script>
</@master.masterFrame>