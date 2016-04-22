<#import "/master/master-frame.ftl" as master />
<#import "/control/common/citySelect.ftl" as citySelect>
<#if customerModel??>
	<#assign title=["客户","移民帮客户管理","修改客户"]>
	<#assign isEdit=true>
<#else>
	<#assign title=["客户","移民帮客户管理","新增客户"]>
	<#assign isEdit=false>
</#if>
<@master.masterFrame pageTitle=title>
<div class="padding-md">
	<div class="row">
		<form class="form-horizontal form-border" id="customerForm" >
			<#if isEdit>
				<input type="hidden" name="customerId" value="${customerModel.customerId}"/>
			</#if>
			<div class="row">
				<div class="col-md-6">
					<div class="panel panel-default">
						<div class="panel-heading">基本资料</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-md-2 control-label">客户姓名</label>
								<div class="col-md-10">
									<input name="name" type="text" class="form-control input-sm" id="" placeholder="必填,字符最大长度20"
									 data-parsley-trigger="blur"
									 data-parsley-required="true"
									 data-parsley-maxlength="20"
									 data-parsley-maxlength-message="名字最大不能超过20个字"
									 data-parsley-required-message="客户姓名不可为空"
									 value="${(customerModel.name)!}"
									/>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-md-2 control-label">性别</label>
								<div class="col-md-10">
									<label class="label-radio inline">
										<input type="radio" name="gender" value="M" <#if isEdit><#if customerModel.gender=="M">checked="checked"</#if><#else>checked="checked"</#if>>
										<span class="custom-radio"></span>
										男
									</label>
									<label class="label-radio inline">
										<input type="radio" name="gender" value="F" <#if isEdit><#if customerModel.gender=="F">checked="checked" </#if></#if>>
										<span class="custom-radio"></span>
										女
									</label>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-md-2 control-label">客户手机</label>
								<div class="col-md-10">
									<input type="text" name="phone" class="form-control input-sm" id="inputEmail1" placeholder="请输入客户手机"
									 data-parsley-required="true"
									 data-parsley-trigger="blur"
									 data-parsley-required-message="客户手机不可为空"
									 data-parsley-mobilePnone
									 data-parsley-mobilePnone-message="请填写正确的手机号"
									 value="${(customerModel.phone)!}"
									/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">手机2</label>
								<div class="col-md-10">
									<input type="text" name="phone2" class="form-control input-sm" id="inputEmail1" placeholder="请输入客户手机"
									 data-parsley-trigger="blur"
									 data-parsley-mobilePnone
									 data-parsley-mobilePnone-message="请填写正确的手机号"
									 value="${(customerModel.phone2)!}"
									/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">客户邮箱</label>
								<div class="col-md-10">
									<input type="email" name="email" class="form-control input-sm" id="inputEmail1" placeholder="请输入客户邮箱"
									 value="${(customerModel.email)!}"
									 data-parsley-maxlength="50"
									 data-parsley-maxlength-message="邮箱长度不能超过50个字符"
									/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">居住城市</label>
								<div class="col-md-10">
									<@citySelect.citySelect countryModelList=countryModelList selectedCityId=(customerModel.cityId)!0 notNull=true/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">客户来源</label>
								<div class="col-md-10">
									<select class="form-control chzn-select" id="source" name="source" data-placeholder="请选客户来源" required data-parsley-required-message="客户来源不可为空">
										<#if grantAdvisor?? && grantAdvisor>
											<option ></option>
											<option value="0" <#if (customerModel.source)?? && customerModel.source==0>selected</#if>>经纪人报备</option>
											<option value="1" <#if (customerModel.source)?? && customerModel.source==1>selected</#if>>网站客户</option>
											<option value="2" <#if (customerModel.source)?? && customerModel.source==2>selected</#if>>客户推荐</option>
										</#if>
										<option value="3" <#if (customerModel.source)?? && customerModel.source==3>selected</#if>>顾问带入</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">所属顾问</label>
								<div class="col-md-10">
									<select name="adviserUserid" class="form-control chzn-select" data-placeholder="请选择顾问" required data-parsley-required-message="顾问不可为空">
										<option value=""></option>
										<#if advisorUsers??>
											<#list advisorUsers as user>
												<#if isEdit && customerModel.adviserUserid?? && customerModel.adviserUserid==user.userid>
													<option value="${user.userid}" selected="selected">${(user.userName)!}</option>
												<#else>
													<option value="${user.userid}">${(user.userName)!}</option>
												</#if>
											</#list>
										</#if>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">所属经纪人</label>
								<div class="col-md-10">
									<select name="belongUserid" class="form-control chzn-select" data-placeholder="请选择经纪人" data-parsley-required-message="所属经纪人不可为空">
										<option value="" selected="selected"></option>
										<#if salesUsers??>
											<#list salesUsers as user>
												<#if isEdit && customerModel.belongUserid?? && customerModel.belongUserid==user.userid>
													<option value="${user.userid}" selected="selected">${(user.userName)!}</option>
												<#else>
													<option value="${user.userid}">${(user.userName)!}</option>
												</#if>
											</#list>
										</#if>
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="col-md-6">
					<div class="panel panel-default">
						<div class="panel-heading">移民意向</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-md-2 control-label">意向国家</label>
								<div class="col-md-10">
									<select multiple class="form-control chzn-select" data-placeholder="请选择意向国家" name="intCountrys" id="intCountry" required data-parsley-required-message="意向国家不可为空">
										<#if countryModels ??>
											<#list countryModels as country>
												<option value="${country.countryId}" ${checked(country.countryId)}>${country.countryName}</option>
											</#list>
										</#if>
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-md-2 control-label">意向项目</label>
								<div class="col-md-10">
									<select multiple class="form-control chzn-select" id="intProducts" name="intProducts" data-placeholder="请选择意向项目" required data-parsley-required-message="意向项目不可为空">
										<#if productList??>
											<#list productList as product>
												<option value="${product.productId}" ${checkedProduct(product.productId)}>${product.name}</option>
											</#list>
										</#if>
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-md-2 control-label">可投资金额</label>
								<div class="col-md-10">
									<select name="invId" class="form-control chzn-select" data-placeholder="请选择可投资金额" required data-parsley-required-message="可投资金额不可为空">
										<#if invAmountTypes ??>
											<#list invAmountTypes as invAmountType>
												<#if isEdit && (customerModel.invId)?? && invAmountType.invId==customerModel.invId>
													<option value="${invAmountType.invId}" selected="selected">${invAmountType.invTypeName}</option>
												<#else>
													<option value="${invAmountType.invId}">${invAmountType.invTypeName}</option>
												</#if>
											</#list>
										</#if>
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-md-2 control-label">移民目的</label>
								<div class="col-md-10">
									<select name="purposeId" multiple class="form-control chzn-select" data-placeholder="请选择移民目的" required data-parsley-required-message="移民目的不可为空">
										<#if purposes??>
											<#list purposes as purpose>
												<option value="${purpose.purposeId}" ${checkedPur(purpose.purposeId)}>${purpose.purposeName}</option>
											</#list>
										</#if>
									</select>
								</div>
							</div>
							
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-6">
					<div class="panel panel-default">
						<div class="panel-heading">跟进方式</div>
						<div class="panel-body">
								<div class="form-group">
									<label class="col-md-2 control-label">跟进方式</label>
									<div class="col-md-10">
										<select name="followType" class="form-control chzn-select" data-placeholder="请选择跟进方式" data-parsley-required-message="跟进方式不可为空">
											<option value=""></option>
											<option value="1" <#if isEdit && (customerModel.followType)?? && customerModel.followType==1>selected="selected"</#if>>直接联系客户</option>
											<option value="2" <#if isEdit && (customerModel.followType)?? && customerModel.followType==2>selected="selected"</#if>>跟客户经理一起</option>
										</select>
									</div>
								</div>
							<div class="form-group">
								<label class="col-md-2 control-label">跟进时间</label>
								<div class="col-md-10">
									<div class="row">
										<#if groupTimeTypes ??>
											<#list groupTimeTypes as groupTimeType>
												<div class="col-lg-6">
													<select name="timeGroup" class="form-control chzn-select" data-placeholder="请选择跟进时间" required data-parsley-required-message="跟进时间不能为空">
														<#list groupTimeType.timeTypes as timeType>
															<option value="${timeType.followTime}|${timeType.groupType}" ${checkedTime(timeType.followTime,timeType.groupType)}>${timeType.followName}</option>
														</#list>
													</select>
												</div>
											</#list>
										</#if>
									</div>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-md-2 control-label">备注</label>
								<div class="col-md-10">
									<textarea name="remark" class="form-control" rows="2">${(customerModel.remark)!}</textarea>
								</div>
							</div>
							
						</div>
					</div>
				</div>
				
				<div class="col-md-6">
					<div class="panel panel-default">
						<div class="panel-heading">补充信息</div>
						<div class="panel-body">
							
							<div class="form-group">
								<label class="col-md-2 control-label">子女信息</label>
								<div class="col-md-10">
									<textarea name="childInfo" class="form-control" rows="5">${(customerModel.childInfo)!}</textarea>
								</div>
							</div>
							
							
						</div>
					</div>
				</div>
			</div>
			<div class="panel-footer text-center">
				<button type="button" class="btn btn-success" id="submitButton">提交</button>
				<button type="button" class="btn btn-default" onclick="javascript:history.go(-1);">取消</button>
			</div>
		</div>
	</form>
