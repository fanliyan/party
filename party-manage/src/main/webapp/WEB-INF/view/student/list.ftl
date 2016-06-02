<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />
<#import "/control/common/areaSelect.ftl" as areaSelect />
<#import "/control/common/nationSelect.ftl" as nationSelect />
<#import "/control/common/branchSelect.ftl" as branchSelect />
<#import "/control/common/departmentSelect.ftl" as departmentSelect />

<#include "/function.ftl">
<@master.masterFrame pageTitle=["系统管理","学生管理","学生列表"]>
	<div class="panel panel-default table-responsive">
		<#--<div class="panel-body">-->
			<#--<a href="${basePath}/users/add" class="btn btn-info btn-xs" ><i class="fa fa-plus fa-lg"></i> 新增</a>-->
		<#--</div>-->
		<div class="panel-heading">条件搜索</div>
		<div class="panel-body">
			<form id="searchForm" class="form-inline no-margin" action="${basePath}/student/list" method="post">
                <div class="col-md-8">
                    <div class="form-group col-md-3" style="margin-right:10px;">
                        <label class="control-label">姓名</label>
                        <div>
                            <input name="userName" type="text" class="form-control input-sm" value="${(student.name)!}"/>
                        </div>
                    </div><!-- /form-group -->
                    <#--<div class="form-group" style="margin-right:10px;">-->
                        <#--<label class="control-label">ID</label>-->
                        <#--<div>-->
                            <#--<input name="accountId" type="text" class="form-control input-sm" value="${(user.id)!}"/>-->
                        <#--</div>-->
                    <#--</div><!-- /form-group &ndash;&gt;-->
                    <div class="form-group col-md-3" style="margin-right:10px;">
                        <label class="control-label">学号</label>
                        <div>
                            <input name="accountId" type="text" class="form-control input-sm" value="${(student.studentCode)!}"/>
                        </div>
                    </div><!-- /form-group -->
                    <div class="form-group col-md-3" style="margin-right:10px;">
                        <label class="control-label">电话</label>
                        <div>
                            <input name="phone" type="text" class="form-control input-sm" value="${(student.phone)!}"/>
                        </div>
                    </div><!-- /form-group -->
                    <div class="form-group col-md-3" style="margin-right:10px;">
                        <label class="control-label">类型</label>
                        <div>
                            <select class="form-control" name="type">
                                <option value="">请选择</option>
                                <option value="0" <#if student??&&student.type??&&(student.type)==0>selected</#if>>学生</option>
                                <option value="1" <#if student??&&student.type??&&(student.type)==1>selected</#if>>老师</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-3" style="margin-right:10px;">
                        <label class="control-label">状态</label>
                        <div>
                            <select class="form-control" name="status">
                                <option value="">请选择</option>
                                <option value="0" <#if student??&&student.status??&&(student.status)==0>selected</#if>>正常</option>
                                <option value="-1" <#if student??&&student.status??&&(student.status)==-1>selected</#if>>已锁定</option>
                                <option value="-3" <#if student??&&student.status??&&(student.status)==-3>selected</#if>>待审核</option>

                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-3" style="margin-right:10px;">
                        <@nationSelect.nationSelect nationList=nationlist  nationControlName="nationId"
                        nationControlName="nationId" selectedNationId=(student.nationId)!0></@nationSelect.nationSelect>

                    </div><!-- /form-group -->
                </div>
                <div class="col-md-6">
                    <@areaSelect.areaSelect provinceList=provincelist  provinceControlName="provinceCode" cityControlName="cityCode"
                    areaControlName="areaCode"
                    selectedProvinceId=(request.provinceCode)!""  selectedCityId=(request.cityCode)!"" selectedAreaId=(student.areaCode)!""></@areaSelect.areaSelect>
                </div>
                <div class="col-md-6">
                    <@departmentSelect.departmentSelect departmentList=departmentlist departmentControlName="departmentId" xiControlName="xiId" classControlName="classId"
                    selectedDepartmentId=0  selectedXiId=0 selectedClassId=0 ></@departmentSelect.departmentSelect>
                </div>

                <div class="col-md-12">
                    <button id="searchTbale" type="button" class="btn btn-sm btn-success"><i class="fa fa-search" style="font-size:16px;"></i></button>

                    <button id="printTable" type="button" class="btn btn-sm btn-warning"><i class="fa fa-print" style="font-size:16px;"></i>导出</button>
                </div>
			</form>
		</div>
		<table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
			<thead>
				<tr>
					<th>姓名</th>
                    <th>电话</th>
                    <th>登录名</th>
					<th>学号</th>
					<th>性别</th>
					<th>生日</th>
                    <th>院系</th>
					<th>级别</th>
                    <th>类型</th>
					<th>状态</th>
                    <th>最后登录时间</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
				<#if listResponse.studentModelList ??>
					<#list listResponse.studentModelList as user>
						<tr>
							<td>${user.name!}</td>
                            <td>${user.phone!}</td>
							<td>${user.account!}</td>
                            <td>${user.studentCode!}</td>
							<#--<td><#if user.accountGroup??><#if user.accountGroup=="Tencent">腾讯<#elseif  user.accountGroup=="Sina">新浪</#if></#if></td>-->
							<#--<td>${user.email!}</td>-->
							<td><#if user.gender?? && user.gender>女<#else>男</#if></td>
							<td><#if user.birthday??>${user.birthday?string('yyyy-MM-dd')}</#if></td>
							<td>${(user.branchModel.name)!}-${(user.departmentModel.name)!}</td>
                            <td>${(user.sRoleModel.name)!}</td>
                            <td><#if user.type==1>老师<#else>学生</#if></td>
                            <td>
								<#if user.status==0>
									<span class="label label-success">正常</span>
								<#elseif user.status==-3>
                                    <span class="label label-warning">待审核</span>
                                <#else>
									<span class="label label-danger">已锁定</span>
								</#if>
							</td>
                            <td><#if user.lastLoginTime??>${user.lastLoginTime?string('yyyy-MM-dd HH:mm')}</#if></td>
                            <td>
								<a class="btn btn-xs btn-warning" href="${basePath}/student/info?userId=${user.id}"><i class="fa fa-info-circle fa-lg"></i> 查看</a>
                                <a class="btn btn-xs btn-info" href="${basePath}/student/edit?userId=${user.id}"><i class="fa fa-info-edit fa-lg"></i> 编辑</a>
								<#if user.status==-3>
                                    <a class="btn btn-xs btn-default" href="javascript:void(0);" onclick="$.editLock(${user.id},0);"><i class="fa fa-check fa-lg"></i> 通过</a>
                                    <a class="btn btn-xs btn-danger" href="javascript:void(0);" onclick="$.del(${user.id});"><i class="fa fa-times-circle-o fa-lg"></i> 删除</a>
                                <#elseif  user.status==0>
                                    <a class="btn btn-xs btn-danger" href="javascript:void(0);" onclick="$.editLock(${user.id},-1);"><i class="fa fa-lock fa-lg"></i> 锁定</a>
                                    <a class="btn btn-xs btn-success" href="${basePath}/student/grantRole?userId=${user.id}"><i class="fa fa-wrench fa-lg"></i> 分配角色</a>
                                <#else>
                                    <a class="btn btn-xs btn-success" href="javascript:void(0);" onclick="$.editLock(${user.id},0);"><i class="fa fa-unlock fa-lg"></i> 解锁</a>
                                    <a class="btn btn-xs btn-success" href="${basePath}/student/grantRole?userId=${user.id}"><i class="fa fa-wrench fa-lg"></i> 分配角色</a>
                                </#if>
							</td>
						</tr>
					</#list>
                <#else>
                <tr><td colspan="7">暂无数据</td></tr>
				</#if>
			</tbody>
		</table>
		<@splitPage1.splitPage pageCount=listResponse.splitPageResponse.pageCount pageNo=listResponse.splitPageResponse.pageNo formId="searchForm" recordCount=listResponse.splitPageResponse.recordCount />
	</div><!-- /panel -->
	<script language="javascript">
        $(function(){
            $("#printTable").on("click",function(){
                $("#searchForm").attr("action","${basePath}/student/list?isDownload=true");
                $("#searchForm").submit();
            });
            $("#searchTbale").on("click",function(){
                $("#searchForm").attr("action","${basePath}/student/list");
                $("#searchForm").submit();
            });
        });
	$.editLock = function(userId,status){
		$.ajax({
			cache: true,
			type: "POST",
			url:"${basePath}/student/editLock",
			data:"id=" + userId+"&status="+status,// 你的formid
			async: false,
			error: function(request) {
				alertify.alert("错误：服务器异常！");
			},
			success: function(data) {
				if(data.success){
					location.reload();
				}
				else{
					alertify.alert("错误:" + data.message);
				}
			}
		});
	};
        $.del = function(userId){
            $.ajax({
                cache: true,
                type: "POST",
                url:"${basePath}/student/del",
                data:"id=" + userId,// 你的formid
                async: false,
                error: function(request) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function(data) {
                    if(data.success){
                        location.reload();
                    }
                    else{
                        alertify.alert("错误:" + data.message);
                    }
                }
            });
        };
</script>
</@master.masterFrame>