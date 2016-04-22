<#import "/master/master-frame.ftl" as master />
<#assign title=["系统管理","邮件组管理","邮件组列表"]>
<@master.masterFrame pageTitle=title>
<div class="panel panel-default">
	<div class="panel-body">
		<table class="table table-condensed" id="dataTable">
			<tbody>
				<#if groupList??>
				<#list groupList as group>
					<tr class="warning">
						<td>${group.groupName}</td>
						<td>
							<a href="#formModal" class="btn btn-info btn-xs" data-toggle="modal" onclick="openDialog(${group.groupId},'${group.groupName}')"><i class="fa fa-plus fa-lg"></i> 添加用户</a>
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>	
					<#if group.groupUserList??> 
						<#list group.groupUserList as groupUser>
							<tr>
								<td></td>
								<td>${(groupUser.user.userName)!}</td>
								<td>${(groupUser.userBindAccount.accountId)!}</td>
								<td><a href="javascript:del(${group.groupId},${(groupUser.userid)!})" class="btn btn-info btn-xs"><i class="fa fa-plus fa-lg"></i> 删除</a></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</#list>
					</#if>
				</#list>
				</#if>
			</tbody>
		</table>
		<div class="panel-footer text-center">
			<button type="button" class="btn btn-default" onclick="javascript:history.go(-1);">返回</button>
		</div>
	</div>
</div>
<div class="modal fade" id="formModal" aria-hidden="true" style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4><span id="groupName"></span>添加用户</h4>
			</div>
			<div class="modal-body">
				<form id="searchForm" class="form-horizontal" method="post">
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label">用户姓名</label>
								<div>
									<input id="userName" name="userName" type="text" class="form-control input-sm" value=""/>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label">用户邮箱</label>
								<div>
									<input id="email" name="email" type="text" class="form-control input-sm" value=""/>
								</div>
							</div>
						</div>
						<div class="col-md-1">
							<label class="control-label"></label>
							<div>
								<button type="button" class="btn btn-sm btn-success" onclick="search();"><i class="fa fa-search" style="font-size:16px;"></i></button>
							</div>
						</div>
					</div>
				</form>
				<form id="userForm" class="form-horizontal" method="post">
					<input type="hidden" id="groupId" name="groupId" value=""/>
					<table id="userTable" class="table">
						
					</table>
				</form>
			</div>
		</div>
	</div>
</div>
<script language="javascript">
	function openDialog(id,name){
		$("#groupId").val(id);
		$("#groupName").text(name);
	}
	function search(){
		if($("#userName").val()=='' && $("#email").val()==''){
			return ;
		}else{
			$.ajax({
				cache: false,
				type: "POST",
				url:"${basePath}/users/emailGroup",
				data:$('#searchForm').serialize(),
				async: false,
				error: function(request) {
					alertify.alert("错误：服务器异常！");
				},
				success: function(data) {
					if(data.success){
						var users=data.users;
						if(users!=null){
							$("#userTable").html("");
							$.each(users,function(){
								if(this.userBindAccount==null){
									$("#userTable").append("<tr><td>"+this.userName+"</td><td>邮箱未绑定</td></tr>");
								}else{
									$("#userTable").append("<tr><td>"+this.userName+"</td><td>"+this.userBindAccount.accountId+"</td><td><a href=\"javascript:add("+this.userid+");\" class='btn btn-info btn-xs'><i class='fa fa-plus fa-lg'></i> 添加</a></td></tr>");
								}
							});
						}
					}else{
						alertify.alert("错误:" + data.message);
					}
				}
			});
		}
	}
	function add(userid){
		$.ajax({
			cache: false,
			type: "POST",
			url:"${basePath}/emailGroup/addUser",
			data:"groupId="+$("#groupId").val()+"&userid="+userid,
			async: false,
			error: function(request) {
				alertify.alert("错误：服务器异常！");
			},
			success: function(data) {
				if(data.success){
					alertify.alert("操作成功");
				}else{
					alertify.alert("错误:" + data.message);
				}
			}
		});
	}
	function del(groupId,userid){
		$.ajax({
			cache: false,
			type: "POST",
			url:"${basePath}/emailGroup/delUser",
			data:"groupId="+groupId+"&userid="+userid,
			async: false,
			error: function(request) {
				alertify.alert("错误：服务器异常！");
			},
			success: function(data) {
				if(data.success){
					alertify.alert("操作成功",function(e){location.href="${basePath}/emailGroup/list";});
				}else{
					alertify.alert("错误:" + data.message);
				}
			}
		});
	}
	$('#formModal').on('hide.bs.modal', function () {
		location.href="${basePath}/emailGroup/list";
	});
</script>
</@master.masterFrame>