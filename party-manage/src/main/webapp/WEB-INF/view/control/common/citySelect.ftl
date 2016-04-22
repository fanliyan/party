<#macro citySelect countryModelList countryControlName="countryId" provinceControlName="provinceId" cityControlName="cityId" notNull=false countryNotNull=false selectedCountryId=0 selectedProvinceId=0  selectedCityId=0>
<div class="col-md-4">
	<select class="form-control chzn-select" name="${countryControlName}" data-placeholder="选择国家" id="${countryControlName}"
	<#if countryNotNull> data-parsley-required="true" data-parsley-required-message="国家不可为空"  data-parsley-errors-container="#countryError"</#if>>
		<option></option>
		<#list countryModelList as model>
			<#if selectedCountryId gt 0 && model.countryId==selectedCountryId>
				<option value="${model.countryId}" selected>${model.countryName}</option>
			<#else>
				<option value="${model.countryId}">${model.countryName}</option>
			</#if>
		</#list>
	</select>
	<ul class="parsley-errors-list filled" id="countryError"><li class="parsley-required"></li></ul>
</div>
<div class="col-md-4">
	<select class="form-control chzn-select" name="${provinceControlName}" data-placeholder="选择省份" id="${provinceControlName}">
		<option></option>
	</select>
</div>
<div class="col-md-4">
	<select class="form-control chzn-select" name="${cityControlName}" data-placeholder="选择城市" id="${cityControlName}" 
	<#if notNull> data-parsley-required="true" data-parsley-required-message="城市不可为空"  data-parsley-errors-container="#cityError"</#if>>
		<option></option>
	</select>
<ul class="parsley-errors-list filled" id="cityError"><li class="parsley-required"></li></ul>
</div>
<script language="javascript">
<#if selectedCityId != 0>
$(function(){
	$.ajax({
		cache: true,
		type: "GET",
		url:"${basePath}/common/getprovinceandcountry?cityId=${selectedCityId}",
		async: false,
		error: function(request) {
			alertify.alert("错误：服务器异常！");
		},
		success: function(data) {
			if(data.success){
				$("#${countryControlName}").val(data.countryId);
				var option = [];
				option.push('<option></option>');
				$.each(data.provinceData,function(index,item){
					option.push('<option value="' + item.provinceId + '">',item.provinceName,'</option>');
				});
				$('#${provinceControlName}').html(option.join(''));
				$('#${provinceControlName}').val(data.province);
				$('#${provinceControlName}').trigger('chosen:updated');
				$('#${provinceControlName}').val(data.provinceId);
				
				option = [];
				option.push('<option></option>');
				$.each(data.cityData,function(index,item){
					option.push('<option value="' + item.cityId + '">',item.cityName,'</option>');
				});
				$('#${cityControlName}').html(option.join(''));
				$('#${cityControlName}').trigger('chosen:updated');
				$('#${cityControlName}').val(${selectedCityId});
			}
			else{
				alertify.alert("错误:" + data.message);
			}
		}
	});
});
<#elseif selectedProvinceId!=0>
$(function(){
	$.ajax({
		cache: true,
		type: "GET",
		url:"${basePath}/common/getprovince?provinceId=${selectedProvinceId}",
		async: false,
		error: function(request) {
			alertify.alert("错误：服务器异常！");
		},
		success: function(data) {
			if(data.success){
				$("#${countryControlName}").val(${selectedCountryId});
				
				var option = [];
				option.push('<option></option>');
				$.each(data.provinceData,function(index,item){
					option.push('<option value="' + item.provinceId + '">',item.provinceName,'</option>');
				});
				$('#${provinceControlName}').html(option.join(''));
				$('#${provinceControlName}').val(data.provinceId);
				$('#${provinceControlName}').trigger('chosen:updated');
				
				option = [];
				option.push('<option></option>');
				$.each(data.cityData,function(index,item){
					option.push('<option value="' + item.cityId + '">',item.cityName,'</option>');
				});
				$('#${cityControlName}').html(option.join(''));
				$('#${cityControlName}').trigger('chosen:updated');
			}
			else{
				alertify.alert("错误:" + data.message);
			}
		}
	});
});
<#elseif selectedCountryId!=0>
$(function(){
	$.ajax({
		cache: true,
		type: "GET",
		url:"${basePath}/common/getprovince?countryId=${selectedCountryId}",
		async: false,
		error: function(request) {
			alertify.alert("错误：服务器异常！");
		},
		success: function(data) {
			if(data.success){
				$("#${countryControlName}").val(${selectedCountryId});
				var option = [];
				option.push('<option></option>');
				$.each(data.data,function(index,item){
					option.push('<option value="' + item.provinceId + '">',item.provinceName,'</option>');
				});
				$('#${provinceControlName}').html(option.join(''));
				$('#${provinceControlName}').val(data.province);
				$('#${provinceControlName}').trigger('chosen:updated');
				$('#${provinceControlName}').val(data.provinceId);
			}
			else{
				alertify.alert("错误:" + data.message);
			}
		}
	});
});
</#if>

$('#${countryControlName}').change(function(){
	var countryId = $(this).val();
	
	$.ajax({
		cache: true,
		type: "GET",
		url:"${basePath}/common/getprovince?countryId=" + countryId,
		async: false,
		error: function(request) {
			alertify.alert("错误：服务器异常！");
		},
		success: function(data) {
			if(data.success){
				var option = [];
				option.push('<option></option>');
				$.each(data.data,function(index,item){
					option.push('<option value="' + item.provinceId + '">',item.provinceName,'</option>');
				});
				$('#${provinceControlName}').html(option.join(''));
				$('#${provinceControlName}').val(data.province);
				$('#${provinceControlName}').trigger('chosen:updated');
				
				option = [];
				option.push('<option></option>');
				$.each(data.data,function(index,item){
					option.push('<option value="' + item.cityId + '">',item.cityName,'</option>');
				});
				$('#${cityControlName}').html(option.join(''));
				$('#${cityControlName}').trigger('chosen:updated');
			}
			else{
				alertify.alert("错误:" + data.message);
			}
		}
	});
});

$('#${provinceControlName}').change(function(){
	var provinceId = $(this).val();
	
	$.ajax({
		cache: true,
		type: "GET",
		url:"${basePath}/common/getcity?provinceId=" + provinceId,
		async: false,
		error: function(request) {
			alertify.alert("错误：服务器异常！");
		},
		success: function(data) {
			if(data.success){
				var option = [];
				option.push('<option></option>');
				$.each(data.data,function(index,item){
					option.push('<option value="' + item.cityId + '">',item.cityName,'</option>');
				});
				$('#${cityControlName}').html(option.join(''));
				$('#${cityControlName}').trigger('chosen:updated');
			}
			else{
				alertify.alert("错误:" + data.message);
			}
		}
	});
});

</script>
</#macro>