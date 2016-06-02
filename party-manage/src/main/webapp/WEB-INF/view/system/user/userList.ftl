<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />
<#import "/control/common/branchSelect.ftl" as branchSelect />

<#include "/function.ftl"> 
<@master.masterFrame pageTitle=["系统管理","用户管理","用户列表"]>
	<div class="panel panel-default table-responsive">
		<div class="panel-body">
			<a href="${basePath}/users/add" class="btn btn-info btn-xs" ><i class="fa fa-plus fa-lg"></i> 新增用户</a>
		</div>
		<div class="panel-heading">条件搜索</div>
		<div class="panel-body">
			<form id="searchForm" class="form-inline no-margin" action="${basePath}/users/list" method="post">
                <div class="col-md-6">
                    <div class="col-md-4">
                        <div class="form-group" style="margin-right:10px;">
                            <label class="control-label">姓名</label>
                            <div>
                            <input name="userName" type="text" class="form-control input-sm" value="${(user.name)!}"/>
                            </div>
                        </div><!-- /form-group -->
                    </div>
                    <div class="col-md-4">
                        <div class="form-group" style="margin-right:10px;">
                            <label class="control-label">登录名</label>
                            <div>
                            <input name="accountId" type="text" class="form-control input-sm" value="${(user.account)!}"/>
                            </div>
                        </div><!-- /form-group -->
                    </div>
                    <div class="col-md-4">
                        <label class="control-label">教师级别</label>
                        <select class="form-control" name="departmentType">
                            <option value="">请选择</option>
                            <option value="0">系</option>
                            <option value="1">院</option>
                            <option value="2">校</option>
                            <option value="3">机关</option>
                        </select>
                    </div>
                </div>

                <div class="col-md-6">
                    <@branchSelect.branchSelect departmentList=departmentlist  departmentControlName="departmentId" branchControlName="branchId"
                    selectedDepartmentId=(user.departmentId)!0  selectedBranchId=(user.branchId)!0 ></@branchSelect.branchSelect>
                </div>

				<#--<div class="form-group" style="margin-right:10px;">-->
					<#--<label class="control-label">手机号码</label>-->
					<#--<div>-->
					<#--<input name="phone" type="text" class="form-control input-sm" value="<#if user ??>${user.phone! }</#if>"/>-->
					<#--</div>-->
				<#--</div><!-- /form-group &ndash;&gt;-->
				<#--<div class="form-group" style="margin-right:10px;">-->
					<#--<label class="control-label">邮箱</label>-->
					<#--<div>-->
					<#--<input name="email" type="text" class="form-control input-sm" value="<#if user ??>${user.email! }</#if>"/>-->
					<#--</div>-->
				<#--</div><!-- /form-group &ndash;&gt;-->
                <div class="col-md-12">
                    <button type="submit" class="btn btn-sm btn-success"><i class="fa fa-search" style="font-size:16px;"></i></button>
                </div>
			</form>
		</div>
		<table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
			<thead>
				<tr>
					<th>名称</th>
					<th>登录名</th>
					<#--<th>第三方登录</th>-->
					<#--<th>手机</th>-->
					<#--<th>邮箱</th>-->
					<th>性别</th>
					<#--<th>出生年月</th>-->

                    <th>院系</th>
					<th>类型</th>
                    <th>最后登录时间</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<#if listResponse.userModelList ??>
					<#list listResponse.userModelList as user>
						<tr>
							<td>${user.name!}</td>
							<td>${user.account!}</td>
							<#--<td><#if user.accountGroup??><#if user.accountGroup=="Tencent">腾讯<#elseif  user.accountGroup=="Sina">新浪</#if></#if></td>-->
							<#--<td>${user.phone!}</td>-->
							<#--<td>${user.email!}</td>-->
							<td><#if user.gender?? && user.gender=="M">男<#else>女</#if></td>
							<#--<td><#if user.birthday??>${user.birthday!}</#if></td>-->
                            <td>
                                <#if user.departmentType==0>
                                     ${(user.branchModel.name)!}-${(user.departmentModel.name)!""}
                                <#elseif user.departmentType==1>
                                    ${(user.deparmentModel.name)!}
                                <#elseif user.departmentType==2>
                                    校
                                <#else>
                                    机关
                                </#if>
                            </td>
                            <td>
                                <#if user.departmentType==0>系<#elseif user.departmentType==1>院<#elseif user.departmentType==2>校<#else>机关</#if>
                            </td>
                            <td><#if user.lastLoginTime??>${user.lastLoginTime?string('yyyy-MM-dd HH:mm')}</#if></td>
                            <td>
								<#if user.status==0>
									<span class="label label-success">正常</span>
								<#else>
									<span class="label label-danger">已锁定</span>
								</#if>
							</td>
							<td>
								<a class="btn btn-xs btn-warning" href="${basePath}/users/info?userId=${user.userId}"><i class="fa fa-info-circle fa-lg"></i> 查看</a>
								<#if isGrant?? && isGrant>
								<a class="btn btn-xs btn-success" href="${basePath}/users/grantRole?userId=${user.userId}"><i class="fa fa-wrench fa-lg"></i> 分配角色</a>
								</#if>
								<#if user.status==0>
									<a class="btn btn-xs btn-danger" href="javascript:void(0);" onclick="$.editLock(${user.userId},-1);"><i class="fa fa-lock fa-lg"></i> 锁定</a>
								<#else>
									<a class="btn btn-xs btn-success" href="javascript:void(0);" onclick="$.editLock(${user.userId},0);"><i class="fa fa-unlock fa-lg"></i> 解锁</a>
								</#if>
							</td>
						</tr>
					</#list>
				</#if>
			</tbody>
		</table>
		<@splitPage1.splitPage pageCount=listResponse.splitPageResponse.pageCount pageNo=listResponse.splitPageResponse.pageNo formId="searchForm" recordCount=listResponse.splitPageResponse.recordCount />
	</div><!-- /panel -->
	<script language="javascript">
	$.editLock = function(userId,status){
		$.ajax({
			cache: true,
			type: "POST",
			url:"${basePath}/users/editLock",
			data:"userId=" + userId+"&status="+status,// 你的formid
			async: false,
			error: function(request) {
				alertify.alert("错误：服务器异常！");
			},
			success: function(data) {
				if(data.success){
					var pageNo=$(".pagination li.active").text();
					$.GoPage(pageNo);
				}
				else{
					alertify.alert("错误:" + data.message);
				}
			}
		});
	};
</script>
</@master.masterFrame>