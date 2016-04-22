<#macro productFacilitySelect facilityTypeModels selectedValue=0 controlName="" controlAttrValue="" >
<select class="form-control chzn-select" id="${controlName}" name="${controlName}" data-placeholder="设施类型"  ${controlAttrValue}  data-parsley-required-message="请选择设施类型" data-parsley-errors-container="#${controlName}_Error">
	<option value=""></option>
	<#if facilityTypeModels??>
	<#list facilityTypeModels as model>
		<option value="${model.facilityTypeId}" <#if model.facilityTypeId == selectedValue>selected</#if>>${model.facilityTypeName}</option>
	</#list>
	</#if>
</select>
<div id="${controlName}_Error"></div>
</#macro>