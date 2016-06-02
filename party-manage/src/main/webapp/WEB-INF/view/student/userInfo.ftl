<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["学生管理","学生管理","学生详情"]>

<#assign isTeacher=user.type==1>
<div class="padding-md col-md-9 col-sm-9 col-md-offset-1">
	<div class="row">
		<div class="panel panel-default">
			<div class="panel-heading">基本资料 [<#if isTeacher>老师<#else>学生</#if>]</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-md-4 col-sm-4">
						<div class="form-group">
							<label class="col-md-4 control-label text-right">姓名</label>
							<div class="col-md-8 ">
								<p class="form-control-static">${user.name!}</p>
							</div><!-- /.col -->
						</div><!-- /form-group -->
					</div><!-- /.col -->
					<div class="col-md-4 col-sm-4">
						<div class="form-group">
							<label class="col-md-4 control-label text-right">性别</label>
							<div class="col-md-8">
								<p class="form-control-static"><#if user.gender??><#if user.gender>女<#else>男</#if></#if></p>
							</div><!-- /.col -->
						</div><!-- /form-group -->
					</div><!-- /.col -->

                    <#if !isTeacher>
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">出生日期</label>
                            <div class="col-md-8">
                                <p class="form-control-static">${(user.birthday?string('yyyy-MM-dd'))!}</p>
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div><!-- /.col -->
				</div>
                <div class="row">
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">身份证</label>
                            <div class="col-md-8 ">
                                <p class="form-control-static">${user.idCard!}</p>
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div><!-- /.col -->
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">民族</label>
                            <div class="col-md-8 ">
                                <p class="form-control-static">${(user.nationModel.nation)!}</p>
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div><!-- /.col -->
                    </#if>
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">电话</label>
                            <div class="col-md-8">
                                <p class="form-control-static">${(user.phone)!}</p>
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div><!-- /.col -->
                </div>
                <#if !isTeacher>
                <div class="row">
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">省份</label>
                            <div class="col-md-8 ">
                                <p class="form-control-static">${(user.provinceModel.name)!}</p>
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div><!-- /.col -->
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">城市</label>
                            <div class="col-md-8">
                                <p class="form-control-static">${(user.cityModel.name)!}</p>
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div><!-- /.col -->
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">地区</label>
                            <div class="col-md-8">
                                <p class="form-control-static">${(user.areaModel.name)!}</p>
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div><!-- /.col -->
                </div>
                <div class="row">
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">学号</label>
                            <div class="col-md-8">
                                <p class="form-control-static">${(user.studentCode)!}</p>
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div><!-- /.col -->
                </div>
                <div class="row">
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">学院</label>
                            <div class="col-md-8 ">
                                <p class="form-control-static">${(user.departmentModel.name)!}</p>
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div><!-- /.col -->
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">系</label>
                            <div class="col-md-8 ">
                                <p class="form-control-static">${(user.xiModel.name)!}</p>
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div><!-- /.col -->
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">班</label>
                            <div class="col-md-8 ">
                                <p class="form-control-static">${(user.classModel.name)!}</p>
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div><!-- /.col -->
                </div>
                </#if>
                <hr>
                    <div class="row">
                        <div class="col-md-6 col-sm-6">
                            <div class="form-group">
                                <label class="col-md-4 control-label text-right">学院</label>
                                <div class="col-md-8 ">
                                    <p class="form-control-static">${(user.departmentModel.name)!}</p>
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                        </div><!-- /.col -->
                        <div class="col-md-6 col-sm-6">
                            <div class="form-group">
                                <label class="col-md-4 control-label text-right">支部/支委</label>
                                <div class="col-md-8 ">
                                    <p class="form-control-static">${(user.branchModel.name)!}</p>
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                        </div><!-- /.col -->
                    </div>
                <hr>
                <div class="row">
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">重点积极分子时间</label>
                            <div class="col-md-8 ">
                                <p class="form-control-static">${(user.keyActiveMemberTime?string('yyyy-MM-dd'))!}</p>
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div><!-- /.col -->
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">预备党员时间</label>
                            <div class="col-md-8">
                                <p class="form-control-static">${(user.probationaryMemberTime?string('yyyy-MM-dd'))!}</p>
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div><!-- /.col -->
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">正式党员时间</label>
                            <div class="col-md-8">
                                <p class="form-control-static">${(user.cardCarryingMemberTime?string('yyyy-MM-dd'))!}</p>
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div><!-- /.col -->
                </div>
                <div class="row">
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">推荐人</label>
                            <div class="col-md-8">
                                <p class="form-control-static">${(user.introducer)!}</p>
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div><!-- /.col -->
                </div>
				
				<hr>
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