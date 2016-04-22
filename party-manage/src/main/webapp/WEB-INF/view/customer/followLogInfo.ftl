<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["客户","客户管理","跟进详情"]>
<div class="padding-md">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-body">
				<form id="adForm" class="form-horizontal form-border">
					<div class="form-group">
						<label class="col-md-3 control-label">客户姓名</label>
						<div class="col-md-8">
							<p class="form-control-static">${(followLog.customer.name)!}</p>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-md-3 control-label">跟进类型</label>
						<div class="col-md-8">
							<p class="form-control-static">${(followLog.followTypeModel.followTypeName)!}</p>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-md-3 control-label">跟进时间</label>
						<div class="col-md-8">
							<div class="input-group">
								<p class="form-control-static"><#if followLog.followTime??>${followLog.followTime?string('yyyy-MM-dd HH:mm')}</#if></p>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-md-3 control-label">跟进内容</label>
						<div class="col-md-8">
							<p class="form-control-static">${(followLog.followDesc)!}</p>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-md-3 control-label">后续跟进类型</label>
						<div class="col-md-8">
							<p class="form-control-static">${(followLog.nextFollowTypeModel.followTypeName)!}</p>
						</div><!-- /.col -->
					</div><!-- /form-group -->
					
					<div class="form-group">
						<label class="col-md-3 control-label">后续跟进时间</label>
						<div class="col-md-8">
							<p class="form-control-static"><#if followLog.nextFollowTime??>${followLog.nextFollowTime?string('yyyy-MM-dd HH:mm')}</#if></p>
						</div>
					</div>
					<#if followLog.imageList??>
					<div class="form-group">
						<div class="col-md-12 text-center">
							<#list followLog.imageList as url>
								<img style='width:100px;height:100px;' src='${url}' class='img-thumbnail'>
							</#list>
						</div>
					</div>
					</#if>
					<div class="form-group text-center">
						<a href="javascript:history.go(-1);" class="btn btn-success">返回</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</@master.masterFrame>