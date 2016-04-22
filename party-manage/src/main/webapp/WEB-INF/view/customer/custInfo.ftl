<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["客户","客户管理","客户详情"]>
<div class="panel panel-default">
	<div class="panel-tab clearfix">
		<ul class="tab-bar">
			<li class="active" id="baseLi"><a href="#home1" data-toggle="tab"><i class="fa fa-home"></i> 基本信息</a></li>
			<li id="materialLi"><a href="#message1" id="materiala" data-toggle="tab"><i class="fa fa-book"></i> 跟进日志</a></li>
		</ul>
	</div>
	<div class="panel-body">
		<div class="tab-content">
			<div class="tab-pane fade in active" id="home1">
				<form class="form-horizontal form-border" id="customerForm" >
					<div class="form-group">
						<label class="col-md-4 control-label">客户姓名</label>
						<div class="col-md-6">
							<p class="form-control-static">${(customerModel.name)!}</p>
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label class="col-md-4 control-label">性别</label>
						<div class="col-md-6">
							<p class="form-control-static"><#if customerModel.gender=="M">男<#else>女</#if></p>
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label class="col-md-4 control-label">客户手机</label>
						<div class="col-md-6">
							<p class="form-control-static">${(customerModel.phone)!}</p>
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label class="col-md-4 control-label">客户邮箱</label>
						<div class="col-md-6">
							<p class="form-control-static">${(customerModel.email)!}</p>
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label class="col-md-4 control-label">居住城市</label>
						<div class="col-md-6">
							<p class="form-control-static">${(customerModel.city.cityName)!}</p>
						</div><!-- /.col -->
					</div><!-- /form-group -->
			
					<div class="form-group">
						<label class="col-md-4 control-label">所属经纪人</label>
						<div class="col-md-6">
							<p class="form-control-static">${(customerModel.belongUser.userName)!}</p>
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label class="col-md-4 control-label">所属顾问</label>
						<div class="col-md-6">
							<p class="form-control-static">${(customerModel.adviserUser.userName)!}</p>
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label class="col-md-4 control-label">客户来源</label>
						<div class="col-md-6">
							<p class="form-control-static">${(customerModel.sourceString)!}</p>
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label class="col-md-4 control-label">跟进方式</label>
						<div class="col-md-6">
							<p class="form-control-static">
								<#if (customerModel.followType)??>
									<#if customerModel.followType==1>
										直接联系客户
									<#else>
										跟客户经理一起
									</#if>
								</#if>
							</p>
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label class="col-md-4 control-label">跟进时间</label>
						<div class="col-md-6">
							<p class="form-control-static">
								<#if (customerModel.followTime)??>
									<#list customerModel.followTime as followTime>
										${followTime.followName}&nbsp;&nbsp;
									</#list>
								</#if>
							</p>
						</div><!-- /.col -->
					</div><!-- /form-group -->
			
					<div class="form-group">
						<label class="col-md-4 control-label">意向国家</label>
						<div class="col-md-6">
							<p class="form-control-static">
							<#if (customerModel.intentionCountry)??>
							<#list customerModel.intentionCountry as country>
								${country.countryName}&nbsp;&nbsp;
							</#list>
							</#if>
							</p>
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label class="col-md-4 control-label">意向项目</label>
						<div class="col-md-6">
							<p class="form-control-static">
							<#if (customerModel.intentionProduct)??>
							<#list customerModel.intentionProduct as product>
								${product.name}&nbsp;&nbsp;
							</#list>
							</#if>
							</p>
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label class="col-md-4 control-label">可投资金额</label>
						<div class="col-md-6">
								<p class="form-control-static">${(customerModel.investmentAmountType.invTypeName)!}</p>
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label class="col-md-4 control-label">移民目的</label>
						<div class="col-md-6">
							<p class="form-control-static">
							<#if (customerModel.purpose)??>
							<#list customerModel.purpose as purpose>
								${purpose.purposeName}
							</#list>
							</#if>
							</p>
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label class="col-md-4 control-label">子女情况</label>
						<div class="col-md-6">
							<p class="form-control-static">${(customerModel.childinfo)!}</p>
						</div><!-- /.col -->
					</div><!-- /form-group -->
					
					<div class="form-group">
						<label class="col-md-4 control-label">备注</label>
						<div class="col-md-6">
							<p class="form-control-static">${(customerModel.remark)!}</p>
						</div><!-- /.col -->
					</div><!-- /form-group -->
				</form>
			</div>
			<div class="tab-pane fade" id="message1">
				<div class="col-md-6 col-md-offset-3">
					<div class="panel panel-default table-responsive">
						
						<table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
							<thead>
								<tr>
									<th>跟进时间</th>
									<th>跟进人</th>
									<th>跟进类型</th>
									<th>跟进内容</th>
									<th>后续跟进类型</th>
									<th>后续跟进时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<#if followLogs ??>
								<#list followLogs as log>
								<tr>
									<td><#if (log.followTime)??>${log.followTime?string('yyyy-MM-dd HH:mm')}</#if></td>
									<td>${(log.followUser.userName)!}</td>
									<td>
										<#if followTypeModels??>
											<#list followTypeModels as type>
												<#if (log.followType)??>
												<#if type.followType==log.followType>
													${type.followTypeName}
												</#if>
												</#if>
											</#list>
										</#if>
									</td>
									<td>${(log.followDesc)!}</td>
									<td>
										<#if followTypeModels??>
											<#list followTypeModels as type>
												<#if (log.nextFollowType)??>
												<#if type.followType==log.nextFollowType>
													${type.followTypeName}
												</#if>
												</#if>
											</#list>
										</#if>
									</td>
									<td><#if (log.nextFollowTime)??>${log.nextFollowTime?string('yyyy-MM-dd HH:mm')}</#if></td>
									<td>
										<a class="btn btn-xs btn-warning" href="${basePath}/customer/followLogInfo?followLogId=${log.followLogId}"><i class="fa fa-info-circle fa-lg"></i> 查看</a>
									</td>
								</tr>
								</#list>
								</#if>
							</tbody>
						</table>
					</div><!-- /panel -->
				</div><!-- /.col -->
			</div>
		</div>
	</div>
	<div class="panel-footer text-center">
		<a href="javascript:history.go(-1);" class="btn btn-default" data-toggle="modal">返回</a>
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
										<p class="form-control-static">${customerModel.name}</p>
									</div><!-- /.col -->
								</div><!-- /form-group -->
								
								<div class="form-group">
									<label class="col-md-3 control-label">跟进类型</label>
									<div class="col-md-8">
										<select class="form-control chzn-select" data-placeholder="请选择跟进类型" name="followType" id="intCountry" required data-parsley-required-message="跟进类型不可为空">
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
										<select class="form-control chzn-select" data-placeholder="请选择跟进类型" name="nextFollowType" id="intCountry">
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
								<div class="form-group">
									<label for="exampleInputEmail1" class="col-md-3 control-label">上传图片</label>
									<div class="col-md-8">
										<input type="hidden" name="materialDemo#id#" id="materialDemo#id#">
										<a class="btn btn-sm btn-primary insertFile" maxFile="10"><i class="fa fa-book"></i> 选择文件</a>
									</div>
								</div>
								<div class="form-group" id="imagesDiv">
									
								</div>
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
		maxDate: new Date()
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
	
	$(".insertFile").selectFile(function(clickbutton,uploadFiles){
		if(uploadFiles.length > 0){
			var imgHtml="";
			for(var i=0;i<uploadFiles.length;i++){
				imgHtml+="<img style='width:80px;height:80px;' src='"+uploadFiles[i]+"' class='img-thumbnail'>";
				imgHtml+="<input type='hidden' name='imgs' value='"+uploadFiles[i]+"'>";
			}
			$("#imagesDiv").html(imgHtml);
		}
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
		url:"${basePath}/customer/saveFollow",
		data:$('#adForm').serialize(),
		async: false,
		error: function(request) {
			alertify.alert("错误：服务器异常！");
		},
		success: function(data) {
			if(data.success){
				var customerId=data.id;
				location.href="${basePath}/customer/info?customerId="+customerId;
			}
			else{
				alertify.alert("错误:" + data.message);
			}
		}
	});
}
</script>
</@master.masterFrame>