</div>
<#function checked countryId>
	<#if (customerModel.intentionCountry)??>
		<#list customerModel.intentionCountry as country>
			<#if country.countryId == countryId>
				<#return "selected='selected'">
				<#break>
			</#if>
		</#list>
	</#if>
	<#return "">   
</#function>
<#function checkedProduct productId>
	<#if (customerModel.intentionProduct)??>
		<#list customerModel.intentionProduct as product>
			<#if product.productId == productId>
				<#return "selected='selected'">
				<#break>
			</#if>
		</#list>
	</#if>
	<#return "">   
</#function>
<#function checkedPur purId>
	<#if (customerModel.purpose)??>
		<#list customerModel.purpose as purpose>
			<#if purpose.purposeId == purId>
				<#return "selected='selected'">
				<#break>
			</#if>
		</#list>
	</#if>
	<#return "">   
</#function>
<#function checkedTime followTime groupType >
	<#if (customerModel.followTime)??>
		<#list customerModel.followTime as timeType>
			<#if timeType.followTime == followTime && timeType.groupType==groupType>
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
		url:"${basePath}/customer/save",
		data:$('#customerForm').serialize(),
		async: false,
		error: function(request) {
		alertify.alert("错误：服务器异常！");
		},
		success: function(data) {
			if(data.success){
				alertify.alert("操作成功！",function(e){location.href="${basePath}/customer/list";});
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
			url:"${basePath}/customer/productJson",
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