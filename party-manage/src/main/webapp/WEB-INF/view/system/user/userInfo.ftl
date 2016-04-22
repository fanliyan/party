<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["客户","用户管理","用户详情"]>
<div class="padding-md col-md-6 col-md-offset-3">
	<div class="row">
		<div class="panel panel-default">
			<div class="panel-heading">基本资料</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="col-md-4 control-label text-right">姓名</label>
							<div class="col-md-8 ">
								<p class="form-control-static">${user.name!}</p>
							</div><!-- /.col -->
						</div><!-- /form-group -->
					</div><!-- /.col -->
					<div class="col-md-4">
						<div class="form-group">
							<label class="col-md-4 control-label text-right">性别</label>
							<div class="col-md-8">
								<p class="form-control-static"><#if user.gender??><#if user.gender=="M">男<#else>女</#if></#if></p>
							</div><!-- /.col -->
						</div><!-- /form-group -->
					</div><!-- /.col -->
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">生日</label>
                            <div class="col-md-8">
                                <p class="form-control-static">${user.birthday!}</p>
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div><!-- /.col -->
				</div>
				
				<#--<div class="row">-->

					<#--<div class="col-md-12">-->
						<#--<div class="form-group">-->
							<#--<label class="col-md-4 control-label text-right">生日</label>-->
							<#--<div class="col-md-8">-->
								<#--<p class="form-control-static">${user.birthday!}</p>-->
							<#--</div><!-- /.col &ndash;&gt;-->
						<#--</div><!-- /form-group &ndash;&gt;-->
					<#--</div><!-- /.col &ndash;&gt;-->
				<#--</div>-->
				<#--<div class="row">-->
					<#--<div class="col-md-6">-->
						<#--<div class="form-group">-->
							<#--<label class="col-md-4 control-label text-right">手机</label>-->
							<#--<div class="col-md-8">-->
								<#--<p class="form-control-static">${user.phone!}</p>-->
							<#--</div><!-- /.col &ndash;&gt;-->
						<#--</div><!-- /form-group &ndash;&gt;-->
					<#--</div><!-- /.col &ndash;&gt;-->
					<#--<div class="col-md-6">-->
						<#--<div class="form-group">-->
							<#--<label class="col-md-4 control-label text-right">邮箱</label>-->
							<#--<div class="col-md-8">-->
								<#--<p class="form-control-static">${user.email!}</p>-->
							<#--</div><!-- /.col &ndash;&gt;-->
						<#--</div><!-- /form-group &ndash;&gt;-->
					<#--</div><!-- /.col &ndash;&gt;-->
				<#--</div>-->
				
				<div class="row">
					<div class="col-md-6">
						<div class="form-group">
							<label class="col-md-4 control-label text-right">注册日期</label>
							<div class="col-md-8">
								<p class="form-control-static">${user.createTime?string('yyyy-MM-dd')}</p>
							</div><!-- /.col -->
						</div><!-- /form-group -->
					</div><!-- /.col -->
					<div class="col-md-6">
						<div class="form-group">
							<label class="col-md-4 control-label text-right">最后登录日期</label>
							<div class="col-md-8">
								<p class="form-control-static"><#if user.lastLoginTime??>${user.lastLoginTime?string('yyyy-MM-dd HH:mm:ss')}</#if></p>
							</div><!-- /.col -->
						</div><!-- /form-group -->
					</div><!-- /.col -->
				</div>
				<div class="row">
					<#--<div class="col-md-6">-->
						<#--<div class="form-group">-->
							<#--<label class="col-md-4 control-label text-right">用户级别</label>-->
							<#--<div class="col-md-8">-->
								<#--<p class="form-control-static"><#if user.level==30>内部用户<#elseif user.level==10>有角色用户<#else>网站用户</#if></p>-->
							<#--</div><!-- /.col &ndash;&gt;-->
						<#--</div><!-- /form-group &ndash;&gt;-->
					<#--</div><!-- /.col &ndash;&gt;-->
					<#--<div class="col-md-12">-->
						<#--<div class="form-group">-->
							<#--<label class="col-md-4 control-label text-right">角色</label>-->
							<#--<div class="col-md-8">-->
								<#--<p class="form-control-static"></p>-->
							<#--</div><!-- /.col &ndash;&gt;-->
						<#--</div><!-- /form-group &ndash;&gt;-->
					<#--</div><!-- /.col &ndash;&gt;-->
				</div>
			</div>
			<div class="panel-footer text-center">
				<button type="button" class="btn btn-default" onclick="javascript:history.go(-1);">返回</button>
			</div>
		</div><!-- /panel -->
	</div>
</div>
</@master.masterFrame>