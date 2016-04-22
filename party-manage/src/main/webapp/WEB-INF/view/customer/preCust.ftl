<#import "/master/master-frame.ftl" as master />
<#import "/control/common/citySelect.ftl" as citySelect>
<@master.masterFrame pageTitle=["客户","客户管理","报备客户"]>
<div class="padding-md">
	<div class="row">
		<form class="form-horizontal form-border" id="customerForm" >
			<input type="hidden" name="customerId" value="${customerModel.customerId}"/>
			<div class="row">
				<div class="col-md-6">
					<div class="panel panel-default">
						<div class="panel-heading">基本资料(必填)</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-lg-2 control-label">客户姓名</label>
								<div class="col-lg-10">
									<input name="name" type="text" class="form-control input-sm" id="" placeholder="请输入客户姓名"
									 data-parsley-trigger="blur"
									 data-parsley-required="true"
									 data-parsley-required-message="客户姓名不可为空"
									 value="${customerModel.name}"
									/>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
							<div class="form-group">
								<label class="col-lg-2 control-label">性别</label>
								<div class="col-lg-10">
									<label class="label-radio inline">
										<input type="radio" name="gender" value="M" <#if customerModel.gender=="M">checked="checked"</#if>>
										<span class="custom-radio"></span>
										男
									</label>
									<label class="label-radio inline">
										<input type="radio" name="gender" value="F" <#if customerModel.gender=="F">checked="checked" </#if>>
										<span class="custom-radio"></span>
										女
									</label>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
							<div class="form-group">
								<label class="col-lg-2 control-label">客户手机</label>
								<div class="col-lg-10">
									<input type="text" name="phone" class="form-control input-sm" id="inputEmail1" placeholder="请输入客户手机"
									 data-parsley-required="true"
									 data-parsley-trigger="blur"
									 data-parsley-required-message="客户手机不可为空"
									 data-parsley-mobilePnone
									 data-parsley-mobilePnone-message="请填写正确的手机号"
									 value="${customerModel.phone}"
									/>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
							<div class="form-group">
								<label class="col-lg-2 control-label">居住城市</label>
								<#if customerModel??>
									<@citySelect.citySelect countryModelList=countryModelList selectedCityId=customerModel.cityId notNull=true/>
								<#else>
									<@citySelect.citySelect countryModelList=countryModelList  notNull=true/>
								</#if>
							</div><!-- /form-group -->
							
						</div>
					</div><!-- /panel -->
				</div>
				
				<div class="col-md-6">
					<div class="panel panel-default">
						<div class="panel-heading">移民意向(必填)</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-lg-3 control-label">意向国家</label>
								<div class="col-lg-9">
									<select multiple class="form-control chzn-select" data-placeholder="请选择意向国家" name="intCountrys" id="intCountry" required data-parsley-required-message="意向国家不可为空">
										<#if countryModels ??>
											<#list countryModels as country>
												<option value="${country.countryId}" ${checked(country.countryId)}>${country.countryName}</option>
											</#list>
										</#if>
									</select>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
							<div class="form-group">
								<label class="col-lg-3 control-label">意向项目</label>
								<div class="col-lg-9">
									<select multiple class="form-control chzn-select" id="intProducts" name="intProducts" data-placeholder="请选择意向项目" required data-parsley-required-message="意向项目不可为空">
										<#if productList??>
											<#list productList as product>
												<option value="${product.productId}" >${product.name}</option>
											</#list>
										</#if>
									</select>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
							<div class="form-group">
								<label class="col-lg-3 control-label">可投资金额</label>
								<div class="col-lg-9">
									<select name="invId" class="form-control chzn-select" data-placeholder="请选择可投资金额" required data-parsley-required-message="可投资金额不可为空">
										<option value=""></option>
										<#if invAmountTypes ??>
											<#list invAmountTypes as invAmountType>
												<option value="${invAmountType.invId}">${invAmountType.invTypeName}</option>
											</#list>
										</#if>
									</select>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
							<div class="form-group">
								<label class="col-lg-3 control-label">移民目的</label>
								<div class="col-lg-9">
									<select name="purposeId" multiple class="form-control chzn-select" data-placeholder="请选择移民目的" required data-parsley-required-message="移民目的不可为空">
										<#if purposes??>
											<#list purposes as purpose>
												<option value="${purpose.purposeId}">${purpose.purposeName}</option>
											</#list>
										</#if>
									</select>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
						</div>
					</div><!-- /panel -->
				</div><!-- /.col -->
			</div>
			
			<div class="row">
				<div class="col-md-6">
					<div class="panel panel-default">
						<div class="panel-heading">跟进方式(必填)</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-lg-2 control-label">跟进方式</label>
								<div class="col-lg-10">
									<select name="followType" class="form-control" required data-parsley-required-message="跟进方式不可为空">
										<option value="0" disabled>请选择跟进方式</option>
										<option value="1">直接联系客户</option>
										<option value="2">跟客户经理一起</option>
									</select>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
							<div class="form-group">
								<label class="col-lg-2 control-label">跟进时间</label>
								<div class="col-lg-10">
									<div class="row">
									<#if groupTimeTypes ??>
										<div class="col-lg-6">
											<select name="timeGroup${groupTimeTypes?first.timeTypes?first.groupType}" class="form-control chzn-select" data-placeholder="请选择跟进时间" required data-parsley-required-message="跟进时间不能为空">
												<option value=""></option>
												<#list (groupTimeTypes?first).timeTypes as timeType>
													<option value="${timeType.followTime}">${timeType.followName}</option>
												</#list>
											</select>
										</div><!-- /.col -->
										<div class="col-lg-6">
											<select name="timeGroup${groupTimeTypes?last.timeTypes?first.groupType}" class="form-control chzn-select" data-placeholder="请选择跟进时间" required data-parsley-required-message="跟进时间不能为空">
												<option value=""></option>
												<#list (groupTimeTypes?last).timeTypes as timeType>
													<option value="${timeType.followTime}">${timeType.followName}</option>
												</#list>
											</select>
										</div><!-- /.col -->
									</#if>
									</div>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
							<div class="form-group">
								<label class="col-lg-2 control-label">备注</label>
								<div class="col-lg-10">
									<textarea name="remark" class="form-control" rows="2"></textarea>
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
									<textarea name="childInfo" class="form-control" rows="5"></textarea>
								</div><!-- /.col -->
							</div><!-- /form-group -->
							
						</div>
					</div><!-- /panel -->
				</div><!-- /.col -->
			</div>
			
			<div class="panel-footer text-center">
				<button type="button" class="btn btn-success btn-sm" id="submitButton">报备</button>
				<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1);">取消</button>
			</div>
		</div>
		
	</form>
