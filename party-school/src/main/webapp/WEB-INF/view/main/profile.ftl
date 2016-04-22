<#import "/master/master-frame.ftl" as master />
<@master.masterFrame>
<div class="row">
	<div class="col-md-3 col-sm-3">
		<div class="row">
			<div class="col-xs-6 col-sm-12 col-md-6 text-center">
				<a href="#">
					<img id="headpic" src="<#if loginUserModel.avatarPic?? && loginUserModel.avatarPic != "" && loginUserModel.avatarPic?index_of("http") == 0>${loginUserModel.avatarPic}@150h_150w_1e_1c<#else>${defaultAvatar}</#if>" alt="用户头像" class="img-thumbnail">
				</a>
				<div class="seperator"></div>
				<div class="seperator"></div>
			</div><!-- /.col -->
			<div class="col-xs-6 col-sm-12 col-md-6">
				<strong class="font-14">${loginUserModel.userName!"未设置姓名"}</strong>
				<small class="block text-muted">
				</small> 
				<div class="seperator"></div>
				<a class="btn btn-success btn-xs m-bottom-sm" href="#formModal" data-toggle="modal">更换头像</a>
				<div class="seperator"></div>
				<div class="seperator"></div>
				<div class="seperator"></div>
			</div><!-- /.col -->
		</div><!-- /.row -->
		
		<div class="panel panel-default">	
			<div class="panel-heading">
				绑定的登录帐号
			</div>
			<div class="panel-body">
				<div class="tab-content">
					<div class="media">
							<div class="pull-left m-left-sm">
								<strong class="block">用户名登录</strong>
						<#assign bindAccount=getBindAccount(loginUser.userBindAccounts,"YiMinBang","ID") />
						<#if bindAccount?? && bindAccount!="">
								<small class="text-muted">${bindAccount.accountId}</small>
							</div>
							<div class="pull-right m-right-sm">
								<a class="btn btn-xs btn-warning" title="解绑" onclick="$.delBindAccount('YiMinBang','${bindAccount.accountId}');"><i class="fa fa-trash-o fa-lg"></i></a>
								<a class="btn btn-xs btn-success" title="更换" data-toggle="modal" data-target="#bindAccountID"><i class="fa fa-cog fa-lg"></i></a>
							</div>
						<#else>
								<small class="text-muted">尚未设置用户名</small>
							</div>
							<div class="pull-right m-right-sm">
								<a class="btn btn-xs btn-info pull-right" title="绑定" data-toggle="modal" data-target="#bindAccountID"><i class="fa fa-sign-in fa-lg"></i></a>
							</div>
						</#if>
					</div>
					<div class="media">
							<div class="pull-left m-left-sm">
								<strong class="block">邮箱登录</strong>
						<#assign bindAccount=getBindAccount(loginUser.userBindAccounts,"YiMinBang","Email") />
						<#if bindAccount?? && bindAccount!="">
								<small class="text-muted">${bindAccount.accountId}</small>
							</div>
							<div class="pull-right m-right-sm">
								<a class="btn btn-xs btn-warning" title="解绑" onclick="$.delBindAccount('YiMinBang','${bindAccount.accountId}');"><i class="fa fa-trash-o fa-lg"></i></a>
								<a class="btn btn-xs btn-success" title="更换" data-toggle="modal" data-target="#bindAccountEmail"><i class="fa fa-cog fa-lg"></i></a>
							</div>
						<#else>
								<small class="text-muted">未开通邮箱登录</small>
							</div>
							<div class="pull-right m-right-sm">
								<a class="btn btn-xs btn-info pull-right" title="开通邮箱登录" data-toggle="modal" data-target="#bindAccountEmail"><i class="fa fa-sign-in fa-lg"></i></a>
							</div>
						</#if>
					</div>
					<div class="media">
							<div class="pull-left m-left-sm">
								<strong class="block">手机号</strong>
						<#assign bindAccount=getBindAccount(loginUser.userBindAccounts,"YiMinBang","Phone") />
						<#if bindAccount?? && bindAccount!="">
								<small class="text-muted">${bindAccount.accountId}</small>
							</div>
							<div class="pull-right m-right-sm">
								<a class="btn btn-xs btn-warning" title="解绑" onclick="$.delBindAccount('YiMinBang','${bindAccount.accountId}');"><i class="fa fa-trash-o fa-lg"></i></a>
								<a class="btn btn-xs btn-success" title="更换" data-toggle="modal" data-target="#bindAccountPhone"><i class="fa fa-cog fa-lg"></i></a>
							</div>
						<#else>
								<small class="text-muted">未开通手机号登录</small>
							</div>
							<div class="pull-right m-right-sm">
								<a class="btn btn-xs btn-info pull-right" title="开通邮箱登录" data-toggle="modal" data-target="#bindAccountPhone"><i class="fa fa-sign-in fa-lg"></i></a>
							</div>
						</#if>
					</div>					
				</div>
			</div>
		</div>
	</div><!-- /.col -->
	<div class="col-md-9 col-sm-9">
		<div class="tab-content">
			
			<div class="tab-pane fade active in" id="edit">
				
				<div class="panel panel-default">
					<form class="form-horizontal form-border" name="editProfileFrom" id="editProfileFrom" method="post">
						<div class="panel-heading">
							基本信息
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="control-label col-md-2">真实姓名</label>												
								<div class="col-md-10">
									<input type="text" class="form-control input-sm" data-parsley-required="true" data-parsley-required-message="请输入真实姓名" data-parsley-length="[2,8]" data-parsley-length-message="真实姓名必须在2-8位之间" placeholder="此名称不会在网站中显示" value="${loginUser.userName!}" name="userName">
								</div><!-- /.col -->
							</div><!-- /form-group -->
							<div class="form-group">
								<label class="control-label col-md-2">昵称</label>												
								<div class="col-md-10">
									<input type="text" class="form-control input-sm" data-parsley-required="true" data-parsley-required-message="请输入昵称" data-parsley-length="[2,8]" data-parsley-length-message="昵称必须在2-8位之间" placeholder="网站和系统中显示的名称" value="${loginUser.nickName!}" name="nickName">
								</div><!-- /.col -->
							</div><!-- /form-group -->
							<div class="form-group">
								<label class="control-label col-md-2">生日</label>
								<div class="col-md-10">
									<input type="text" class="form-control input-sm" data-parsley-pattern="\d{4}-\d{2}-\d{2}" data-parsley-pattern-message="生日必须是yyyy-MM-dd的格式" name="brithDay" id="brithDay" placeholder="格式：yyyy-MM-dd"  value="<#if loginUser.birthday??>${loginUser.birthday?string('yyyy-MM-dd')}</#if>">
								</div><!-- /.col -->
							</div><!-- /form-group -->
							<div class="form-group">
								<label class="control-label col-md-2">性别</label>
								<div class="col-md-10">
									<label class="label-radio inline">
										<input type="radio" name="gender" value="M" <#if (loginUser.gender)?? && loginUser.gender == "M">checked="checked"</#if>>
										<span class="custom-radio"></span>
										男
									</label>
									<label class="label-radio inline">
										<input type="radio" name="gender" value="F" data-parsley-required="true" data-parsley-required-message="请选择性别" <#if (loginUser.gender)?? && loginUser.gender == "F">checked="checked"</#if>>
										<span class="custom-radio"></span>
										女
									</label>
								</div><!-- /.col -->
							</div><!-- /form-group -->
						</div>
						<div class="panel-footer">
							<div class="text-right">
								<button class="btn btn-sm btn-success" type="button" id="btnEditProfile">更新</button>
								<button class="btn btn-sm btn-success" type="reset">重置</button>
							</div>
						</div>
					</form>
				</div><!-- /panel -->
				
			</div><!-- /tab2 -->			
		</div><!-- /tab-content -->
	</div><!-- /.col -->
