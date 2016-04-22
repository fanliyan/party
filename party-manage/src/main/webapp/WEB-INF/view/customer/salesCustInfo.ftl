<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["客户","客户管理","新增跟进"]>
<div class="padding-md">
	<div class="row">
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">基本资料</div>
					<div class="panel-body">
						<form class="form-horizontal form-border" id="customerForm" >
							<div class="row">
								<div class="col-md-2">
									<div class="form-group">
										<label class="col-md-4 control-label">客户姓名</label>
										<div class="col-md-6">
											<p class="form-control-static">${customerModel.name}</p>
										</div><!-- /.col -->
									</div><!-- /form-group -->
								</div><!-- /.col -->
								<div class="col-md-2">
									<div class="form-group">
										<label class="col-md-4 control-label">性别</label>
										<div class="col-md-6">
											<p class="form-control-static"><#if customerModel.gender=="M">男<#else>女</#if></p>
										</div><!-- /.col -->
									</div><!-- /form-group -->
								</div><!-- /.col -->
								<div class="col-md-2">
									<div class="form-group">
										<label class="col-md-4 control-label">客户手机</label>
										<div class="col-md-6">
											<p class="form-control-static">${customerModel.phone}</p>
										</div><!-- /.col -->
									</div><!-- /form-group -->
								</div><!-- /.col -->
								<div class="col-md-2">
									<div class="form-group">
										<label class="col-md-4 control-label">居住城市</label>
										<div class="col-md-6">
											<p class="form-control-static">${customerModel.city.cityName}</p>
										</div><!-- /.col -->
									</div><!-- /form-group -->
								</div><!-- /.col -->
								<div class="col-md-2">
									<div class="form-group">
										<label class="col-md-4 control-label">意向国家</label>
										<div class="col-md-6">
											<#list intCountrys as country>
												<span class="badge badge-warning">${country.countryName}</span>
											</#list>
										</div><!-- /.col -->
									</div><!-- /form-group -->
								</div><!-- /.col -->
							</div>
							<#if customerModel.reason??>
								<div class="row">
									<div class="col-md-2">
										<div class="form-group">
											<label class="col-md-4 control-label">不通过原因</label>
											<div class="col-md-6">
												<p class="form-control-static">${customerModel.phone}</p>
											</div><!-- /.col -->
										</div><!-- /form-group -->
									</div><!-- /.col -->
								</div>
							</#if>
						</div>
					</div><!-- /panel -->
					<div class="panel-footer text-center">
						<a href="#formModal" class="btn btn-success" data-toggle="modal">新增跟进</a>
						<a href="javascript:history.go(-1);" class="btn btn-default" data-toggle="modal">返回</a>
					</div>
				</div>
			</div>
		</form>
		
		<div class="col-md-6 col-md-offset-3">
			<div class="panel panel-default">
				<div class="panel-heading">最新跟进</div>
				<table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
					<thead>
						<tr>
							<th>跟进时间</th>
							<th>跟进人</th>
							<th>跟进类型</th>
							<th>跟进内容</th>
							<th>后续跟进类型</th>
							<th>后续跟进时间</th>
						</tr>
					</thead>
					<tbody>
						<#if followLogs ??>
						<#list followLogs as log>
						<tr>
							<td>${log.followTime?string('yyyy-MM-dd HH:mm')}</td>
							<td>${log.followUser.userName!}</td>
							<td>
								<#if followTypeModels??>
									<#list followTypeModels as type>
										<#if type.followType==log.followType>
											${type.followTypeName}
										</#if>
									</#list>
								</#if>
							</td>
							<td>${log.followDesc}</td>
							<td>
								<#if followTypeModels??>
									<#list followTypeModels as type>
										<#if log.nextFollowType?? && type.followType==log.nextFollowType>
											${type.followTypeName}
										</#if>
									</#list>
								</#if>
							</td>
							<td><#if log.nextFollowTime??>${log.nextFollowTime?string('yyyy-MM-dd HH:mm')}</#if></td>
						</tr>
						</#list>
						</#if>
					</tbody>
				</table>
			</div><!-- /panel -->
		</div><!-- /.col -->
			
	</div>
