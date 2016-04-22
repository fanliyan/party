<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["客户","用户管理","用户详情"]>
<div class="padding-md col-md-6 col-md-offset-3">
	<div class="row">
		<div class="panel panel-default">
			<div class="panel-body">
				<form class="form-horizontal form-border">
					<div class="col-md-12">
						<div class="form-group">
							<label class="col-md-2 control-label">时间</label>
							<div class="col-md-10">
								<p class="form-control-static">${message.createTime?string('yyyy-MM-dd HH:mm')}</p>
							</div><!-- /.col -->
						</div><!-- /form-group -->
						
						<div class="form-group">
							<label class="col-md-2 control-label">内容</label>
							<div class="col-md-10">
								<p class="form-control-static">${message.content!}</p>
							</div><!-- /.col -->
						</div><!-- /form-group -->
					</div>
				</form>
			</div>
			<div class="panel-footer text-center">
				<button type="button" class="btn btn-default" onclick="javascript:history.go(-1);">返回</button>
			</div>
		</div><!-- /panel -->
	</div>
</div>
</@master.masterFrame>