</div><!-- /.row -->	
<#assign bindAccount=getBindAccount(loginUser.userBindAccounts,"YiMinBang","Phone") />
<div class="modal fade in" id="bindAccountPhone">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4>登录手机号 <#if bindAccount?? && bindAccount!="">更换<#else>绑定</#if></h4>
			</div>
		    <div class="modal-body">
		        <form id="bindAccountFromPhone">
		        	<input type="hidden" name="accountType" value="Phone" />
		        	<input type="hidden" name="oldAccountId" value="<#if bindAccount?? && bindAccount!="">${bindAccount.accountId}</#if>" />
					
					<div class="form-group _panel">
						<div class="form-inline form-group">
							<label for="folderName">手机号</label>
							<input type="text" class="form-control input-sm" name="accountId" id="accountPhone" value="<#if bindAccount?? && bindAccount!="">${bindAccount.accountId}</#if>" placeholder="请输入手机号" data-parsley-required="true" data-parsley-required-message="请输入手机号" data-parsley-group="groupPhone" data-parsley-errors-container="#error1">
							<button class="btn btn-sm btn-success" type="button" onclick="$.sendPhoneVerifyCode('Phone','accountPhone');">获取验证码</button>
							<div id="error1">
							</div>
						</div>
						<div class="form-inline form-group">
							<label for="folderName">验证码</label>
							<input type="text" class="form-control input-sm" name="verifyCode" id="verifyCode" placeholder="请输入验证码" data-parsley-required="true" data-parsley-required-message="请输入验证码">
						</div>
					</div>					
				</form>
		    </div>
		    <div class="modal-footer">
		        <button class="btn btn-sm btn-success" data-dismiss="modal" aria-hidden="true">取消</button>
				<a href="#" class="btn btn-danger btn-sm" id="btnBindAccountPhone" onclick="$.bindAccount('bindAccountFromPhone');">保存</a>
		    </div>
	  	</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div>


