<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["客户","客户管理","经纪人客户审核"]>
<div class="padding-md">
	<div class="row">
		<form class="form-horizontal form-border" id="customerForm" >
			<input type="hidden" name="customerId" value="${customerModel.customerId}"/>
			<div class="row">
				<div class="col-md-6">
					<div class="panel panel-default">
						<div class="panel-heading">基本资料</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-lg-2 control-label">客户姓名</label>
								<div class="col-lg-10">
									<p class="form-control-static">${customerModel.name}</p>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
							<div class="form-group">
								<label class="col-lg-2 control-label">性别</label>
								<div class="col-lg-10">
									<p class="form-control-static"><#if customerModel.gender=="M">男<#else>女</#if></p>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
							<div class="form-group">
								<label class="col-lg-2 control-label">客户手机</label>
								<div class="col-lg-10">
									<p class="form-control-static">${customerModel.phone}</p>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
							<div class="form-group">
								<label class="col-lg-2 control-label">居住城市</label>
								<div class="col-lg-10">
									<p class="form-control-static">${customerModel.city.cityName}</p>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
						</div>
					</div><!-- /panel -->
				</div>
				
				<div class="col-md-6">
					<div class="panel panel-default">
						<div class="panel-heading">移民意向</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-lg-3 control-label">意向国家</label>
								<div class="col-lg-9">
									<#list customerModel.intentionCountry as country>
										<span class="badge badge-warning">${country.countryName}</span>
									</#list>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
							<div class="form-group">
								<label class="col-lg-3 control-label">意向项目</label>
								<div class="col-lg-9">
									<#if (customerModel.intentionProduct)??>
									<#list customerModel.intentionProduct as product>
										<span class="badge badge-warning">${product.name}</span>
									</#list>
									</#if>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
							<div class="form-group">
								<label class="col-lg-3 control-label">可投资金额</label>
								<div class="col-lg-9">
									<p class="form-control-static">${customerModel.investmentAmountType.invTypeName}</p>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
							<div class="form-group">
								<label class="col-lg-3 control-label">移民目的</label>
								<div class="col-lg-9">
									<#list customerModel.purpose as purpose>
										<span class="badge m-left-xs">${purpose.purposeName}</span>
									</#list>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
						</div>
					</div><!-- /panel -->
				</div><!-- /.col -->
			</div>
			
			<div class="row">
				<div class="col-md-6">
					<div class="panel panel-default">
						<div class="panel-heading">跟进方式</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-lg-2 control-label">跟进方式</label>
								<div class="col-lg-10">
									<#if customerModel.followType==1>
										<p class="form-control-static">直接联系客户</p>
									<#else>
										<p class="form-control-static">跟客户经理一起</p>
									</#if>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
							<div class="form-group">
								<label class="col-lg-2 control-label">跟进时间</label>
								<div class="col-lg-10">
									<p class="form-control-static">
										<#list customerModel.followTime as followTimeType>
												${followTimeType.followName}&nbsp;&nbsp;
										</#list>
									</p>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
							<div class="form-group">
								<label class="col-lg-2 control-label">备注</label>
								<div class="col-lg-10">
									<p class="form-control-static">${customerModel.remark!}</p>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
						</div>
					</div><!-- /panel -->
				</div>
				<div class="col-md-6">
					<div class="panel panel-default">
						<div class="panel-heading">补充信息</div>
						<div class="panel-body">
							
							<div class="form-group">
								<label class="col-lg-3 control-label">子女信息</label>
								<div class="col-lg-9">
									<p class="form-control-static">${customerModel.childInfo!}</p>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
						</div>
					</div><!-- /panel -->
				</div><!-- /.col -->
			</div>
			
			<div class="panel-footer text-center">
				<a href="#formModal" class="btn btn-success" data-toggle="modal">通过</a>
				<a href="#formModal1" class="btn btn-warning"  data-toggle="modal">不通过</a>
				<a href="javascript:history.go(-1);" class="btn btn-default" data-toggle="modal">取消</a>
				<input type="hidden" id="reviewStatus" name="reviewStatus" value="1"/>
				<input type="hidden" name="adviserUserid" id="adviserUserid" value=""/>
				<input type="hidden" name="reason" id="reason" value=""/>
				<input type="hidden" name="phone" value="${customerModel.phone}"/>
			</div>
		</div>
	</form>
	<div class="modal fade" id="formModal" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4>选择顾问</h4>
				</div>
				<div class="modal-body">
					<div class="panel panel-default">
						<div class="panel-body">
							<form id="adForm">
								<div class="form-group">
									<select id="adUser" class="form-control chzn-select" data-placeholder="请选择顾问" required data-parsley-required-message="顾问不可为空">
										<option value=""></option>
										<#if advisorUsers ??>
											<#list advisorUsers as user>
												<option value="${user.userid}">${(user.userName)!}</option>
											</#list>
										</#if>
									</select>
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
	<div class="modal fade" id="formModal1" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4>请填写拒绝理由</h4>
				</div>
				<div class="modal-body">
					<div class="panel panel-default">
						<div class="panel-body">
							<form id="unpassForm">
								<div class="form-group">
									<textarea id="unpassReason" class="form-control" rows="5" placeholder="请输入不通过理由内容不超过100字" 
									 data-parsley-required="true"
									 data-parsley-required-message="不通过理由不可为空"
									 data-parsley-maxlength="100"
									 data-parsley-maxlength-message="内容长度不能超过100"
									 ></textarea>
								</div>
								<div class="form-group text-right">
									<a href="javascript:unpass();" class="btn btn-success">保存</a>
									<a href="javascript:cancelUnpassBtn();" class="btn btn-success">取消</a>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div>
</div>
<script language="javascript">

function pass(){
	if($('#adForm').parsley().validate()){
		$("#reviewStatus").val(1);
		$("#adviserUserid").val($("#adUser").val());
		$.submitSales();
	}
}
function unpass(){
	if($('#unpassForm').parsley().validate()){
		$("#reviewStatus").val(-1);
		$("#reason").val($("#unpassReason").val());
		$.submitSales();
	}
}

function cancelBtn(){
	$("#adviserUserid").val("");
	$('#formModal').modal('hide');
}
function cancelUnpassBtn(){
	$("#adviserUserid").val("");
	$('#formModal1').modal('hide');
}

$.submitSales = function(){
	var flag=$("#reviewStatus").val();
	$.ajax({
		cache: false,
		type: "POST",
		url:"${basePath}/preSalesCust/revCust",
		data:$('#customerForm').serialize(),
		async: false,
		error: function(request) {
		alertify.alert("错误：服务器异常！");
		},
		success: function(data) {
			if(data.success){
				alertify.alert("操作成功！",function(e){location.href="${basePath}/preSalesCust/list";});
			}
			else{
				alertify.alert("错误:" + data.message);
			}
		}
	});
}
</script>
</@master.masterFrame>