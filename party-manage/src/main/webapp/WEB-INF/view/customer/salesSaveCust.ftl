<#import "/master/master-frame.ftl" as master />
<#import "/control/common/citySelect.ftl" as citySelect>
<#if customerModel??>
	<#assign title=["客户","客户管理","编辑客户"]>
	<#assign isEdit=true>
<#else>
	<#assign title=["客户","客户管理","新增客户"]>
	<#assign isEdit=false>
</#if>
<@master.masterFrame pageTitle=title>
<div class="padding-md">
	<div class="row">
		<div class="col-md-6">
			<div class="panel panel-default">
				<div class="panel-heading">客户</div>
				<div class="panel-body">
					<form class="form-horizontal form-border" id="customerForm" >
						<#if isEdit>
							<input type="hidden" name="customerId" value="${customerModel.customerId}"/>
						</#if>
						<div class="form-group">
							<label class="col-lg-2 control-label">客户姓名</label>
							<div class="col-lg-10">
								<input name="name" type="text" class="form-control input-sm" id="" placeholder="必填,字符最大长度20"
								 data-parsley-trigger="blur"
								 data-parsley-required="true"
								 data-parsley-required-message="客户姓名不可为空"
								 data-parsley-maxlength="20"
								 data-parsley-maxlength-message="名字最大不能超过20个字"
								 <#if isEdit>value="${customerModel.name}"</#if>
								/>
							</div><!-- /.col -->
						</div><!-- /form-group -->
						
						<div class="form-group">
							<label class="col-lg-2 control-label">性别</label>
							<div class="col-lg-10">
								<label class="label-radio inline">
									<input type="radio" name="gender" value="M" <#if isEdit><#if customerModel.gender=="M">checked="checked"</#if><#else>checked="checked" </#if>>
									<span class="custom-radio"></span>
									男
								</label>
								<label class="label-radio inline">
									<input type="radio" name="gender" value="F" <#if isEdit && customerModel.gender=="F">checked="checked" </#if>>
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
								 <#if isEdit>value="${customerModel.phone}"</#if>
								/>
							</div><!-- /.col -->
						</div><!-- /form-group -->
						
						<div class="form-group">
							<label class="col-lg-2 control-label">居住城市</label>
							<div class="col-lg-10">
								<#if isEdit>
									<@citySelect.citySelect countryModelList=countryModelList selectedCityId=customerModel.cityId notNull=true/>
								<#else>
									<@citySelect.citySelect countryModelList=countryModelList  notNull=true/>
								</#if>
							</div><!-- /.col -->
						</div><!-- /form-group -->
						
						<div class="form-group">
							<label class="col-lg-2 control-label">意向国家</label>
							<div class="col-lg-10">
								<select multiple class="form-control chzn-select" data-placeholder="请选择意向国家" name="intCountrys" id="intCountry"
								 required data-parsley-required-message="意向国家不可为空"
								 data-parsley-errors-container="#nameError">
									<#if countryModels ??>
										<#list countryModels as country>
											<#assign id="${country.countryId}">
											<#if isEdit>
												<option value="${country.countryId}" ${checked(country.countryId)}>${country.countryName}</option>
											<#else>
												<option value="${country.countryId}">${country.countryName}</option>
											</#if>
										</#list>
									</#if>
								</select>
								<ul class="parsley-errors-list filled" id="nameError"><li class="parsley-required"></li></ul>
							</div><!-- /.col -->
						</div><!-- /form-group -->
						
						<div class="form-group">
							<div class="col-lg-offset-2 col-lg-10">
								<button type="button" class="btn btn-success btn-sm" id="submitButton">保存</button>
								<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1);">取消</button>
							</div><!-- /.col -->
						</div><!-- /form-group -->
					</form>
				</div>
			</div><!-- /panel -->
		</div><!-- /.col -->
	</div>
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
        url:"${basePath}/salesCust/save",
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
</script>
</@master.masterFrame>