<#assign bindAccount=getBindAccount(loginUser.userBindAccounts,"YiMinBang","ID") />
<div class="modal fade in" id="bindAccountID">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4>用户名 <#if bindAccount?? && bindAccount!="">更换<#else>绑定</#if></h4>
			</div>
		    <div class="modal-body">
		        <form id="bendAccoutIDFrom">
		        	<input type="hidden" name="accountType" value="ID" />
		        	<input type="hidden" name="oldAccountId" value="<#if bindAccount?? && bindAccount!="">${bindAccount.accountId}</#if>" />
					<div class="form-group form-inline _panel" id="_panelID">
						<label for="folderName">用户名</label>
						<input type="text" class="form-control input-sm" name="accountId" value="<#if bindAccount?? && bindAccount!="">${bindAccount.accountId}</#if>" placeholder="请输入用户名" data-parsley-required="true" data-parsley-required-message="请输入用户名" data-parsley-group="groupID">
			
						
					</div>					
				</form>
		    </div>
		    <div class="modal-footer">
		        <button class="btn btn-sm btn-success" data-dismiss="modal" aria-hidden="true">取消</button>
				<a href="#" class="btn btn-danger btn-sm" id="btnBindAccountID" onclick="$.bindAccount('bendAccoutIDFrom');">保存</a>
		    </div>
	  	</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div>