</div>
	<div class="modal fade" id="formModal" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4>添加跟进</h4>
				</div>
				<div class="modal-body">
					<div class="panel panel-default">
						<div class="panel-body">
							<form id="adForm" class="form-horizontal form-border">
								<div class="form-group">
									<label class="col-md-3 control-label">客户姓名</label>
									<div class="col-md-8">
										<input type="hidden" name="customerId" value="${customerModel.customerId}"/>
										<input type="hidden" name="followUserid" value="${customerModel.loginUserId}"/>
										<p class="form-control-static">${customerModel.name}</p>
									</div><!-- /.col -->
								</div><!-- /form-group -->
								
								<div class="form-group">
									<label class="col-md-3 control-label">跟进类型</label>
									<div class="col-md-8">
										<select class="form-control" data-placeholder="请选择跟进类型" name="followType" id="intCountry" required data-parsley-required-message="跟进类型不可为空">
											<option value=""></option>
											<#if followTypeModels ??>
												<#list followTypeModels as type>
													<option value="${type.followType}">${type.followTypeName}</option>
												</#list>
											</#if>
										</select>
									</div><!-- /.col -->
								</div><!-- /form-group -->
								
								<div class="form-group">
									<label class="col-md-3 control-label">跟进时间</label>
									<div class="col-md-8">
										<div class="input-group">
											<input id="time" name="followDate" placeholder="请点击选择跟进时间" class="form-control input-sm"
											 readonly type="text" value=""  required data-parsley-required-message="跟进时间不可为空"
											 data-parsley-errors-container="#timeError"
											 />
											<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
										</div>
										<ul class="parsley-errors-list filled" id="timeError"><li class="parsley-required"></li></ul>
									</div><!-- /.col -->
								</div><!-- /form-group -->
								
								<div class="form-group">
									<label class="col-md-3 control-label">跟进内容</label>
									<div class="col-md-8">
										<textarea name="followDesc" class="form-control" rows="5" placeholder="请输入跟进内容" data-parsley-required="true"
										 data-parsley-required-message="跟进内容不可为空"
										 data-parsley-maxlength="120"
										 data-parsley-maxlength-message="内容长度不能超过120"
										 ></textarea>
									</div><!-- /.col -->
								</div><!-- /form-group -->
								
								<div class="form-group">
									<label class="col-md-3 control-label">后续跟进类型</label>
									<div class="col-md-8">
										<select class="form-control" data-placeholder="请选择跟进类型" name="nextFollowType" id="intCountry">
											<option value=""></option>
											<#if followTypeModels ??>
												<#list followTypeModels as type>
													<option value="${type.followType}">${type.followTypeName}</option>
												</#list>
											</#if>
										</select>
									</div><!-- /.col -->
								</div><!-- /form-group -->
								
								<div class="form-group">
									<label class="col-md-3 control-label">后续跟进时间</label>
									<div class="col-md-8">
										<div class="input-group">
											<input id="nexttime" name="nextFollowDate" placeholder="请点击选择跟进时间" class="form-control input-sm" 
											 readonly type="text" value=""
											 />
											<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
										</div>
										<ul class="parsley-errors-list filled" id="nameError"><li class="parsley-required"></li></ul>
									</div><!-- /.col -->
								</div><!-- /form-group -->
								
								<div class="form-group text-right">
									<a href="javascript:pass();" class="btn btn-success">保存</a>
									<a href="javascript:cancelBtn();" class="btn btn-success">取消</a>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div>
<link href="${basePath}/resources/js/timepicker/jquery-ui-timepicker-addon.min.css" rel="stylesheet" type="text/css" />
<script src="${basePath}/resources/js/timepicker/jquery-ui-timepicker-addon.min.js" type="text/javascript"></script>
<script src="${basePath}/resources/js/timepicker/jquery-ui-timepicker-zh-CN.js" type="text/javascript"></script>

<script language="javascript">
$(document).ready(function () {
	$('#time').datetimepicker({
		hour: 12,
		minute: 30,
		timeFormat: "HH:mm",
		dateFormat: "yy-mm-dd",
		minDate: new Date(2015, 0, 01, 00, 00),
		yearRange:'-1:+1',
		changeMonth: true,
		changeYear: true
	});
	$('#nexttime').datetimepicker({
		hour: 12,
		minute: 30,
		timeFormat: "HH:mm",
		dateFormat: "yy-mm-dd",
		minDate: new Date(),
		yearRange:'-1:+1',
		changeMonth: true,
		changeYear: true
	});
});
function pass(){
	if($('#adForm').parsley().validate()){
		$.submitSales();
	}
}

function cancelBtn(){
	$("#adviserUserid").val("");
	$('#formModal').modal('hide');
}

$.submitSales = function(){
	var flag=$("#reviewStatus").val();
	$.ajax({
		cache: false,
		type: "POST",
		url:"${basePath}/salesCust/saveFollow",
		data:$('#adForm').serialize(),
		async: false,
		error: function(request) {
			alertify.alert("错误：服务器异常！");
		},
		success: function(data) {
			if(data.success){
				var customerId=data.id;
				location.href="${basePath}/salesCust/info?customerId="+customerId;
			}
			else{
				alertify.alert("错误:" + data.message);
			}
		}
	});
}
</script>
</@master.masterFrame>