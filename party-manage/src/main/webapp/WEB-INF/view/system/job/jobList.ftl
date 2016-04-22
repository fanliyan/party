<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["系统管理","Job管理","Job列表"]>
	<div class="panel-body">
		<a class="btn btn-xs btn-info" href="${basePath}/job/add"><i class="fa fa-plus fa-lg"></i> 新增Job</a>
	</div>
	<div class="panel panel-default table-responsive">
		<div class="panel-heading">
			所有Job
			<span class="label label-info pull-right">目前共有 ${modelList?size} 个Job</span>
		</div>
		<table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
			<thead>
				<tr>
					<th>Job名称</th>
					<th>描述</th>
					<th>运行时间表达式</th>
					<th>状态</th>
					<th>同步/异步</th>
					<th>最后运行时间</th>
					<th>最后运行状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<#list modelList as model>
				<tr>
					<td>${model.jobName}</td>			
					<td>${model.jobDesc}</td>	
					<td>${model.cronExpression}</td>	
					<td>${(model.status==0)?string('<span class="label label-success">正常</span>','<span class="label label-warning">已禁用</span>')}</td>	
					<td>${model.isSync?string("同步","异步")}</td>
					<td><#if model.lastRunTime??>${model.lastRunTime?string('yyyy-MM-dd HH:mm:ss')}</#if></td>	
					<td><#if model.lastRunStatus??>${model.lastRunStatus?string('<span class="label label-success">成功</span>','<span class="label label-danger">失败</span>')}</#if></td>			
					<td>
						<a class="btn btn-xs btn-success" href="${basePath}/job/edit?jobScheduleId=${model.jobScheduleId}"><i class="fa fa-wrench fa-lg"></i> 编辑</a>
						<a class="btn btn-xs btn-danger" href="javascript:void(0);" onclick="$.delJobSchedule('${model.jobScheduleId}');"><i class="fa fa-trash-o fa-lg"></i> 删除</a>
						
						<a class="btn btn-xs btn-success" href="#" onclick="$.action('pause','${model.jobScheduleId}');"><i class="fa fa-times fa-lg"></i> 暂停</a>
						<a class="btn btn-xs btn-success" href="#" onclick="$.action('resume','${model.jobScheduleId}');"><i class="fa fa-random fa-lg"></i> 恢复</a>
						<a class="btn btn-xs btn-success" href="#" onclick="$.action('run','${model.jobScheduleId}');"><i class="fa fa-bolt fa-lg"></i> 立即执行一次</a>
					</td>
				</tr>
				</#list>
			</tbody>
		</table>
	</div><!-- /panel -->
	<script language="javascript">
	$.action = function(action,jobScheduleId){
		$.ajax({
		        cache: true,
		        type: "POST",
		        url:"${basePath}/job/"+action,
		        data:"jobScheduleId=" + jobScheduleId,// 你的formid
		        async: false,
		        error: function(request) {
		            alertify.alert("错误：服务器异常！");
		        },
		        success: function(data) {
		        	if(data.success){   
		            	alertify.success("操作成功"); 	      
		            }   
			        else{   
		            	alertify.error("错误:" + data.message);
			        }  
			    } 
	        });
	};
	
	
	$.delJobSchedule = function(jobScheduleId){
			alertify.confirm("注意，Job一经删除，无法恢复！是否继续？", function (e) {
				if (e) {
					$.ajax({
				        cache: true,
				        type: "POST",
				        url:"${basePath}/job/del",
				        data:"jobScheduleId=" + jobScheduleId,// 你的formid
				        async: false,
				        error: function(request) {
				            alertify.alert("错误：服务器异常！");
				        },
				        success: function(data) {
				        	if(data.success){   
				            	location.href="${basePath}/job/list"; 	 
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