<#assign bindAccount=getBindAccount(loginUser.userBindAccounts,"YiMinBang","Email") />
<div class="modal fade in" id="bindAccountEmail">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4>登录邮箱 <#if bindAccount?? && bindAccount!="">更换<#else>绑定</#if></h4>
			</div>
			<div class="modal-body">
				<form id="bindAccountFormEmail">
					<input type="hidden" name="accountType" value="Email" />
					<input type="hidden" name="oldAccountId" value="<#if bindAccount?? && bindAccount!="">${bindAccount.accountId}</#if>" />
					<div class="form-group _panel">
						<div class="form-inline form-group">
							<label for="folderName">邮箱</label>
							<input type="email" class="form-control input-sm" id="accountEmail" name="accountId" value="<#if bindAccount?? && bindAccount!="">${bindAccount.accountId}</#if>" placeholder="请输入邮箱地址" data-parsley-required="true" data-parsley-required-message="请输入邮箱地址" data-parsley-group="groupEmail" data-parsley-errors-container="#error1">
							<button class="btn btn-sm btn-success" type="button" id="btnSendVerifyCode" onclick="$.sendEmailVerifyCode('Email','accountEmail');">获取验证码</button>
							<div id="error2">
							</div>
						</div>
						<div class="form-inline form-group">
							<label for="folderName">验证码</label>
							<input type="text" class="form-control input-sm" name="verifyCode" placeholder="请输入验证码" data-parsley-required="true" data-parsley-required-message="请输入验证码" >
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-sm btn-success" data-dismiss="modal" aria-hidden="true">取消</button>
				<a href="#" class="btn btn-danger btn-sm" id="btnBindAccountEmail" onclick="$.bindAccount('bindAccountFormEmail');">保存</a>
		    </div>
	  	</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="formModal" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4>更新头像</h4>
				</div>
				<div class="modal-body">
					<div class="panel panel-default">
						<div class="panel-body">
							<form class="form-horizontal form-border">
								<div class="form-group">
									<div class="col-lg-12">
										<div class="upload-file">
											<input type="file" name="file" id="imgUpload" class="upload-demo"/>
											<label data-title="选择图片" for="imgUpload">
												<span data-title="未选择图片"></span>
											</label>
										</div>
									</div><!-- /.col -->
								</div><!-- /form-group -->
								<div class="form-group text-right">
									<a href="javascript:ajaxFileUpload();" class="btn btn-success">上传</a>
									<a href="javascript:cancelBtn();" class="btn btn-success">取消</a>
								</div><!-- /form-group -->
							</form>			
						</div>
					</div>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div>
	<script src='${basePath}/resources/js/ajaxfileupload.js'></script>
<script language="javascript">

$(document).ready(function(){
	$("#brithDay").datepicker({
		dateFormat: 'yy-mm-dd',
		changeMonth: true,
		changeYear: true,
		yearRange:'-70:+70',
		maxDate:new Date()
	});
	<#if msg??>
	alertify.alert('${msg}');
	</#if>
});
function cancelBtn(){
	$("#imgUpload").val("");
	$('#formModal').modal('hide');
}
function ajaxFileUpload() {
	var img=$("#imgUpload").val();
	if(img != ''){
		img=img.substring(img.lastIndexOf(".")+1).toLowerCase();
		if(img!='jpg' && img != 'jpeg' && img != 'png'){
			alertify.alert("图片格式不符合要求!只能选择jpg,png格式的图片");
			return;
		}
	}else{
		return;
	}
	$.ajaxFileUpload({
		url: '${basePath}/main/imgupload',
		type: 'post',
		secureuri: false, //一般设置为false
		fileElementId: 'imgUpload', // 上传文件的id、name属性名
		dataType: 'json', //返回值类型，一般设置为json、application/json
		success: function(data, status){
			if(data.success){
				$("#headpic").attr("src",data.imageUrl);
				$("#lftHead").attr("src",data.imageUrl);
				$("#tpHead").attr("src",data.imageUrl);
				updateHeadPic(data.imageUrl);
			}else{
				alertify.alert("图片上传出错了");
			}
		},
		error: function(data, status, e){ 
			alertify.alert("图片上传出错了");
		}
	});
}

function updateHeadPic(headPic){
	$.ajax({
		cache: true,
		type: "POST",
		url:"${basePath}/main/updateHeadPic",
		data:"headPic="+headPic,
		async: false,
		error: function(request) {
			alertify.alert("错误：服务器异常！");
		},
		success: function(data) {
			if(data.success){
				$("#imgUpload").val("");
				$('#formModal').modal('hide');
				$.gritter.add({
					title: '<i class="fa fa-check-circle"></i>提示',
					text: '头像更换成功',
					sticky: false,
					time: '3000',
					class_name: 'gritter-success',
					position: 'bottom-left'
				});
			}
			else{
				alertify.alert("错误:" + data.message);
			}
		}
	});
}

$("#accountType").change(function(){
	$("._panel").hide();
	$("#_panel"+$("#accountType").val()).show();
});