</div>
<#function checked countryId>
	<#if intCountrys??>
		<#list intCountrys as country>
			<#if country.countryId == countryId>
				<#return "selected='selected'">
				<#break>
			</#if>
		</#list>
	</#if>
	<#return "">   
</#function>
<script language="javascript">
window.ParsleyConfig = {
	validators: {
		mobilePnone: {
			fn: function (value) {
				var reg = /^1[3|4|5|7|8][0-9]\d{8}$/;
				return reg.test(value);
			},
			priority: 32
		}
	} 
};

$("#submitButton").click(function(){
	if($('#customerForm').parsley().validate()){
		$.submitSales();
	}
});

$.submitSales = function(){
	$.ajax({
		cache: false,
		type: "POST",
		url:"${basePath}/salesCust/savePre",
		data:$('#customerForm').serialize(),
		async: false,
		error: function(request) {
			alertify.alert("错误：服务器异常！");
		},
		success: function(data) {
			if(data.success){   
				alertify.alert("操作成功！",function(e){location.href="${basePath}/salesCust/list";});
			}
			else{
				alertify.alert("错误:" + data.message);
			}
		}
	});
}

$("#intCountry").change(function(){
	var intCountry=$("#intCountry").val();
	var intProducts=$('#intProducts').val();
	if(intCountry!=''){
		$.ajax({
			cache: false,
			type: "POST",
			url:"${basePath}/product/productJson",
			data:"countryId="+intCountry,
			async: false,
			error: function(request) {
				alertify.alert("错误：服务器异常！");
			},
			success: function(data) {
				$("#intProducts").empty();
				for(var i=0;i<data.length;i++){
					$("#intProducts").append("<option value='"+data[i].code+"'>"+data[i].name+"</option>");
				}
				
				$('#intProducts').val(intProducts);
				$('#intProducts').trigger('chosen:updated');
			}
		});
	}
});
</script>
</@master.masterFrame>