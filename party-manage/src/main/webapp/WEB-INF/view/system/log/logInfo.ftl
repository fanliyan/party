<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["客户","用户管理","用户详情"]>
<div class="padding-md col-md-6 col-md-offset-3">
	<div class="row">
		<div class="panel panel-default">
			<div class="panel-body">
				<div class="row">
					<div class="col-md-6">
						<div class="form-group">
							<label class="col-md-4 control-label text-right">操作类型</label>
							<div class="col-md-8 ">
								<p class="form-control-static"><#if logModel.logType=="AuthorityManage">修改操作</#if></p>
							</div><!-- /.col -->
						</div><!-- /form-group -->
					</div><!-- /.col -->
					<div class="col-md-6">
						<div class="form-group">
							<label class="col-md-4 control-label text-right">操作用户</label>
							<div class="col-md-8">
								<p class="form-control-static">${logModel.createUserid!}</p>
							</div><!-- /.col -->
						</div><!-- /form-group -->
					</div><!-- /.col -->
				</div>
				
				<div class="row">
					<div class="col-md-6">
						<div class="form-group">
							<label class="col-md-4 control-label text-right">操作日期</label>
							<div class="col-md-8">
								<p class="form-control-static">${logModel.createTime?string('yyyy-MM-dd HH:mm')}</p>
							</div><!-- /.col -->
						</div><!-- /form-group -->
					</div><!-- /.col -->
				</div>
				<div class="row">
					<div class="col-md-6">
						<div class="form-group">
							<label class="col-md-4 control-label text-right">内容</label>
							<div class="col-md-8">
								<p class="form-control-static">${logModel.description!}</p>
							</div><!-- /.col -->
						</div><!-- /form-group -->
					</div><!-- /.col -->
				</div>
			</div>
			<div class="panel-footer text-center">
				<button type="button" class="btn btn-default" onclick="javascript:history.go(-1);">返回</button>
			</div>
		</div><!-- /panel -->
	</div>
</div>
</@master.masterFrame>