$.sendPhoneVerifyCode = function(accountType,id){
	if($('#bindAccountFromPhone').parsley().validate("groupPhone")){
		$.ajax({
	        cache: true,
	        type: "POST",
	        url:"${basePath}/main/sendVerifyCode",
        	data:"accountType="+ accountType +"&accountId=" + $("#"+id).val(),
	        async: false,
	        error: function(request) {
	            alertify.alert("错误：服务器异常！");
	        },
	        success: function(data) {
	        	if(data.success){   
	        		alertify.alert("验证码已发送 ！");
		        }   
		        else{   
	            	alertify.alert("错误:" + data.message);
		        }   
	        }
	    });
    }
};
$.sendEmailVerifyCode = function(accountType,id){
	if($('#bindAccountFormEmail').parsley().validate("groupEmail")){
		var email=$("#"+id).val();
		var suffix=email.substring(email.indexOf('@')+1);
		if(suffix!='htke.com'){
			alertify.alert("请绑定公司内部邮箱！");
			return;
		}
		$.ajax({
	        cache: true,
	        type: "POST",
	        url:"${basePath}/main/sendVerifyCode",
        	data:"accountType="+ accountType +"&accountId=" + $("#"+id).val(),
	        async: false,
	        error: function(request) {
	            alertify.alert("错误：服务器异常！");
	        },
	        success: function(data) {
	        	if(data.success){   
	        		alertify.alert("验证码已发送 ！");
		        }   
		        else{   
	            	alertify.alert("错误:" + data.message);
		        }   
	        }
	    });
    }
};

$.delBindAccount = function(accountGroup,id){
	alertify.confirm("解绑后将不能用此帐号来登录，是否继续？", function (e) {
		if (e) {
			$.ajax({
		        cache: true,
		        type: "POST",
		        url:"${basePath}/main/delBindAccount",
		    	data:"accountGroup="+ accountGroup +"&accountId=" + id,
		        async: false,
		        error: function(request) {
		            alertify.alert("错误：服务器异常！");
		        },
		        success: function(data) {
		        	if(data.success){   
		        		alertify.alert("操作成功！",function(e){location.href="${basePath}/main/profile";});
			        }   
			        else{   
		            	alertify.alert("错误:" + data.message);
			        }   
		        }
		    });
		} 
	});
};


$.bindAccount = function(fromid){
	if($('#'+fromid).parsley().validate()){
		$.ajax({
	        cache: true,
	        type: "POST",
	        url:"${basePath}/main/addOrUpdateBindAccount",
	        data:$("#" + fromid).serialize(),
	        async: false,
	        error: function(request) {
	            alertify.error("错误：服务器异常！");
	        },
	        success: function(data) {
	        	if(data.success){   
	        		alertify.alert("绑定成功！",function(e){location.href="${basePath}/main/profile";});
		        }   
		        else{   
	            	alertify.alert("错误:" + data.message);
		        }   
	        }
	    });
	}
};

$("#btnEditProfile").click(function(){
	if($('#editProfileFrom').parsley().validate()){
		$.ajax({
	        cache: true,
	        type: "POST",
	        url:"${basePath}/main/updateprofile",
	        data:$('#editProfileFrom').serialize(),
	        async: false,
	        error: function(request) {
	            alertify.error("错误：服务器异常！");
	        },
	        success: function(data) {
	        	if(data.success){   
	        		alertify.alert("资料修改成功！",function(e){location.href="${basePath}/main/index";});
		        }   
		        else{   
	            	alertify.alert("错误:" + data.message);
		        }   
	        }
	    });
	}
});
</script>	

<#function getTypeName accountType>
	<#local groupName="未知"/>
	<#switch accountType>
		<#case "ID">
			<#local groupName="用户名"/>
			<#break>
		
		<#case "Phone">
			<#local groupName="手机号"/>
			<#break>
		
		<#case "Email">
			<#local groupName="邮箱"/>
			<#break>
	</#switch>
	<#return groupName>   
</#function>

<#function getBindAccount bindAccounts,accountGroup,accountType>
	<#local result = "">
	<#list bindAccounts as account>
		<#if account.accountType == accountType && account.accountGroup == accountGroup>
			<#local result = account> 
		</#if>
	</#list>
	<#return result>
</#function>
</@master.masterFrame>	